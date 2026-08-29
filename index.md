---
layout: page
title: About
seo_title: "Zhuoyuan Hao (Larry Hao) — LLM Reasoning & Reward Hacking"
og_title: "Zhuoyuan Hao (Larry Hao) — LLM Reasoning and Reward Hacking Researcher"
last_modified_at: 2026-08-29
permalink: /
description: "Zhuoyuan Hao (Larry Hao) researches how LLMs reason and how RL systems fail: first author of Echoes as Anchors (ICLR 2026) and co-first author of CHERRL."
keywords: "Larry Hao, Zhuoyuan Hao, LLM reasoning researcher, reinforcement learning researcher, reward hacking, trustworthy AI, mechanistic interpretability, reasoning attention, agent systems, Echoes as Anchors, CHERRL, ICLR 2026"
markdown_alternate: "/llms-full.txt"
---

<img class="profile-photo" src="{{ site.baseurl }}/images/personal.png" alt="Zhuoyuan Hao (Larry Hao)">

I am **Zhuoyuan Hao (郝卓远, Larry Hao)**, a CS undergraduate at Harbin Institute of Technology, Shenzhen, advised by Jing Li, and a research intern at the THUAIS Lab, Tsinghua University, advised by Xiaozhi Wang.

I study **LLM reasoning and reinforcement learning**: why reasoning models behave the way they do, and how learning systems quietly optimize the wrong objective.

[Publications](/publications/) · [Google Scholar](https://scholar.google.com/citations?user=hjooI9QAAAAJ) · [GitHub](https://github.com/hhh2210) · [X](https://x.com/larryhaonlp) · [CV](/assets/files/resume-en.pdf) · [Email](mailto:hzy2210@gmail.com)

## Selected work

**Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning**<br>
**Zhuoyuan Hao**, Zhuo Li, Wu Li, Fangming Liu, Min Zhang, Jing Li<br>
ICLR 2026<br>
Why do reasoning models repeat the prompt before solving it? Prompt echoes act as anchors that refocus attention on the task, and reinserting them causally repairs failed reasoning traces.<br>
[paper](https://openreview.net/forum?id=vndn1Wrult) | [arXiv](https://arxiv.org/abs/2602.06600) | [code](https://github.com/hhh2210/echoes-as-anchors) | [project](/papers/echoes-as-anchors/)

**Reproducing, Analyzing, and Detecting Reward Hacking in Rubric-Based Reinforcement Learning**<br>
Xuekang Wang\*, **Zhuoyuan Hao**\*, Shuo Hou, Hao Peng, Juanzi Li, Xiaozhi Wang<br>
arXiv 2026<br>
CHERRL injects a known bias into an LLM judge to make reward hacking reproducible and measurable, with an agent (RHDA) that detects hacking onset from training logs.<br>
[paper](https://arxiv.org/abs/2606.04923) | [code](https://github.com/THUAIS-Lab/CHERRL) | [project](/projects/cherrl/)

## Experience

**Tencent CSIG, CodeBuddy — research intern** (2026)<br>
Agent SFT for coding models: data-mixture design and rubric-based refinement for distilling frontier-model agent traces into an 8B model; train–serve-consistent loss masking for rollout traces (loss only on model-generated tokens).

**Tencent IEG, Technology Operations — research intern** (2025)<br>
LLM post-training for IT-operations (SRE) agents: fault-injection and tool-invocation environments, reward design, SFT-CoT distillation, and synthetic-data selection for continual pre-training. Shipped to IEG's internal operations stack, with a community version open-sourced on ModelScope.

## Projects

- [Date Match](https://date-match.online/) — psychology-based compatibility matching app; co-founder and algorithm lead. 100k+ questionnaires in the first 10 days, 170k+ users in the first month.
- [LiveGalGame](https://github.com/Live-GalGame/LiveGalGame) — fixes the bug that real-life conversations ship without dialogue options: live subtitles, choices, and an affection meter over real conversations. Top-3 contributor (2.5k+ stars).
- [CodexBar](https://github.com/steipete/CodexBar) — macOS menu bar usage stats for OpenAI Codex and Claude Code. Top-10 contributor (20k+ stars).

## Blog

<div class="posts">
  {% for post in site.posts %}
    <article class="post">
      <h3><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></h3>
    </article>
  {% endfor %}
</div>

<small>For AI agents: [llms.txt](/llms.txt) · [llms-full.txt](/llms-full.txt) · [profile.json](/api/profile.json)</small>
