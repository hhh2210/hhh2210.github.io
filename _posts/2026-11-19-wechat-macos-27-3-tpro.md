---
layout: post
title: "微信 4.2.0 在 macOS 27.3 原生 arm64 闪退：硬件 TPRO 与 fishhook"
description: "排查微信 4.2.0 在 macOS 27.3 Beta 2 (M4) 原生 arm64 下启动即崩的原因：dyld 启用硬件 TPRO 导致 fishhook 的 vm_protect 失败，并用 11 条 ARM64 指令原位修复。"
lang: zh-CN
permalink: /wechat-macos-27-3-tpro/
published: true
---

升到 macOS 27.3 Beta 2（`26C5047e`，M4）后，微信 4.2.0 在原生 `arm64` 下启动不到两秒就闪退。问题不在微信业务代码，而是 macOS 27.3 在 M4 上给 `__DATA_CONST` 启用了硬件 TPRO，把微信加载器里的 `fishhook` 拦住了。

为了继续原生跑 4.2.0 而不是退回 4.1.15 或开 Rosetta，我只改了三个加载器动态库里的 11 条 ARM64 指令，保留了主程序的 Mac App Store 签名。补丁脚本和图表源文件放在 [wechat-macos-tpro-fix](https://github.com/hhh2210/wechat-macos-tpro-fix)。

## 崩溃现场

Mac App Store 版 `4.2.0 (270416)` 和官网版 `4.2.0.54 (270390)` 的崩溃栈一致：主线程在 `_GetBrowsingService` 中执行 `br x9` 跳转到 `pc = 0x0`，触发 `EXC_BAD_ACCESS (SIGSEGV)`。

反汇编 `WeChatAppEx.app/Contents/Frameworks/WeChatAppEx Framework`（大小只有 80 KB）可以看到，它本身只是一个跳转桩。`_GetBrowsingService` 会从 `__DATA,__bss` 的 `0x14010` 槽位读取真实函数地址再跳转，而崩溃时整个跳转表全是 `0`。真正的实现在 `Resources/` 下 409 MB 的同名动态库里。

4.1.15 和 Rosetta 都没触发，原因各不相同：4.1.15 的 `wechat.dylib` 在启动阶段不会同步调 `_GetBrowsingService`；Rosetta 下 `/usr/lib/dyld` 检测到翻译执行（`isTranslated`）后会主动关掉内核 page-in linking，恰好绕过了下面的保护机制。

## 硬件 TPRO 与 fishhook

在 `lldb` 里直接跑 `/Applications/WeChat.app/Contents/MacOS/WeChat`，stderr 马上吐出一条报错：

```text
perform_rebinding_with_section vm_protect failed. error code: 2,
trunc address: 0x12ef74000, trunc size: 0x0, section size: 0x4488
```

`0x4488` 正是 `wechat.dylib` 里 `__DATA_CONST,__got` 的大小，错误码 `2` 是 `KERN_PROTECTION_FAILURE`。

顺着 `/usr/lib/dyld` 往下翻，`dyld4::ProcessConfig::Process` 会从内核的 `apple[]` 向量读取 `dyld_hw_tpro` 和 `dyld_hw_tpro_pagers`。随后 `dyld4::Loader::setUpPageInLinking` 映射带有 `SG_READ_ONLY`（`flags = 0x10`）的 `__DATA_CONST` 段时，会给 `__map_with_linking_np` 加上 `MWL_REGION_TPRO`（`0x200`）。在这台 M4 上（commpage `*(uint8_t *)0xfffffc10c == 3`），这些页的写保护改由每线程硬件 APRR 寄存器 `S3_6_C15_C1_5` 控制，XNU VM 直接拒绝传统 `vm_protect(..., VM_PROT_READ | VM_PROT_WRITE | VM_PROT_COPY)`（`0x13`）。

微信三个加载器（`libwxld.dylib`、`wcdyf.dylib`、`libappextld.dylib`）都用 `fishhook` 改写 `__DATA_CONST,__got` 里的 `_dlopen`、`_dlsym`、`_dlclose`，用来把对空桩框架的 `dlopen` 重定向到 `Resources/` 下的真实库。`vm_protect` 返回错误码 `2` 后，`perform_rebinding_with_section` 打完上面那行日志就直接退出了。结果 `wechat.dylib` 启动时调用了系统 `libdyld` 的 `dlopen`，只映射了 80 KB 空桩，接着一调 `_GetBrowsingService` 就掉进 `0x0`。

<figure style="margin: 1.5em 0;">
  <a href="{{ '/images/wechat-macos-27-3-tpro/wechat-tpro-crash-and-fix.png' | relative_url }}" aria-label="查看完整机制图"><img src="{{ '/images/wechat-macos-27-3-tpro/wechat-tpro-crash-and-fix.png' | relative_url }}" alt="macOS 27.3 硬件 TPRO 导致 WeChat 4.2.0 fishhook 失败的崩溃路径与 APRR 修复路径对照图" loading="lazy"></a>
  <figcaption style="margin-top: 8px; font-size: 14px; color: #5e5d59; text-align: center;">崩溃路径与修复路径对照。原始文件见 <a href="https://github.com/hhh2210/wechat-macos-tpro-fix/blob/main/diagrams/wechat-tpro-crash-and-fix.excalidraw">Excalidraw 源文件</a>，点击图片可查看大图。</figcaption>
</figure>

## 11 条指令原位修复

`/usr/lib/dyld` 的 `_dyld_call_with_writable_tpro_memory` 里能直接看到系统切换 TPRO 写权限的做法：从 commpage 读出掩码写入 `S3_6_C15_C1_5`，`0xfffffc0d0` 切到 RW，`0xfffffc0d8` 切回 RO。在用户态执行这几条指令就能直接改写 `__DATA_CONST`，不需要过 `vm_protect`。

为了保住主程序 `Contents/MacOS/WeChat` 的 Apple Mac App Store 签名、`TeamIdentifier`（`5A4RE8SF68`）、沙盒容器和钥匙串权限，主程序一字节不动，只改三个加载器动态库的 `arm64` 切片。三份代码在 `bl vm_protect; cbz w0, <rebind_loop>` 后面都紧跟着一段恰好 11 条指令的 `fprintf` 报错分支，直接覆盖这 11 个槽位就行，不用挪段也不用动符号表：

```text
; vm_protect 返回非 0（TPRO 段）时进入：前 6 条解锁 TPRO RW
mov   x8, #0xfffff0000
movk  x8, #0xc0d0         ; commpage TPRO RW 掩码
ldr   x8, [x8]
msr   S3_6_C15_C1_5, x8
isb
b     <rebind_loop>

; 循环结束处的 bl mprotect 改为 bl <此处>：后 5 条恢复 TPRO RO
mov   x8, #0xfffff0000
movk  x8, #0xc0d8         ; commpage TPRO RO 掩码
ldr   x8, [x8]
msr   S3_6_C15_C1_5, x8
b     <mprotect_stub>     ; 尾调 mprotect 并返回解锁 mutex
```

[patch_wechat_tpro.py](https://github.com/hhh2210/wechat-macos-tpro-fix/blob/main/patch_wechat_tpro.py) 会动态定位 `mov w3, #0; mov w4, #0x13; bl vm_protect; cbz w0` 并重算分支偏移，打完补丁只对这三个 `.dylib` 做 ad-hoc 签名。Mac App Store 装的 `/Applications/WeChat.app` 属主是 `root:wheel`，用 APFS COW 克隆一份改完再同目录换名，既不占额外空间，也能留一个 `.WeChat.app.orig` 随时回滚：

```bash
python3 patch_wechat_tpro.py --check
cp -cR /Applications/WeChat.app /tmp/WeChat-patched.app
python3 patch_wechat_tpro.py \
  --app /tmp/WeChat-patched.app --backup-dir ./backups/orig
mv /Applications/WeChat.app /Applications/.WeChat.app.orig
mv /tmp/WeChat-patched.app /Applications/WeChat.app
```

替换后微信 4.2.0 在这台 M4 上正常以原生 `ARM64` 启动，`codesign -dvvv` 仍显示原 Apple Mac App Store 签名，`vmmap` 里能看到 409 MB 的 `Resources/WeChatAppEx Framework` 和各个 Helper 子进程全部拉起，聊天记录无损。

补一句前提：因为保留了主程序未关闭 library validation 的 Hardened Runtime，加载仅 ad-hoc 签名的动态库要求本机关闭 SIP 且 `boot-args` 带 `amfi_get_out_of_my_way=0x1`；这套 commpage 掩码也只对应 TPRO 模式 `2/3`（脚本打补丁前会自动检查）。等腾讯更新加载器里的 `fishhook` 后，切回原包或直接覆盖安装即可。
