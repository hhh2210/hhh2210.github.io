---
layout: page
title: About
show_title: false
seo_title: "Zhuoyuan Hao (Larry Hao) — LLM Reasoning & Reward Hacking"
og_title: "Zhuoyuan Hao (Larry Hao) — LLM Reasoning and Reward Hacking Researcher"
last_modified_at: 2026-08-29
permalink: /
description: "Zhuoyuan Hao (Larry Hao) researches how LLMs reason and how RL systems fail: first author of Echoes as Anchors (ICLR 2026) and co-first author of CHERRL."
keywords: "Larry Hao, Zhuoyuan Hao, LLM reasoning researcher, reinforcement learning researcher, reward hacking, trustworthy AI, mechanistic interpretability, reasoning attention, agent systems, Echoes as Anchors, CHERRL, ICLR 2026"
markdown_alternate: "/llms-full.txt"

# ---- Homepage intro: edit these three fields (bio is Markdown) ----
mission: "I study LLMs and love building things"
name_caption: "郝卓远, Larry Hao"
bio: |
  I work on LLM reasoning and reinforcement learning: why reasoning models behave the way they do, and how learning systems quietly optimize the wrong objective.
  Graduated in three years from Harbin Institute of Technology, Shenzhen (HITSZ), advised by [Jing Li](https://www.li-jing.com/).
  Pursuing a 2-year MPhil in Computer Science and Engineering at HKUST, advised by [May Fung](https://mayrfung.github.io/).
  Research intern at the THUAIS Lab, Tsinghua University, advised by [Xiaozhi Wang](https://bakser.github.io/).
---

{% include hero.html %}

<section class="section" id="research" aria-labelledby="selected-heading">
  <h2 id="selected-heading" class="section-label">Selected work</h2>
  {% include selected-work.html %}
</section>

<section class="section" id="experience" aria-labelledby="experience-heading">
  <h2 id="experience-heading" class="section-label">Experience</h2>
  <div class="rule-list">
    {% for role in site.data.experience %}
      {% include experience-row.html item=role %}
    {% endfor %}
  </div>
</section>

<section class="section" id="projects" aria-labelledby="projects-heading">
  <h2 id="projects-heading" class="section-label">Projects</h2>
  <div class="rule-list">
    {% for project in site.data.projects %}
      {% include project-row.html item=project %}
    {% endfor %}
  </div>
</section>

<section class="section" id="writing" aria-labelledby="writing-heading">
  <h2 id="writing-heading" class="section-label">Blog</h2>
  <div class="rule-list">
    {% for post in site.posts %}
      {% include archive-row.html post=post %}
    {% endfor %}
  </div>
</section>
