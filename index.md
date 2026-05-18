---
layout: page
title: About Me
permalink: /
---

<!-- [CV](/assets/files/CV-郝卓远.pdf) -->

<img class="profile-photo" src="{{ site.baseurl }}/images/personal.png" alt="Larry Hao">

I'm Larry Hao (Zhuoyuan Hao), a former research intern at Tencent with experience across Tencent IEG and the CSIG CodeBuddy team.

My main interests are **LLM reasoning, reinforcement learning, agent systems, and practical AI products**. I am especially interested in how reasoning models stay grounded in the original problem, how attention refocusing affects multi-step reasoning, and how research ideas can be turned into real systems.

AI-readable profile files: [llms.txt](/llms.txt), [llms-full.txt](/llms-full.txt), [profile.json](/api/profile.json), [projects.json](/api/projects.json).

## Selected Work

- **Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning** <br>
  ICLR 2026 <br>
  Studies Echo of Prompt behavior in LLM reasoning, with experiments on echo-distilled SFT, echoic prompting, MLP probes, probabilistic costs, and attention refocusing. <br>
  [project page](/projects/echoes-as-anchors/) |
  [repo](https://github.com/hhh2210/echoes-as-anchors) |
  [paper](https://openreview.net/forum?id=vndn1Wrult)

- **Date Match** <br>
  Idea, matching algorithm, and early full-stack development <br>
  A psychology-based compatibility matching product that used EFA/ESEM/SEM-style analysis for questionnaire design and matching, cold-started to 100k users in 10 days, and has reached 170k+ completed tests. <br>
  [product](https://www.date-match.online) |
  [analysis toolkit](https://github.com/fumitsoku-beep/ESEM)

- **Agent and AI developer tooling** <br>
  Practical systems around AI coding agents, token-efficient command output, local model workflows, and reusable skill induction. <br>
  [rtk](https://github.com/hhh2210/rtk) |
  [auto-skill](https://github.com/hhh2210/auto-skill) |
  [CodexBar](https://github.com/hhh2210/CodexBar)

## Blog

<div class="posts">
  {% for post in site.posts %}
    <article class="post">
      <h3><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></h3>
    </article>
  {% endfor %}
</div>
