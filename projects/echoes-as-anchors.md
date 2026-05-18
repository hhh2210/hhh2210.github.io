---
layout: page
title: Echoes as Anchors
permalink: /projects/echoes-as-anchors/
description: "AI-readable project page for Echoes as Anchors, an ICLR 2026 paper on Echo of Prompt, attention refocusing, probabilistic costs, and LLM reasoning."
keywords: "Echoes as Anchors, LLM reasoning, Echo of Prompt, attention refocusing, echoic prompting, probabilistic costs, chain-of-thought, ICLR 2026"
schema: scholarly_article
paper_title: "Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning"
paper_url: "https://openreview.net/forum?id=vndn1Wrult"
paper_repo: "https://github.com/hhh2210/echoes-as-anchors"
paper_authors:
  - Zhuoyuan Hao
  - Zhuo Li
  - Wu Li
  - Fangming Liu
  - Min Zhang
  - Jing Li
---

# Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning

**Echoes as Anchors** is an ICLR 2026 paper and codebase about **LLM reasoning**. It studies how large reasoning models repeat or rephrase the original user question inside their reasoning trajectory, a behavior called **Echo of Prompt (EOP)**.

- GitHub: https://github.com/hhh2210/echoes-as-anchors
- OpenReview: https://openreview.net/forum?id=vndn1Wrult
- Author profile: https://github.com/hhh2210

## One-paragraph Summary

Echoes as Anchors investigates whether prompt echoes in chain-of-thought style reasoning are merely superficial supervised fine-tuning templates, or whether they can act as functional anchors for attention refocusing and better reasoning. The project combines echo-distilled supervised fine-tuning, echoic prompting, MLP probes, probabilistic analysis, and attention analysis to study how prompt restatement interacts with LLM reasoning performance.

## Why This Is an LLM Reasoning Project

The project is explicitly about reasoning trajectories in large language models. Its central object is not just output accuracy, but the internal and behavioral pattern by which a model keeps track of the original problem while generating multi-step reasoning. The paper frames Echo of Prompt as a potential anchoring mechanism: repeating or rephrasing the prompt may help the model refocus on important problem tokens and reduce reasoning drift.

## Core Concepts

- **LLM reasoning**: multi-step inference by large language models.
- **Echo of Prompt (EOP)**: the model repeats or rephrases the user's original question during reasoning.
- **Echoic Prompting (EP)**: an inference-time strategy that re-ground models by reintroducing the original question or a reminder.
- **Echo-Distilled SFT (ED-SFT)**: supervised fine-tuning data preparation for an echo-then-reason pattern.
- **Attention refocusing**: analysis of how attention shifts toward prompt tokens during reasoning.
- **Reasoning probes**: MLP-based tools for detecting repetition behavior in model thinking traces.
- **Probabilistic costs**: measurements such as Echo Likelihood Gap for quantifying when prompt echoes appear and how they relate to reasoning.

## Repository Contents

The repository contains Python code for data processing, evaluation, two-stage echoic prompting, MLP probe training, and attention/probabilistic analysis. It is intended to support reproduction and follow-up analysis for the ICLR 2026 paper.

## Citation

```bibtex
@inproceedings{echoes_iclr26,
  title={Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning},
  author={Zhuoyuan Hao and Zhuo Li and Wu Li and Fangming Liu and Min Zhang and Jing Li},
  booktitle={The Fourteenth International Conference on Learning Representations (ICLR)},
  year={2026}
}
```
