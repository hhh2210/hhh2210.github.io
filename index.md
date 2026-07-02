---
layout: page
title: About Me
permalink: /
description: "Larry Hao (Zhuoyuan Hao) researches LLM reasoning and reinforcement learning. First author of Echoes as Anchors (ICLR 2026); co-first author of CHERRL on reward hacking in rubric-based RL."
keywords: "Larry Hao, Zhuoyuan Hao, LLM reasoning, reinforcement learning, reward hacking, agent systems, Echoes as Anchors, CHERRL, ICLR 2026"
---

<img class="profile-photo" src="{{ site.baseurl }}/images/personal.png" alt="Larry Hao">

I'm Larry Hao (Zhuoyuan Hao), a CS undergrad at Harbin Institute of Technology, Shenzhen. I work on **LLM reasoning and reinforcement learning** — why models reason the way they do, and where RL training quietly goes wrong — advised by Jing Li (HITSZ) and Xiaozhi Wang (Tsinghua), as a research intern at THUAIS. Previously I interned at Tencent IEG and the CSIG CodeBuddy team, and I like turning research ideas into real systems.

[Google Scholar](https://scholar.google.com/citations?user=hjooI9QAAAAJ) · [X](https://x.com/larryhaonlp) · [GitHub](https://github.com/hhh2210) · [CV (EN)](/assets/files/resume-en.pdf) · [简历 (中文)](/assets/files/resume-zh.pdf) · [Email](mailto:hzy2210@gmail.com)

## Selected Work

- **Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning** <br>
  ICLR 2026 <br>
  Studies Echo of Prompt behavior in LLM reasoning, with experiments on echo-distilled SFT, echoic prompting, MLP probes, probabilistic costs, and attention refocusing. <br>
  [project page](/projects/echoes-as-anchors/) |
  [repo](https://github.com/hhh2210/echoes-as-anchors) |
  [paper](https://openreview.net/forum?id=vndn1Wrult)

- **CHERRL: A Controllable Hacking Environment for Rubric-Based Reinforcement Learning** <br>
  Co-first author <br>
  A controllable sandbox for reward hacking in rubric-based RL with LLM judges: inject a known judge bias, reproduce the hack cleanly, pin down the exact training step it starts, and have an agent flag the onset from training logs. <br>
  [project page](/projects/cherrl/) |
  [repo](https://github.com/THUAIS-Lab/CHERRL) |
  [paper](https://arxiv.org/abs/2606.04923)

- **Date Match** <br>
  Co-founder and algorithm lead; now incubating at MiraclePlus (YC China) <br>
  A psychology-based compatibility matching product that used EFA/ESEM/SEM-style analysis for questionnaire design and matching, cold-started to 100k users in 10 days, and has reached 170k+ completed tests. <br>
  [product](https://www.date-match.online) |
  [analysis toolkit](https://github.com/fumitsoku-beep/ESEM)

- **Agent and AI developer tooling** <br>
  Practical systems around AI coding agents, token-efficient command output, local model workflows, and reusable skill induction. <br>
  [rtk](https://github.com/hhh2210/rtk) |
  [auto-skill](https://github.com/hhh2210/auto-skill) |
  [CodexBar](https://github.com/steipete/CodexBar)

## Blog

<div class="posts">
  {% for post in site.posts %}
    <article class="post">
      <h3><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></h3>
    </article>
  {% endfor %}
</div>

<small>For AI agents: [llms.txt](/llms.txt), [llms-full.txt](/llms-full.txt), [profile.json](/api/profile.json), [projects.json](/api/projects.json).</small>
