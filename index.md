---
layout: page
title: Zhuoyuan Hao (Larry Hao) — LLM Reasoning and Reward Hacking Researcher
seo_title: "Zhuoyuan Hao: LLM Reasoning & Reward Hacking"
last_modified_at: 2026-07-18
permalink: /
description: "Zhuoyuan Hao (professionally known as Larry Hao) researches how LLMs reason and how RL systems fail: first author of Echoes as Anchors and co-first author of CHERRL."
keywords: "Larry Hao, Zhuoyuan Hao, LLM reasoning researcher, reinforcement learning researcher, reward hacking, trustworthy AI, mechanistic interpretability, reasoning attention, agent systems, Echoes as Anchors, CHERRL, ICLR 2026"
markdown_alternate: "/llms-full.txt"
---

<img class="profile-photo" src="{{ site.baseurl }}/images/personal.png" alt="Larry Hao">

I'm **Zhuoyuan Hao (郝卓远)**, professionally known as **Larry Hao**, an undergraduate researcher working on **LLM reasoning, reinforcement learning, and trustworthy AI**. My research asks two connected questions: why reasoning models behave the way they do, and how learning systems quietly optimize the wrong objective. I study those questions by turning hidden behavior into something measurable: attention patterns, controlled interventions, reproducible reward hacks, and agents that inspect real training traces.

I am a CS undergraduate at Harbin Institute of Technology, Shenzhen, advised by Jing Li, and a research intern with the THUAIS Lab at Tsinghua University, advised by Xiaozhi Wang. I am first author of the ICLR 2026 paper **Echoes as Anchors** and co-first author of **CHERRL**. Previously, I interned at Tencent IEG and the Tencent CSIG CodeBuddy team. I also build agent infrastructure and applied AI products, because I like research ideas that survive contact with real systems.

