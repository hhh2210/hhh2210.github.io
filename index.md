---
layout: page
title: About Me
permalink: /
---

<!-- [📄 Here's my personanl CV!](/assets/files/CV-郝卓远.pdf) -->

<img class="profile-photo" src="{{ site.baseurl }}/images/personal.png" alt="Larry Hao">

I'm a former research intern at Tencent, with experience in both IEG and CSIG CodeBuddy.

My interests include reinforcement learning, reasoning, and practical LLM systems. I'm particularly interested in bridging research and real-world use cases.

Feel free to reach out if you'd like to collaborate on LLM/ML/RL research or applied projects.

## Selected Work

- **Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning** <br>
  ICLR 2026 submission <br>
  Studies Echo of Prompt behavior in LLM reasoning, with experiments on echo-distilled SFT, echoic prompting, MLP probes, and probabilistic/attention analysis. <br>
  [repo](https://github.com/hhh2210/echoes-as-anchors) |
  [paper](https://openreview.net/forum?id=vndn1Wrult)

- **Date Match** <br>
  Idea, matching algorithm, and early full-stack development <br>
  A psychology-based compatibility matching product that used EFA/ESEM/SEM-style analysis for questionnaire design and matching, cold-started to 100k users in 10 days, and has reached 170k+ completed tests. <br>
  [product](https://www.date-match.online) |
  [analysis toolkit](https://github.com/fumitsoku-beep/ESEM)


## Blog

<div class="posts">
  {% for post in site.posts %}
    <article class="post">
      <h3><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></h3>
    </article>
  {% endfor %}
</div>
