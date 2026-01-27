---
layout: page
title: About Me
permalink: /
---

<!-- [📄 Here's my personanl CV!](/assets/files/CV-郝卓远.pdf) -->

Hi! I'm Larry Hao. You can contact me via email hzy2210@gmail.com

I'm a research intern at Tencent IEG (Summer 2025), where I train large language models (32B scale) and develop intelligent agents for practical deployment.

My research focuses on reinforcement learning, reasoning, and LLM-based applications.

I'm especially interested in bridging the gap between academic research and real-world use cases.

Always open to collaborations in LLM/ML/RL research or projects, feel free to reach out!



## Blog

<div class="posts">
  {% for post in site.posts %}
    <article class="post">
      <h3><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></h3>
    </article>
  {% endfor %}
</div>
