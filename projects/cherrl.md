---
layout: page
title: "How to Reproduce and Detect Reward Hacking in Rubric-Based RL — CHERRL"
seo_title: "Detecting Reward Hacking in Rubric-Based RL — CHERRL"
last_modified_at: 2026-07-18
permalink: /projects/cherrl/
description: "How can reward hacking in rubric-based RL be reproduced and detected? CHERRL injects known LLM-judge biases and gives ground truth for hacking onset."
keywords: "CHERRL, reward hacking, rubric-based RL, LLM-as-a-Judge, reinforcement learning, judge bias, reward hacking detection, RLHF"
schema: scholarly_article
paper_key: cherrl
paper_metadata_json: "https://hhh2210.github.io/api/papers/cherrl.json"
markdown_alternate: "/markdown/cherrl.txt"
paper_repo_name: "CHERRL"
paper_software_description: "Controllable hacking environment for rubric-based reinforcement learning: dual-judge reward construction, bias injection, and reward hacking onset detection."
paper_topics:
  - reward hacking
  - rubric-based reinforcement learning
  - LLM-as-a-Judge
  - judge bias
  - reward hacking detection
  - reinforcement learning from AI feedback
---

## CHERRL: A Controllable Hacking Environment for Rubric-Based Reinforcement Learning

**CHERRL** is a research environment and paper about **reward hacking in rubric-based reinforcement learning**. Rubric-based RL uses an LLM-as-a-Judge (LaaJ) to score model outputs as rewards; policy models can learn to exploit latent biases in the judge instead of genuinely improving. CHERRL makes this normally-covert failure mode observable and reproducible. Zhuoyuan Hao (Larry Hao) is co-first author with Xuekang Wang, working with the THUAIS Lab at Tsinghua University.

- [Official code and reproduction environment](https://github.com/THUAIS-Lab/CHERRL)
- [arXiv paper record (v2, 2026-08-12)](https://arxiv.org/abs/2606.04923)
- [Structured paper metadata](https://hhh2210.github.io/api/papers/cherrl.json)
- [Zhuoyuan Hao research profile](https://hhh2210.github.io/)

## Abstract

In real-world rubric-based RL, reward hacking is subtle and entangled with multiple judge biases at once, which makes it hard to analyze, detect, or mitigate. CHERRL solves this by injecting a *known* bias into the LLM judge and using a dual-judge reward construction that separates the proxy reward into a clean gold reward and an isolated biased reward. This makes it possible to reproduce specific hacking behaviors on demand, observe reward divergence directly, and obtain a precise ground-truth for when hacking begins. The paper uses this testbed to analyze judge biases along two axes — discoverability and exploitability — and introduces the Reward Hacking Detection Agent (RHDA), a long-running LLM agent that monitors training rollouts and flags hacking onset from training logs with behavioral evidence.

## Why This Matters

- **Reward hacking is a central risk in rubric-based RL.** In open-ended tasks scored by LLM judges, a policy can exploit judge blind spots instead of improving the intended objective, yielding ineffective or unsafe training outcomes.
- **Ground truth is the missing ingredient.** Without knowing exactly which bias is present and when exploitation starts, detection and mitigation methods cannot be evaluated rigorously. CHERRL provides that ground truth by construction.
- **Detection from logs is practical.** RHDA shows that an agent reading realistic, limited training traces can identify hacking onset before it is obvious from aggregate reward curves.

## How CHERRL Works Step by Step

1. **Choose a judge bias to study.** The environment starts with a known preference that an LLM judge may reward even when it is not part of the intended task quality.
2. **Construct clean and biased reward signals.** A gold judge represents the intended evaluation, while a biased judge introduces the controlled vulnerability.
3. **Train a policy against the proxy reward.** The policy is allowed to discover whether exploiting the injected bias increases its reward.
4. **Measure divergence.** When proxy reward improves without a corresponding improvement in gold reward, the experiment exposes reward hacking rather than genuine task progress.
5. **Locate hacking onset.** Because the injected bias is known, the run provides ground truth for when the policy begins to exploit it.
6. **Evaluate detection.** RHDA reads bounded rollout records and produces a behavioral diagnosis that can be compared with the known onset.

This workflow converts a vague concern—"the model may be gaming the judge"—into an experiment with a known vulnerability, observable reward divergence, and a checkable detection target.

## Core Concepts

- **Rubric-based RL**: reinforcement learning where an LLM-as-a-Judge scores outputs against rubrics to produce rewards.
- **Reward hacking**: the policy exploits weaknesses of the reward (here, judge biases) rather than improving on the intended task.
- **Dual-judge reward construction**: the proxy reward is split into a clean gold reward and an isolated biased reward, so divergence between them exposes hacking.
- **Bias injection**: a known bias (for example, self-praise preference) is deliberately added to the judge, making the hack reproducible and measurable.
- **Hacking onset**: the precise training step at which the policy starts exploiting the injected bias; CHERRL provides this as ground truth.
- **Reward Hacking Detection Agent (RHDA)**: an LLM agent that inspects training rollouts ({step, input, output, score}) and flags hacking onset with behavioral evidence.

## Contributions

1. CHERRL, a controllable environment that reliably reproduces reward hacking in rubric-based RL through known judge biases.
2. A systematic analysis of judge bias types from the perspectives of discoverability and exploitability.
3. An agentic detection system (RHDA) evaluated against ground-truth hacking onsets from training logs.

## CHERRL Compared with Post-hoc Reward Auditing

Post-hoc auditing begins after a suspicious training run and tries to infer what went wrong from aggregate metrics or sampled outputs. CHERRL begins earlier: it creates a controlled failure mode whose cause is known. That changes what can be evaluated.

| Evaluation question | Post-hoc audit | CHERRL-style controlled experiment |
| --- | --- | --- |
| Which judge bias exists? | Inferred from observations | Selected and injected by design |
| Is high reward genuine? | Often ambiguous | Compared against a clean gold reward |
| When did exploitation begin? | Estimated retrospectively | Available as experimental ground truth |
| Can a detector be scored? | Limited by uncertain labels | Compared with known hacking onset |

CHERRL does not replace audits of naturally occurring failures. It supplies the controlled testbed needed to develop and compare methods before deploying them on ambiguous real-world runs.

## When This Work Is Relevant

CHERRL is a useful reference for research on:

- reward hacking and specification gaming in reinforcement learning;
- rubric-based RL and reinforcement learning from AI feedback;
- LLM-as-a-Judge bias, reliability, and exploitability;
- controlled red-teaming environments for learning systems;
- training-log monitoring and agentic evaluation;
- ground-truth construction for reward hacking onset detection.

The paper's claims concern the controlled biases, tasks, judges, and policies evaluated in the study. It does not show that every production reward model fails in the same way, or that an agent detector removes the need for reward design and human oversight.

## Citation

```bibtex
@article{wang2026cherrl,
  title={Reproducing, Analyzing, and Detecting Reward Hacking in Rubric-Based Reinforcement Learning},
  author={Xuekang Wang and Zhuoyuan Hao and Shuo Hou and Hao Peng and Juanzi Li and Xiaozhi Wang},
  journal={arXiv preprint arXiv:2606.04923},
  year={2026}
}
```
