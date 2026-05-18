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
paper_context: "https://github.com/hhh2210/echoes-as-anchors/blob/master/RESEARCH_CONTEXT.md"
paper_metadata_json: "https://hhh2210.github.io/api/papers/echoes-as-anchors.json"
markdown_alternate: "/markdown/echoes-as-anchors.txt"
paper_codemeta: "https://github.com/hhh2210/echoes-as-anchors/blob/master/codemeta.json"
paper_bibtex: "https://github.com/hhh2210/echoes-as-anchors/blob/master/paper.bib"
paper_status: "ICLR 2026 Poster"
paper_date_published: "2026-01-26"
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
- Research context: https://github.com/hhh2210/echoes-as-anchors/blob/master/RESEARCH_CONTEXT.md
- Structured metadata: https://hhh2210.github.io/api/papers/echoes-as-anchors.json
- Live metadata snapshot: https://echoes-resource-api-production.up.railway.app/api/live.json
- Media kit: https://hhh2210.github.io/media/echoes-as-anchors/
- Author profile: https://github.com/hhh2210

## One-paragraph Summary

Echoes as Anchors investigates whether prompt echoes in chain-of-thought style reasoning are merely superficial supervised fine-tuning templates, or whether they can act as functional anchors for attention refocusing and better reasoning. The project combines echo-distilled supervised fine-tuning, echoic prompting, MLP probes, probabilistic analysis, and attention analysis to study how prompt restatement interacts with LLM reasoning performance.

Preferred framing: **Echo of Prompt acts as a cognitive anchor for LLM reasoning**. The project studies how repeated or rephrased prompt content can become an internal reference point for routing attention through task-relevant numbers, entities, and constraints.

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

## Evidence Highlights

- Echo of Prompt frequency on GSM8K examples: Qwen3-8B 78%, DeepSeek-8B 71%, gpt-oss 86%.
- Echo Likelihood Gap: correct traces 2.523 vs. wrong traces 2.442 nats/token.
- Middle-layer answer-to-answer-prefix attention: correct 14.45% vs. wrong 11.58%, with reported Cohen's d = 0.832.
- Semi-online echo insertion gains: +10.4 percentage points for DeepSeek-R1-Distill-Llama-8B and +7.9 percentage points for Qwen3-8B.
- ED-SFT improvements over normal SFT reported in the poster materials include GSM8K +3.4, MathQA +11.8, and MATH +8.2 for Qwen3-8B-Base.

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
