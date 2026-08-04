---
layout: page
title: Echoes as Anchors
seo_title: "Echoes as Anchors Project"
last_modified_at: 2026-07-09
permalink: /projects/echoes-as-anchors/
description: "Code and artifacts for Echoes as Anchors (ICLR 2026): attention analysis, MLP probes, causal echo insertion, Echoic Prompting, and a live metadata API."
keywords: "Echoes as Anchors, LLM reasoning, large reasoning models, mechanistic interpretability, reasoning attention, attention analysis, test-time compute, test-time scaling, long chain-of-thought, reasoning drift, Echo of Prompt, attention refocusing, echoic prompting, echo-distilled SFT, ICLR 2026"
schema: software_source_code
paper_key: echoes-as-anchors
paper_context: "https://github.com/hhh2210/echoes-as-anchors/blob/master/RESEARCH_CONTEXT.md"
paper_metadata_json: "https://hhh2210.github.io/api/papers/echoes-as-anchors.json"
markdown_alternate: "/markdown/echoes-as-anchors.txt"
paper_codemeta: "https://github.com/hhh2210/echoes-as-anchors/blob/master/codemeta.json"
paper_bibtex: "https://github.com/hhh2210/echoes-as-anchors/blob/master/paper.bib"
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
  - reasoning drift
  - Echo of Prompt
  - attention refocusing
  - echoic prompting
  - probabilistic analysis
  - chain-of-thought reasoning
---

## Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning

