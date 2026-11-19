---
layout: post
title: "修复微信 4.2.0 在 macOS 27.3 原生 arm64 闪退：硬件 TPRO 与 fishhook"
description: "从 _GetBrowsingService 跳到 0x0 的崩溃栈追到 macOS 27.3 dyld 硬件 TPRO 保护，用 11 条 ARM64 指令原位修复微信 4.2.0 加载器并保留原 App Store 主程序签名。"
lang: zh-CN
permalink: /wechat-macos-27-3-tpro/
published: true
---

升到 macOS 27.3 Beta 2（`26C5047e`，Apple Silicon M4）后，微信 4.2.0 在原生 `arm64` 模式下启动即闪退。降级到 4.1.15 或改走 Rosetta 虽然能绕开，但都不是根治。

下面记录这次从崩溃栈一路追到 `/usr/lib/dyld` 硬件 TPRO、再用 11 条 ARM64 指令原位修复的过程。补丁脚本与图表源文件放在 [wechat-macos-tpro-fix](https://github.com/hhh2210/wechat-macos-tpro-fix)。

## 现象与初步排除

Mac App Store 版 `4.2.0 (270416)` 与官网版 `4.2.0.54 (270390)` 的表现完全一致：原生 `arm64` 启动约 1.5 秒即触发 `EXC_BAD_ACCESS (SIGSEGV)`，崩溃点落在 `_GetBrowsingService` 中跳转 `pc = 0x0`。

反汇编 `WeChatAppEx.app/Contents/Frameworks/WeChatAppEx Framework`（大小仅 80 KB）可以看到，它只是一个跳转桩：`_GetBrowsingService` 从 `__DATA,__bss` 槽位 `0x14010` 读出一个函数指针，随后直接 `br x9`。正常情况下，微信自研加载器会把 `Resources/` 下 409 MB 的真实 `WeChatAppEx Framework` 加载进来并填好跳转表；崩溃时该槽位仍是 `0x0`。

这也顺带解释了两个对照现象：

- **4.1.15 启动不崩**：4.1.15 的 `wechat.dylib` 在启动阶段没有同步调用 `_GetBrowsingService`。
- **Rosetta 不崩**：`/usr/lib/dyld` 在检测到翻译执行（`isTranslated`）时会主动关闭内核 page-in linking，绕过了下面提到的保护路径。

## 根因定位：硬件 TPRO 与 fishhook

在 `lldb` 下直接启动 `/Applications/WeChat.app/Contents/MacOS/WeChat`，stderr 立刻打出了决定性线索：

```text
perform_rebinding_with_section vm_protect failed. error code: 2,
trunc address: 0x12ef74000, trunc size: 0x0, section size: 0x4488
```

`0x4488` 正是 `wechat.dylib` 的 `__DATA_CONST,__got` 大小，错误码 `2` 是 `KERN_PROTECTION_FAILURE`。

沿着这条线索反汇编 `/usr/lib/dyld` 和 `libwxld.dylib`，整条因果链就闭合了：

1. **内核与 dyld 启用硬件 TPRO**：在 macOS 27.3 Beta 2（M4）上，`dyld4::ProcessConfig::Process` 从 `apple[]` 启动向量读到 `dyld_hw_tpro` 与 `dyld_hw_tpro_pagers`。随后 `dyld4::Loader::setUpPageInLinking` 映射带有 `SG_READ_ONLY`（`flags = 0x10`）的 `__DATA_CONST` 段时，会向 `__map_with_linking_np` 附加 `MWL_REGION_TPRO`（`0x200`）。
2. **`vm_protect` 被 XNU 拒绝**：在硬件 TPRO 模式下（本机 commpage `*(uint8_t *)0xfffffc10c == 3`），`__DATA_CONST` 的写保护由每线程硬件 APRR 寄存器 `S3_6_C15_C1_5` 控制，而不是传统页表权限。XNU VM 直接拒绝 `vm_protect(..., VM_PROT_READ | VM_PROT_WRITE | VM_PROT_COPY)`（即 `0x13`），返回错误码 `2`。
3. **`fishhook` 提前退出**：微信三个加载器（`libwxld.dylib`、`wcdyf.dylib`、`libappextld.dylib`）都内嵌了 `fishhook`，在 `perform_rebinding_with_section` 里通过 `vm_protect(..., 0x13)` 改写 `__DATA_CONST,__got` 中的 `_dlopen`、`_dlsym`、`_dlclose`。`vm_protect` 失败后它只打一行日志便直接返回。
4. **`dlopen` 掉进空桩**：`wechat.dylib` 启动时调用 `dlopen` 加载 `WeChatAppEx Framework`，因为 GOT 未被挂钩，实际走到了系统 `libdyld` 的 `dlopen`，只映射了 80 KB 空桩，接着调用 `_GetBrowsingService` 便跳转到 `0x0`。

<figure style="margin: 1.5em 0;">
  <a href="{{ '/images/wechat-macos-27-3-tpro/wechat-tpro-crash-and-fix.png' | relative_url }}" aria-label="查看完整机制图"><img src="{{ '/images/wechat-macos-27-3-tpro/wechat-tpro-crash-and-fix.png' | relative_url }}" alt="macOS 27.3 硬件 TPRO 导致 WeChat 4.2.0 fishhook 失败的崩溃路径与 APRR 修复路径对照图" loading="lazy"></a>
  <figcaption style="margin-top: 8px; font-size: 14px; color: #5e5d59; text-align: center;">崩溃路径与修复路径对照。原始可编辑文件见 <a href="https://github.com/hhh2210/wechat-macos-tpro-fix/blob/main/diagrams/wechat-tpro-crash-and-fix.excalidraw">Excalidraw 源文件</a>，点击图片可查看大图。</figcaption>
</figure>

## 11 条指令原位修复

确认根因之后，修法比想象中干净：在 `/usr/lib/dyld` 的 `_dyld_call_with_writable_tpro_memory` 里可以直接看到系统自身切换 TPRO 写权限的方式——从 commpage 读取掩码写入 `S3_6_C15_C1_5`（`0xfffffc0d0` 对应 RW，`0xfffffc0d8` 对应 RO）。本机实测在用户态执行这组指令即可直接写入 `__DATA_CONST`，无需调用 `vm_protect`。

为了不破坏主程序 `Contents/MacOS/WeChat` 的 Apple Mac App Store 签名、`TeamIdentifier`（`5A4RE8SF68`）、App Sandbox 沙盒容器和钥匙串访问权限，**主程序保持零修改**，只对三个加载器动态库（`libwxld.dylib`、`wcdyf.dylib`、`libappextld.dylib`）的 `arm64` 切片做最小原位补丁。

三个加载器的 `perform_rebinding_with_section` 在 `bl vm_protect; cbz w0, <rebind_loop>` 之后，都紧跟着一段恰好 11 条指令的 `fprintf` 报错块。我们直接复用这 11 个指令槽位，不挪动任何段或符号表：

```text
; vm_protect 返回非 0（TPRO 段）时进入：前 6 条指令解锁 TPRO RW
mov   x8, #0xfffff0000
movk  x8, #0xc0d0         ; commpage TPRO RW 掩码
ldr   x8, [x8]
msr   S3_6_C15_C1_5, x8   ; 解锁硬件 TPRO 写权限
isb
b     <rebind_loop>       ; 回到正常的 GOT 重绑定循环

; 循环结束处的 bl mprotect 改为 bl <此处>：后 5 条指令恢复 TPRO RO
mov   x8, #0xfffff0000
movk  x8, #0xc0d8         ; commpage TPRO RO 掩码
ldr   x8, [x8]
msr   S3_6_C15_C1_5, x8   ; 恢复只读
b     <mprotect_stub>     ; 尾调 mprotect 并返回解锁 mutex
```

脚本 [patch_wechat_tpro.py](https://github.com/hhh2210/wechat-macos-tpro-fix/blob/main/patch_wechat_tpro.py) 通过动态定位 `mov w3, #0; mov w4, #0x13; bl vm_protect; cbz w0` 计算所有分支偏移，不依赖写死的地址，只对这三个 `.dylib` 做 ad-hoc 签名。对于 `root:wheel` 属主的 Mac App Store 版微信，利用 APFS COW 克隆即可无额外空间开销地完成替换与保留回滚副本：

```bash
python3 patch_wechat_tpro.py --check
cp -cR /Applications/WeChat.app /tmp/WeChat-patched.app
python3 patch_wechat_tpro.py \
  --app /tmp/WeChat-patched.app --backup-dir ./backups/orig
mv /Applications/WeChat.app /Applications/.WeChat.app.orig
mv /tmp/WeChat-patched.app /Applications/WeChat.app
```

## 验证与适用边界

在 M4 / macOS 27.3 Beta 2（`26C5047e`）上替换后实测：

- `codesign -dvvv /Applications/WeChat.app` 仍保持原 Apple Mac App Store 签名与 `TeamIdentifier=5A4RE8SF68`。
- `WeChat 4.2.0 (270416)` 以原生 `ARM64` 稳定启动，无新增崩溃报告；`vmmap` 确认 409 MB 的 `Resources/WeChatAppEx Framework` 与 `WeChatAppEx`、`NetworkService`、`GPU` 子进程均已正常加载，原有聊天容器数据无损。

需要明确的几条边界条件：

- **TPRO 模式**：上述 commpage 地址与 `S3_6_C15_C1_5` 适用于 commpage 模式 `2/3`（`*(uint8_t *)0xfffffc10c` 为 `2` 或 `3`，已在 M4 `26C5047e` 验证）；脚本会在打补丁前自动校验。
- **SIP 与 AMFI**：因为保留了主程序未关闭 library validation 的 Hardened Runtime，加载仅 ad-hoc 签名的动态库要求本机处于 **SIP 关闭**且 `boot-args` 包含 `amfi_get_out_of_my_way=0x1` 的状态。
- **临时性质**：这只是腾讯在微信加载器里适配 TPRO（或 Apple 调整兼容策略）前的过渡方案。官方修复后，直接切回原包或从 Mac App Store 覆盖安装即可。
