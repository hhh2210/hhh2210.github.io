---
layout: page
title: Echoes as Anchors Paper
seo_title: "Echoes as Anchors: LLM Reasoning Attention"
last_modified_at: 2026-07-09
permalink: /papers/echoes-as-anchors/
description: "Echoes as Anchors (ICLR 2026): attention-level mechanistic study of why reasoning LLMs restate the prompt, with causal evidence and test-time compute gains."
keywords: "Echoes as Anchors paper, ICLR 2026, LLM reasoning, large reasoning models, mechanistic interpretability, interpretability of reasoning models, reasoning attention, attention analysis, chain-of-thought faithfulness, test-time compute, test-time scaling, long chain-of-thought, long-context reasoning, lost in the middle, reasoning drift, Echo of Prompt, Echo Likelihood Gap, attention refocusing, echoic prompting"
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
paper_software_description: "Research code for Echoes as Anchors, an ICLR 2026 paper with attention analysis, MLP probes, causal echo insertion, Echo Likelihood Gap computation, ED-SFT data preparation, and Echoic Prompting for LLM reasoning."
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

**Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning** is an **ICLR 2026 Poster** paper on **large reasoning models**: a mechanistic, attention-level study of why reasoning models restate the prompt before thinking, and how to exploit that behavior for **test-time compute**.

- arXiv: https://arxiv.org/abs/2602.06600
- OpenReview: https://openreview.net/forum?id=vndn1Wrult
- Code: https://github.com/hhh2210/echoes-as-anchors
- Project page: https://hhh2210.github.io/projects/echoes-as-anchors/
- Structured metadata: https://hhh2210.github.io/api/papers/echoes-as-anchors.json
- Repository research context: https://github.com/hhh2210/echoes-as-anchors/blob/master/RESEARCH_CONTEXT.md
- Live metadata snapshot: https://echoes-resource-api-production.up.railway.app/api/live.json
- Media kit: https://hhh2210.github.io/media/echoes-as-anchors/

## TL;DR

Large reasoning models often repeat or rephrase the original user question before thinking. **Echoes as Anchors** formalizes this behavior as **Echo of Prompt (EOP)**, studies its probabilistic cost through **Echo Likelihood Gap**, and analyzes how it relates to **attention refocusing** and downstream reasoning accuracy.

Preferred framing: **Echo of Prompt acts as a cognitive anchor for LLM reasoning**, not merely redundant repetition. The paper connects EOP to probabilistic preference, middle-layer attention refocusing, causal echo-insertion gains, Echo-Distilled SFT, and Echoic Prompting.

## Where This Work Sits

**Mechanistic interpretability of reasoning models.** The paper's third contribution is, in its own words, "a mechanistic explanation for the effectiveness of EOP", built with the standard interpretability toolkit: layer-wise attention analysis across all 32 layers, an MLP probe for echo detection, likelihood decomposition, and a causal intervention (echo reinsertion). The effect localizes to middle layers 7–18 — answer-to-answer-prefix attention is 14.45% in correct traces vs. 11.58% in wrong ones (Cohen's d = 0.832), while answer-to-question attention stays flat across layers as a negative control. The scope is deliberately honest: this is attention- and behavior-level mechanism, not neuron- or circuit-level reverse engineering.

**Reasoning attention.** The paper measures where reasoning tokens actually look. Token-wise significance tests show a systematic shift: wrong traces attend significantly more to the raw question (22 of 32 early answer positions), while correct traces attend to the model's *own echoed restatement*. Word-level attention heatmaps show the echo concentrates attention on key quantities and constraints (numbers, entities) rather than function words, and information-flow analysis finds echo tokens acting as an internal hub that routes information from question to answer through the middle layers.

**Long chain-of-thought grounding.** Long reasoning traces drift: the paper builds on positional-bias findings ("lost in the middle", Liu et al. 2024) and attention-drift work, and frames the echo — averaging ~219 tokens — as the model's *self-generated* re-injection of the problem statement, keeping task constraints attendable late in the trace. Echoic Prompting turns this into a practical mid-trace re-grounding move: append "look back at the question again" plus the original question. For practitioners, this is context engineering for reasoning, backed by attention-level evidence.

**Test-time compute.** The paper's opening frame: EOP is a *front-loaded, compute-shaping mechanism* for test-time compute allocation. In the test-time scaling comparison, Echoic Prompting outperforms thinking-token test-time scaling (TTTS) on AIME24 and MATH-500 under identical decoding settings and budgets — evidence that re-grounding on task-specific context beats injecting generic thinking tokens.

**Chain-of-thought faithfulness (adjacent).** The paper's opening question — is the echo a superfluous artifact or does it serve a functional role? — is a faithfulness-style question about whether visible reasoning tokens do real computational work. The causal answer: forcing an echo onto failed traces lifts exact match by +10.4 points (DeepSeek-R1-Distill-Llama-8B) and +7.9 points (Qwen3-8B), with a null effect on a non-reasoning base model. These trace tokens are functional, not decorative.