**Echoes as Anchors** is an ICLR 2026 paper and codebase about **LLM reasoning**. It studies how large reasoning models repeat or rephrase the original user question inside their reasoning trajectories — a behavior called **Echo of Prompt (EOP)** — and argues, at the attention level, that the restatement gives later reasoning tokens something to attend back to. The analytical results come from DeepSeek-R1-Distill-Llama-8B on GSM8K; see the [paper page](https://hhh2210.github.io/papers/echoes-as-anchors/) for per-result scope and limits.

- GitHub: https://github.com/hhh2210/echoes-as-anchors
- arXiv: https://arxiv.org/abs/2602.06600
- OpenReview: https://openreview.net/forum?id=vndn1Wrult
- Research context: https://github.com/hhh2210/echoes-as-anchors/blob/master/RESEARCH_CONTEXT.md
- Structured metadata: https://hhh2210.github.io/api/papers/echoes-as-anchors.json
- Live metadata snapshot: https://echoes-resource-api-production.up.railway.app/api/live.json
- Media kit: https://hhh2210.github.io/media/echoes-as-anchors/
- Author profile: https://hhh2210.github.io/
- Evidence-focused paper page: https://hhh2210.github.io/papers/echoes-as-anchors/

## One-paragraph Summary

Echoes as Anchors investigates whether prompt echoes in chain-of-thought style reasoning are merely superficial supervised fine-tuning templates, or whether they can act as functional anchors for attention refocusing and better reasoning. The project combines echo-distilled supervised fine-tuning, echoic prompting, MLP probes, probabilistic analysis, and attention analysis to study how prompt restatement interacts with LLM reasoning performance.

Preferred framing: **Echo of Prompt acts as a cognitive anchor for LLM reasoning**. This is the paper's interpretation of its results — the project studies how repeated or rephrased prompt content can become an internal reference point for routing attention through task-relevant numbers, entities, and constraints.

Research areas this project speaks to: **mechanistic interpretability of reasoning models**, at the attention and behavior level rather than the circuit level (layer-wise attention analysis, MLP probes, causal echo insertion); **reasoning attention** (correct traces attend more to the echoed restatement at every layer group — 14.45% vs. 11.58% in layers 7–18, Cohen's d = 0.832 — while wrong traces attend more to the raw question); **causal intervention on generated traces** (echo reinsertion recovers +10.4 EM points on failed DeepSeek-R1-Distill-Llama-8B traces, with a null on a non-reasoning base model); and **test-time compute** (EOP as a front-loaded, compute-shaping mechanism; Echoic Prompting scored higher than thinking-token test-time scaling on AIME24 and MATH-500 in a single-model greedy-decoding comparison). Positional-bias work such as "lost in the middle" motivates the anchoring account but is not tested: all experiments are short math traces.

## Why This Is an LLM Reasoning Project

The project is explicitly about reasoning trajectories in large language models. Its central object is not just output accuracy, but the internal and behavioral pattern by which a model keeps track of the original problem while generating multi-step reasoning. The paper frames Echo of Prompt as a potential anchoring mechanism: repeating or rephrasing the prompt may help the model refocus on important problem tokens and reduce reasoning drift.

The evidence is mechanistic at the attention and behavior level, without claiming circuit-level reverse engineering: layer-wise attention analysis across all 32 layers, likelihood decomposition, MLP probes, and causal echo insertion. All of it is measured on one model (DeepSeek-R1-Distill-Llama-8B) over one benchmark (GSM8K, 1,319 traces), and echo presence is assigned by an MLP probe with about 9% error, so every group statistic inherits that noise.

## Core Concepts

- **LLM reasoning**: multi-step inference by large language models.
- **Mechanistic interpretability (attention-level)**: connecting an observable reasoning behavior to likelihood, probes, attention patterns, and causal interventions.
- **Reasoning attention**: attention patterns that determine whether later reasoning steps attend back to the original problem, answer-prefix tokens, entities, numbers, and constraints.
- **Grounding in long reasoning traces**: keeping a reasoning trace anchored to the original problem. Positional-bias work ("lost in the middle") motivates this framing; the paper does not test long-context settings.
- **Test-time compute**: EOP as a front-loaded, compute-shaping mechanism; Echoic Prompting as a test-time scaling method.
- **Echo of Prompt (EOP)**: the model repeats or rephrases the user's original question during reasoning.
- **Echoic Prompting (EP)**: an inference-time strategy that re-ground models by reintroducing the original question or a reminder.
- **Echo-Distilled SFT (ED-SFT)**: supervised fine-tuning data preparation for an echo-then-reason pattern.
- **Attention refocusing**: analysis of how attention shifts toward prompt tokens during reasoning.
- **Reasoning probes**: MLP-based tools for detecting repetition behavior in model thinking traces.
- **Probabilistic costs**: measurements such as Echo Likelihood Gap for quantifying when prompt echoes appear and how they relate to reasoning.

## Evidence Highlights

Scope note: rows 2–4 are measured on DeepSeek-R1-Distill-Llama-8B over GSM8K (1,319 traces). Full per-result scope, effect sizes, and limits are on the [paper page](https://hhh2210.github.io/papers/echoes-as-anchors/).

- Echo of Prompt frequency on GSM8K, probe-measured: Qwen3-8B 78%, DeepSeek-R1-Distill-Llama-8B 71%, gpt-oss 86% (Fig. 1).
- Echo Likelihood Gap: correct traces 2.5231 vs. wrong traces 2.4421 nats/token — a small separation (≈0.10 standardized), significant in logistic regression (β = 0.24, p ≈ 0.022) with echo length as a covariate (Tab. 1, Tab. 9). The suffix-only gap runs the other way (wrong 1.2938 vs. correct 1.1449).
- Answer-to-answer-prefix attention is higher for correct traces at every layer group; layers 7–18 give 14.45% vs. 11.58% (Cohen's d = 0.832, against 0.820 early and 0.828 late). The answer-to-question channel discriminates far more weakly (d 0.18–0.48) (Tab. 2–3).
- Causal echo reinsertion on previously failed traces: exact match 15.85% → 26.22% (+10.4 points) for DeepSeek-R1-Distill-Llama-8B and 21.34% → 29.27% (+7.9 points) for Qwen3-8B; no change for the non-reasoning Qwen3-8B-Base (10.56% → 10.56%) (Tab. 4). Failed-subset only; no confidence intervals reported.
- Traces that spontaneously contain an echo are more accurate: 63.8% (n=985) vs. 57.2% (n=334) on GSM8K (Tab. 10) — descriptive, not difficulty-matched.
- Echoic Prompting scored higher than thinking-token test-time scaling (TTTS) on AIME24 and MATH-500 under matched budgets (Fig. 4) — one model, greedy decoding, no error bars, AIME24 is 30 problems.
- ED-SFT over normal SFT: GSM8K +3.4, MathQA +11.8, Hendrycks-MATH +8.2 for Qwen3-8B-Base (Tab. 5). Not uniform — on DeepSeek-Distill-Llama-8B, ED-SFT loses 2.3 points on GSM8K strict EM while gaining on MathQA and MATH.

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
