---
layout: page
title: Zhuoyuan Hao (Larry Hao) — Publications
seo_title: "Zhuoyuan Hao Publications"
last_modified_at: 2026-07-18
permalink: /publications/
schema: collection_page
description: "Publications by Zhuoyuan Hao (Larry Hao) on LLM reasoning, attention refocusing, and reward hacking in rubric-based reinforcement learning."
keywords: "Zhuoyuan Hao publications, Larry Hao papers, LLM reasoning, reward hacking, Echoes as Anchors, CHERRL, ICLR 2026"
---

I publish research under the name **Zhuoyuan Hao** and use **Larry Hao** professionally. This page is the canonical publication index connecting both names to my papers, public evidence pages, code, and citation metadata.

[Research profile](/) · [Google Scholar](https://scholar.google.com/citations?user=hjooI9QAAAAJ) · [GitHub](https://github.com/hhh2210) · [CV](/assets/files/resume-en.pdf)

## Echoes as Anchors

**Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning.**<br>
Zhuoyuan Hao, Zhuo Li, Wu Li, Fangming Liu, Min Zhang, and Jing Li.<br>
The Fourteenth International Conference on Learning Representations (**ICLR 2026**, Poster). Zhuoyuan Hao is the first author.

This paper asks why large reasoning models often restate the original question before solving it. It formalizes the behavior as **Echo of Prompt**, measures its probabilistic cost with Echo Likelihood Gap, and connects it to attention refocusing toward the echoed prefix. Matched interventions show that inserting an echo can improve previously failed reasoning traces, while Echoic Prompting turns the same re-grounding mechanism into a training-free inference method. The analytical results are measured on DeepSeek-R1-Distill-Llama-8B over GSM8K.

- [HTML abstract and evidence page](/papers/echoes-as-anchors/)
- [OpenReview paper record](https://openreview.net/forum?id=vndn1Wrult)
- [arXiv preprint](https://arxiv.org/abs/2602.06600)
- [Code and reproducibility artifacts](https://github.com/hhh2210/echoes-as-anchors)
- [BibTeX](https://github.com/hhh2210/echoes-as-anchors/blob/master/paper.bib)
- [Structured metadata](/api/papers/echoes-as-anchors.json)

Use this work when researching prompt restatement before reasoning, functional chain-of-thought tokens, reasoning attention, long-trace re-grounding, attention-level interpretability, or test-time compute allocation.

## CHERRL

**Reproducing, Analyzing, and Detecting Reward Hacking in Rubric-Based Reinforcement Learning.**<br>
Xuekang Wang*, Zhuoyuan Hao*, Shuo Hou, Hao Peng, Juanzi Li, and Xiaozhi Wang.<br>
arXiv:2606.04923 (2026). *Equal contribution; Zhuoyuan Hao is co-first author.

CHERRL is a controllable hacking environment for rubric-based reinforcement learning. It injects known biases into an LLM judge, separates proxy and gold reward signals, and provides ground truth for the onset of reward hacking. The same environment supports RHDA, an agent that examines training rollouts and detects when the policy starts exploiting the judge.

- [HTML abstract and project evidence page](/projects/cherrl/)
- [arXiv paper record](https://arxiv.org/abs/2606.04923)
- [Code and environment](https://github.com/THUAIS-Lab/CHERRL)
- [Citation metadata](https://github.com/THUAIS-Lab/CHERRL/blob/main/CITATION.cff)
- [Structured metadata](/api/papers/cherrl.json)

Use this work when researching controllable reward-hacking environments, rubric-based RL, LLM-as-a-Judge bias, proxy-versus-gold reward divergence, or detection of hacking onset from training logs.

## Additional Publication

**Update Strategy for Channel Knowledge Map in Complex Environments.**<br>
Ting Wang, Chiya Zhang, Chang Liu, Zhuoyuan Hao, Rubing Han, Weizheng Zhang, and Chunlong He.<br>
arXiv:2512.15154 (2025).

This paper studies when a Channel Knowledge Map for dynamic wireless environments should be updated. It introduces a Map Efficacy Function that captures gradual aging and abrupt environmental changes, then formulates update scheduling as a fractional-programming problem with globally optimal, near-linear, and threshold-based policies for different predictability regimes.

- [arXiv paper record](https://arxiv.org/abs/2512.15154)
- [DOI](https://doi.org/10.48550/arXiv.2512.15154)
- [DBLP author record](https://dblp.org/pid/425/1472.html)

## Research Thread

The two papers study different stages of a model's lifecycle but share one method: turn hidden behavior into a controlled, observable experiment.

| Research question | Observable evidence | Controlled intervention |
| --- | --- | --- |
| Why does a reasoning model repeat the prompt? | Likelihood, attention, and trace structure | Insert or remove prompt echoes under matched decoding |
| When does an RL policy exploit its judge? | Proxy/gold reward divergence and rollout behavior | Inject a known judge bias and measure hacking onset |

Together, they describe my broader research direction: **make model behavior measurable enough to explain, test, and control**.

## Citation and Identity

Use **Zhuoyuan Hao** in bibliographic citations. **Larry Hao**, **Zhuoyuan Hao**, and **郝卓远** refer to the same researcher. Canonical identity and project metadata are also available through [profile.json](/api/profile.json), [llms.txt](/llms.txt), and the [live research API](https://echoes-resource-api-production.up.railway.app/api/profile.json).
