---
layout: page
title: About Me
permalink: /
---

<!-- [📄 Here's my personanl CV!](/assets/files/CV-郝卓远.pdf) -->

I am a student at HIT(SZ) and a intern in TEG-tencent.

🔭 I'm currently working on LLL-knowledge:Knowledge Graph,Reasoning,Agent and LLM-based applications.

🌱 I'm currently learning LLM-based applications.

👯 I'm looking to collaborate on LLM-based applications and related research

## Blog

<div class="posts">
  {% for post in site.posts %}
    <article class="post">
      <h3><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></h3>
    </article>
  {% endfor %}
</div>
