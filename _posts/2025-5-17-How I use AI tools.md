---
layout: post
title: How I use AI tools
---

这个帖子会随时更新

# Web-Chatbot

相信每个人都有类似的Chatbot需求，定位就是快速响应+多端云同步（+轻量的文件管理）

我经过一圈折腾之后选择了在 LINUX 云服务器（2C 2G 新加坡）上部署 lobechat-db，通过国内中转API调用各家的模型（也有 gemini 和 grok 这种白嫖来的）。

好处是：API随用随付，不用被降智和 20$的月费折磨；消息文件多端同步、lobechat 的知识库也比较好用；本地不挂代理也能流畅访问，利好手机/平板等随手使用的场景。

当然也有坏处：LINUX 云服务器的租赁是比较贵的（点名批评阿里云， 300 的学生试用额度竟然限制只能用国内的服务器，大大滴坏）；自己维护S3存储、身份验证这些有点麻烦（但表扬 lobechat，一键部署脚本很好用）

# AI-Coding
名词：cursor,claude code, openai-codex

使用 AI 编程并不是一个新鲜事儿，最早可以追溯到ChatGPT 刚发布的那一天，不过随着模型能力的增强和使用逻辑的革新，AI-coding 可以说发展日新月异。

大概可以分为三个阶段，分别是：chatbot 时期、AI-IDE、CLI。

## 

