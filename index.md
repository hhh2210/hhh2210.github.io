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
