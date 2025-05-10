---
layout: page
title: About
permalink: /
---

[📄 查看/下载我的简历](/assets/files/CV.pdf)

I am a student at HIT(SZ)

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