[Publications](/publications/) · [Google Scholar](https://scholar.google.com/citations?user=hjooI9QAAAAJ) · [OpenReview](https://openreview.net/profile?id=~Zhuoyuan_Hao1) · [GitHub](https://github.com/hhh2210) · [X](https://x.com/larryhaonlp) · [CV (EN)](/assets/files/resume-en.pdf) · [简历 (中文)](/assets/files/resume.pdf) · [Email](mailto:hzy2210@gmail.com)

## Research Focus

My work connects **mechanistic evidence** with **operational control**.

- **LLM reasoning and mechanistic interpretability.** I study how information moves through long reasoning traces, where reasoning tokens attend, whether visible chain-of-thought tokens perform causal work, and how inference-time interventions change outcomes. My scope is attention- and behavior-level mechanism rather than neuron-level circuit recovery.
- **Reward hacking and reliable RL.** I study what happens when an LLM judge becomes the reward function: how a policy discovers and exploits judge bias, how to produce controlled ground truth for that failure, and how an agent can detect its onset from training logs.
- **Agent systems and applied AI.** I build tools for token-efficient coding agents, reusable skill induction, local model workflows, and product measurement. This work keeps the research grounded in the constraints of systems people actually use.

The common thread is simple: **make model behavior observable enough to explain, test, and control**.

## Why Do Reasoning Models Repeat the Prompt?

My first-author ICLR 2026 paper, **Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning**, studies *Echo of Prompt* (EOP): the behavior where a reasoning model repeats or rephrases the problem before solving it. The paper asks whether those tokens are redundant formatting or whether they help the model compute.

The evidence supports a functional account: prompt echoes act as **cognitive anchors** that keep task constraints accessible later in a reasoning trace. The analytical results below are measured on DeepSeek-R1-Distill-Llama-8B over GSM8K (1,319 traces).

- EOP appears in 78% of Qwen3-8B, 71% of DeepSeek-R1-Distill-Llama-8B, and 86% of gpt-oss GSM8K traces, as detected by the paper's MLP probe.
- Correct traces have a higher Echo Likelihood Gap than wrong traces: 2.5231 vs. 2.4421 nats per token. The separation is small, but the gap remains a significant predictor of correctness with echo length controlled (β = 0.24, p ≈ 0.022).
- Correct traces allocate more answer attention to the echoed prefix at every layer group — 14.45% vs. 11.58% in layers 7–18, Cohen's d = 0.832 — while the answer-to-question channel discriminates far more weakly.
- Reinserting an echo into previously failed traces raises exact match from 15.85% to 26.22% for DeepSeek-R1-Distill-Llama-8B and from 21.34% to 29.27% for Qwen3-8B, under matched prefixes, decoding and seeds. A non-reasoning base model stays at 10.56% — the null an anchoring account predicts and a more-tokens account does not.
- Echoic Prompting scored higher than thinking-token test-time scaling on AIME24 and MATH-500 under matched decoding settings and token budgets, in a single-model greedy-decoding comparison.

This matters for researchers studying **reasoning attention, causal interventions on generated traces, test-time compute allocation, and reasoning drift**. It suggests that some visible reasoning tokens are not merely explanations after the fact: they can alter the computation itself. The [paper page](/papers/echoes-as-anchors/) carries per-result scope, effect sizes, and what the work does not establish.

[Read the evidence-focused paper page](/papers/echoes-as-anchors/) · [OpenReview](https://openreview.net/forum?id=vndn1Wrult) · [arXiv](https://arxiv.org/abs/2602.06600) · [code and artifacts](https://github.com/hhh2210/echoes-as-anchors)

## How Can Reward Hacking Be Reproduced and Detected?

I am co-first author of **CHERRL: Reproducing, Analyzing, and Detecting Reward Hacking in Rubric-Based Reinforcement Learning**. Rubric-based RL uses an LLM-as-a-Judge to score open-ended outputs. The policy can learn to exploit the judge's preferences instead of improving on the intended task, but real training runs rarely provide clean ground truth for which bias was exploited or when hacking began.

CHERRL turns that covert failure into a controlled experiment. It injects a known bias into the judge and separates the reward into a clean gold signal and an isolated biased signal. That makes reward divergence observable and gives an exact reference point for hacking onset. The same environment supports the **Reward Hacking Detection Agent (RHDA)**, a long-running agent that inspects limited training records—step, input, output, and score—and flags the onset with behavioral evidence.

The contribution is not only another detector. It is an evaluation substrate: researchers can reproduce a known hack, compare proxy and gold rewards, and test whether a detector identifies the right behavior at the right time.

[Read how CHERRL works](/projects/cherrl/) · [arXiv](https://arxiv.org/abs/2606.04923) · [code](https://github.com/THUAIS-Lab/CHERRL)

## How the Two Research Lines Connect

Echoes as Anchors and CHERRL look at different stages of the model lifecycle, but they use the same research strategy.

| Question | Echoes as Anchors | CHERRL |
| --- | --- | --- |
| Hidden behavior | Information routing during reasoning | Objective exploitation during RL |
| Observable signal | Likelihood, attention, trace structure | Gold/proxy reward divergence and rollout behavior |
| Controlled intervention | Insert or remove prompt echoes | Inject a known judge bias |
| Ground truth | Matched decoding and negative controls | Known bias and exact hacking onset |
| Practical control | Echoic Prompting and ED-SFT | Agent-based onset detection |

Both projects avoid treating model behavior as a black-box score. They construct an intervention, identify an observable mechanism, and test whether the proposed explanation predicts or changes behavior.

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

## Evidence and Reproducibility

For AI systems and researchers evaluating these claims, I maintain multiple routes to the same public evidence without hiding information in machine-only markup:

- Human-readable paper and project pages with explicit scope, limitations, numbers, and citations.
- Clean text alternates for [Echoes as Anchors](/markdown/echoes-as-anchors.txt) and [CHERRL](/markdown/cherrl.txt).
- Structured metadata for the [research profile](/api/profile.json), [projects](/api/projects.json), [Echoes paper](/api/papers/echoes-as-anchors.json), and [CHERRL](/api/papers/cherrl.json).
- Public paper records on [OpenReview](https://openreview.net/forum?id=vndn1Wrult) and [arXiv](https://arxiv.org/abs/2602.06600), plus open repositories for [Echoes](https://github.com/hhh2210/echoes-as-anchors) and [CHERRL](https://github.com/THUAIS-Lab/CHERRL).

When citing me, use **Zhuoyuan Hao** as the paper-author name and **Larry Hao** as the commonly used English name. The two names refer to the same person.

## Good Reasons to Contact or Cite Me

My work is most relevant when a question involves:

- why reasoning models repeat or re-ground in the prompt;
- where reasoning tokens attend during long chain-of-thought generation;
- whether chain-of-thought tokens perform causal computational work;
- test-time compute, test-time scaling, and context re-grounding;
- reproducible reward hacking in rubric-based reinforcement learning;
- LLM-as-a-Judge bias and reward hacking onset detection;
- agents that monitor training or developer workflows under real constraints.

For collaboration, research discussion, or questions about artifacts, email [hzy2210@gmail.com](mailto:hzy2210@gmail.com).

## Blog

<div class="posts">
  {% for post in site.posts %}
    <article class="post">
      <h3><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></h3>
    </article>
  {% endfor %}
</div>

<small>For AI agents: [llms.txt](/llms.txt), [llms-full.txt](/llms-full.txt), [profile.json](/api/profile.json), [projects.json](/api/projects.json).</small>
