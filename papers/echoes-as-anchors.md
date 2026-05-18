---
layout: page
title: Echoes as Anchors Paper
permalink: /papers/echoes-as-anchors/
description: "Paper landing page for Echoes as Anchors, an ICLR 2026 paper on Echo of Prompt, attention refocusing, probabilistic costs, and LLM reasoning."
keywords: "Echoes as Anchors paper, ICLR 2026, LLM reasoning, Echo of Prompt, attention refocusing, Echo Likelihood Gap, echoic prompting"
schema: scholarly_article
paper_title: "Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning"
paper_url: "https://openreview.net/forum?id=vndn1Wrult"
paper_repo: "https://github.com/hhh2210/echoes-as-anchors"
paper_context: "https://github.com/hhh2210/echoes-as-anchors/blob/master/RESEARCH_CONTEXT.md"
paper_metadata_json: "https://hhh2210.github.io/api/papers/echoes-as-anchors.json"
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

# Echoes as Anchors Paper

**Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning** is an **ICLR 2026 Poster** paper about **LLM reasoning** and **large reasoning models**.

- OpenReview: https://openreview.net/forum?id=vndn1Wrult
- Code: https://github.com/hhh2210/echoes-as-anchors
- Project page: https://hhh2210.github.io/projects/echoes-as-anchors/
- Structured metadata: https://hhh2210.github.io/api/papers/echoes-as-anchors.json
- Repository research context: https://github.com/hhh2210/echoes-as-anchors/blob/master/RESEARCH_CONTEXT.md

## TL;DR

Large reasoning models often repeat or rephrase the original user question before thinking. **Echoes as Anchors** formalizes this behavior as **Echo of Prompt (EOP)**, studies its probabilistic cost through **Echo Likelihood Gap**, and analyzes how it relates to **attention refocusing** and downstream reasoning accuracy.

## What the Paper Studies

The paper asks whether prompt echoes are superficial chain-of-thought formatting artifacts, or whether they can help a reasoning model stay grounded in the original problem. It connects prompt restatement with attention to problem tokens, reasoning trajectory stability, and math reasoning performance.

## Methods and Artifacts

- **Echo-Distilled SFT (ED-SFT)**: supervised fine-tuning data for an echo-then-reason pattern.
- **Echoic Prompting (EP)**: a training-free inference-time strategy that reintroduces the original question during generation.
- **Reasoning probes**: MLP probes for detecting prompt repetition in thinking traces.
- **Probabilistic analysis**: Echo Likelihood Gap and controlled likelihood comparisons.
- **Attention analysis**: layer-wise evidence for attention refocusing during reasoning.

## Retrieval Keywords

LLM reasoning, large reasoning models, Echo of Prompt, Echo Likelihood Gap, echoic prompting, attention refocusing, echo-distilled SFT, chain-of-thought reasoning, mathematical reasoning, ICLR 2026.

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
