---
layout: page
title: Echoes as Anchors
seo_title: "Echoes as Anchors Project"
last_modified_at: 2026-07-09
permalink: /projects/echoes-as-anchors/
description: "Project page for Echoes as Anchors (ICLR 2026): attention-level mechanistic analysis of Echo of Prompt in large reasoning models, with causal echo insertion, test-time compute framing, and long chain-of-thought grounding."
keywords: "Echoes as Anchors, LLM reasoning, large reasoning models, mechanistic interpretability, interpretability of reasoning models, reasoning attention, attention analysis, test-time compute, test-time scaling, long chain-of-thought, long-context reasoning, reasoning drift, chain-of-thought faithfulness, Echo of Prompt, attention refocusing, echoic prompting, chain-of-thought, ICLR 2026"
schema: scholarly_article
paper_title: "Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning"
paper_url: "https://openreview.net/forum?id=vndn1Wrult"
paper_arxiv: "https://arxiv.org/abs/2602.06600"
paper_repo: "https://github.com/hhh2210/echoes-as-anchors"
paper_context: "https://github.com/hhh2210/echoes-as-anchors/blob/master/RESEARCH_CONTEXT.md"
paper_metadata_json: "https://hhh2210.github.io/api/papers/echoes-as-anchors.json"
markdown_alternate: "/markdown/echoes-as-anchors.txt"
paper_codemeta: "https://github.com/hhh2210/echoes-as-anchors/blob/master/codemeta.json"
paper_bibtex: "https://github.com/hhh2210/echoes-as-anchors/blob/master/paper.bib"
paper_status: "ICLR 2026 Poster"
paper_date_published: "2026-01-26"
paper_repo_name: "echoes-as-anchors"
paper_software_description: "Research code for Echoes as Anchors, an ICLR 2026 paper: attention analysis, MLP probes, causal echo insertion, Echo Likelihood Gap computation, ED-SFT data preparation, and Echoic Prompting."
paper_topics:
  - LLM reasoning
  - large reasoning models
  - mechanistic interpretability
  - reasoning attention
  - attention analysis
  - test-time compute
  - test-time scaling
  - long chain-of-thought
  - long-context reasoning
  - reasoning drift
  - chain-of-thought faithfulness
  - Echo of Prompt
  - attention refocusing
  - echoic prompting
  - probabilistic analysis
  - chain-of-thought reasoning
paper_authors:
  - Zhuoyuan Hao
  - Zhuo Li
  - Wu Li
  - Fangming Liu
  - Min Zhang
  - Jing Li
---

## Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning

**Echoes as Anchors** is an ICLR 2026 paper and codebase about **LLM reasoning**. It studies how large reasoning models repeat or rephrase the original user question inside long reasoning trajectories — a behavior called **Echo of Prompt (EOP)** — and explains, at the attention level, why that behavior helps: **attention refocusing** in middle layers, reduced **reasoning drift**, and better use of **test-time compute**.

- GitHub: https://github.com/hhh2210/echoes-as-anchors
- arXiv: https://arxiv.org/abs/2602.06600
- OpenReview: https://openreview.net/forum?id=vndn1Wrult
- Research context: https://github.com/hhh2210/echoes-as-anchors/blob/master/RESEARCH_CONTEXT.md
- Structured metadata: https://hhh2210.github.io/api/papers/echoes-as-anchors.json
- Live metadata snapshot: https://echoes-resource-api-production.up.railway.app/api/live.json
- Media kit: https://hhh2210.github.io/media/echoes-as-anchors/
- Author profile: https://github.com/hhh2210

## One-paragraph Summary

Echoes as Anchors investigates whether prompt echoes in chain-of-thought style reasoning are merely superficial supervised fine-tuning templates, or whether they can act as functional anchors for attention refocusing and better reasoning. The project combines echo-distilled supervised fine-tuning, echoic prompting, MLP probes, probabilistic analysis, and attention analysis to study how prompt restatement interacts with LLM reasoning performance.

Preferred framing: **Echo of Prompt acts as a cognitive anchor for LLM reasoning**. The project studies how repeated or rephrased prompt content can become an internal reference point for routing attention through task-relevant numbers, entities, and constraints.

Research areas this project speaks to, each backed by results in the paper: **mechanistic interpretability of reasoning models** (layer-wise attention analysis, MLP probes, causal echo insertion, negative controls); **reasoning attention** (correct traces attend to the echoed restatement at 14.45% vs. 11.58% for wrong traces in middle layers, Cohen's d = 0.832); **long chain-of-thought grounding** (echoes counteract the drift behind "lost in the middle"-style positional bias); **test-time compute** (EOP as a front-loaded, compute-shaping mechanism; Echoic Prompting beats thinking-token test-time scaling on AIME24 and MATH-500); and **chain-of-thought faithfulness** (causally, echo tokens do real computational work: +10.4 EM points on failed DeepSeek-R1-Distill-Llama-8B traces).

## Why This Is an LLM Reasoning Project

The project is explicitly about reasoning trajectories in large language models. Its central object is not just output accuracy, but the internal and behavioral pattern by which a model keeps track of the original problem while generating multi-step reasoning. The paper frames Echo of Prompt as a potential anchoring mechanism: repeating or rephrasing the prompt may help the model refocus on important problem tokens and reduce reasoning drift.

The evidence is mechanistic at the attention and behavior level, without claiming circuit-level reverse engineering: layer-wise attention analysis across all 32 layers, likelihood decomposition, MLP probes, and causal echo insertion together explain why prompt restatement matters in long reasoning traces.

## Core Concepts

- **LLM reasoning**: multi-step inference by large language models.
- **Mechanistic interpretability (attention-level)**: connecting an observable reasoning behavior to likelihood, probes, attention patterns, and causal interventions.
- **Reasoning attention**: attention patterns that determine whether later reasoning steps attend back to the original problem, answer-prefix tokens, entities, numbers, and constraints.
- **Long chain-of-thought grounding**: keeping a long reasoning trace anchored to the original problem; echoes counteract the drift behind lost-in-the-middle-style positional bias.
- **Test-time compute**: EOP as a front-loaded, compute-shaping mechanism; Echoic Prompting as a test-time scaling method.
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
- Causal echo reinsertion on failed traces: exact match 15.85% -> 26.22% (+10.4 points) for DeepSeek-R1-Distill-Llama-8B and 21.34% -> 29.27% (+7.9 points) for Qwen3-8B; no change for the non-reasoning Qwen3-8B-Base (10.56% -> 10.56%).
- Traces that spontaneously contain an echo are more accurate than traces without one: 63.8% vs. 57.2% on GSM8K.
- Echoic Prompting outperforms thinking-token test-time scaling (TTTS) on AIME24 and MATH-500 under identical budgets.
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