## What the Paper Studies

The paper asks whether prompt echoes are superficial chain-of-thought formatting artifacts, or whether they can help a reasoning model stay grounded in the original problem. It connects prompt restatement with attention to problem tokens, reasoning trajectory stability, and math reasoning performance.

In long reasoning traces, the model must preserve access to earlier problem constraints while producing many intermediate tokens. Prompt restatement creates an anchor that later tokens attend back to, reducing drift away from the original question.

## Methods and Artifacts

- **Echo-Distilled SFT (ED-SFT)**: supervised fine-tuning data for an echo-then-reason pattern.
- **Echoic Prompting (EP)**: a training-free inference-time strategy that reintroduces the original question during generation.
- **Reasoning probes**: MLP probes for detecting prompt repetition in thinking traces.
- **Probabilistic analysis**: Echo Likelihood Gap with length- and suffix-controlled likelihood comparisons, validated by logistic regression (ΔL is a significant positive predictor of correctness, p ≈ 0.022, after controlling for trace length).
- **Attention analysis**: layer-wise attention refocusing evidence across all 32 layers, with AUC and Cohen's d discriminability by layer group and a negative control (answer-to-question attention).
- **Causal intervention**: echo reinsertion on failed traces — truncate an echo-free trace, resume with or without an injected echo under matched decoding and seeds — isolating the causal effect of the echo.

## Evidence Highlights

- Echo of Prompt appears frequently in GSM8K reasoning traces: 78% for Qwen3-8B, 71% for DeepSeek-8B, and 86% for gpt-oss in the reported poster examples.
- Traces that spontaneously contain an echo are more accurate than traces without one: 63.8% vs. 57.2% on GSM8K.
- Correct answers have higher average Echo Likelihood Gap than wrong answers: 2.523 vs. 2.442 nats/token; logistic regression confirms ΔL as a significant positive predictor of correctness (p ≈ 0.022) after controlling for length.
- Attention refocusing is strongest in middle layers 7-18, where answer-to-answer-prefix attention is 14.45% for correct traces vs. 11.58% for wrong traces (Cohen's d = 0.832); answer-to-question attention stays flat as a negative control.
- Causal echo reinsertion on failed traces improves exact match from 15.85% to 26.22% (+10.4 points) for DeepSeek-R1-Distill-Llama-8B and from 21.34% to 29.27% (+7.9 points) for Qwen3-8B; the non-reasoning Qwen3-8B-Base shows no change (10.56% → 10.56%), a null result consistent with the mechanism requiring reasoning priors.
- Echoic Prompting outperforms thinking-token test-time scaling (TTTS) on AIME24 and MATH-500 under identical decoding settings and budgets.
- Echo-Distilled SFT improves over normal SFT in the reported math benchmarks, including +3.4 points on GSM8K, +11.8 on MathQA, and +8.2 on MATH for Qwen3-8B-Base.

## Live Metadata API

The static canonical pages live on `hhh2210.github.io`. A small Railway service provides dynamic cached snapshots of GitHub, OpenReview, and static resource metadata:

- Live snapshot: https://echoes-resource-api-production.up.railway.app/api/live.json
- GitHub snapshot: https://echoes-resource-api-production.up.railway.app/api/github.json
- OpenReview snapshot: https://echoes-resource-api-production.up.railway.app/api/openreview.json
- Static resource snapshot: https://echoes-resource-api-production.up.railway.app/api/resources.json
- Stable project JSON: https://echoes-resource-api-production.up.railway.app/api/project.json
- Stable paper JSON: https://echoes-resource-api-production.up.railway.app/api/paper.json
- Markdown alternate: https://hhh2210.github.io/markdown/echoes-as-anchors.txt

## Retrieval Keywords

LLM reasoning, large reasoning models, mechanistic interpretability, interpretability of reasoning models, reasoning attention, attention analysis, test-time compute, test-time scaling, long chain-of-thought, long-context reasoning, lost in the middle, reasoning drift, chain-of-thought faithfulness, Echo of Prompt, Echo Likelihood Gap, echoic prompting, attention refocusing, echo-distilled SFT, chain-of-thought reasoning, mathematical reasoning, ICLR 2026.

## Citation

```bibtex
@inproceedings{hao2026echoes,
  title     = {Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning},
  author    = {Hao, Zhuoyuan and Li, Zhuo and Li, Wu and Liu, Fangming and Zhang, Min and Li, Jing},
  booktitle = {The Fourteenth International Conference on Learning Representations},
  year      = {2026},
  url       = {https://openreview.net/forum?id=vndn1Wrult}
}
```
