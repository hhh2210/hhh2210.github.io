---
layout: page
title: "Why Reasoning Models Repeat the Prompt — Echoes as Anchors (ICLR 2026)"
seo_title: "Why Reasoning Models Repeat the Prompt — Echoes as Anchors"
last_modified_at: 2026-08-02
permalink: /papers/echoes-as-anchors/
description: "Echoes as Anchors (ICLR 2026) asks whether the prompt restatement at the head of a reasoning trace does real work. Frequency, likelihood, attention, and a causal intervention on GSM8K say it does — with stated limits."
keywords: "Echoes as Anchors, ICLR 2026, Echo of Prompt, Echo Likelihood Gap, attention refocusing, echoic prompting, echo-distilled SFT, LLM reasoning, large reasoning models, test-time compute"
schema: scholarly_article
paper_key: echoes-as-anchors
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
paper_citation_date: "2026"
paper_venue: "The Fourteenth International Conference on Learning Representations (ICLR)"
paper_arxiv_id: "2602.06600"
paper_doi: "https://doi.org/10.48550/arXiv.2602.06600"
paper_doi_value: "10.48550/arXiv.2602.06600"
paper_openalex: "https://openalex.org/W7128374376"
paper_repo_name: "echoes-as-anchors"
paper_software_description: "Research code for Echoes as Anchors, an ICLR 2026 paper with attention analysis, MLP probes, causal echo insertion, Echo Likelihood Gap computation, ED-SFT data preparation, and Echoic Prompting for LLM reasoning."
paper_topics:
  - LLM reasoning
  - large reasoning models
  - mechanistic interpretability
  - reasoning attention
  - test-time compute
  - Echo of Prompt
  - attention refocusing
  - echoic prompting
  - echo-distilled SFT
paper_authors:
  - Zhuoyuan Hao
  - Zhuo Li
  - Wu Li
  - Fangming Liu
  - Min Zhang
  - Jing Li
---

**Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning** (ICLR 2026) is
first-authored by **Zhuoyuan Hao** (professional name: Larry Hao), Harbin Institute of Technology,
Shenzhen. This page is the citable summary of what the paper measured, on what, and what it does not
claim.

- Paper: [OpenReview](https://openreview.net/forum?id=vndn1Wrult) · [arXiv:2602.06600](https://arxiv.org/abs/2602.06600) · [DOI 10.48550/arXiv.2602.06600](https://doi.org/10.48550/arXiv.2602.06600)
- Code: [github.com/hhh2210/echoes-as-anchors](https://github.com/hhh2210/echoes-as-anchors)
- Structured metadata: [JSON](https://hhh2210.github.io/api/papers/echoes-as-anchors.json) · [plain text](https://hhh2210.github.io/markdown/echoes-as-anchors.txt)

## Summary

Large reasoning models usually restate the user's question before they start solving it. The paper
calls this the **Echo of Prompt (EOP)** and asks whether it is a leftover formatting habit from
supervised fine-tuning or a step that does real computational work.

The answer it argues for is the second one, in a specific and bounded sense: **the restatement
creates a nearby, task-specific span of text that later reasoning tokens attend back to.** Four
measurements support this — the behavior is frequent, the model assigns higher likelihood to traces
that contain it, correct traces route more attention to that span than wrong ones, and inserting an
echo into failed traces recovers accuracy in reasoning-tuned models but not in a base model. The
paper then turns the observation into two methods: **Echo-Distilled SFT (ED-SFT)** and **Echoic
Prompting (EP)**.

## Scope of the evidence

This matters more than any individual number. The paper's analytical results are not a survey across
models — almost all of them come from one model on one benchmark.

| Result | Model(s) | Data | Where |
|---|---|---|---|
| EOP frequency | Qwen3-8B, DeepSeek-R1-Distill-Llama-8B, gpt-oss | GSM8K | Fig. 1 |
| Echo Likelihood Gap, logistic regression | DeepSeek-R1-Distill-Llama-8B only | GSM8K, 1,319 traces | Tab. 1, Tab. 9 |
| Attention refocusing, layer analysis | DeepSeek-R1-Distill-Llama-8B only | GSM8K, 1,319 traces | Tab. 2–3, §A.5–A.11 |
| Causal echo reinsertion | DeepSeek-R1-Distill-Llama-8B, Qwen3-8B, Qwen3-8B-Base | GSM8K failed traces | Tab. 4 |
| ED-SFT | Qwen3-8B-Base, Qwen3-8B, DeepSeek-Distill-Llama-8B | train GSM8K 7k; eval GSM8K, MathQA, Hendrycks-MATH | Tab. 5 |
| Echoic Prompting | DeepSeek-R1-Distill-Llama-8B only | AIME24, MATH-500 | Fig. 4 |

Every mechanism claim below — likelihood, attention, layer localization — is a claim about
DeepSeek-R1-Distill-Llama-8B solving grade-school math. It is not established for other
architectures, other task families, or long-context settings.

## The question

Repetition inside a reasoning trace already had two incompatible readings in the literature. Runaway
repetition is a known failure mode, the "repeat curse" (Yao et al., 2025). Yet *instructing* a model
to re-read the question improves accuracy (Xu et al., 2024; Mekala et al., 2024). Neither line
explains the repetition that reasoning models produce spontaneously, unprompted, at the head of the
chain — which is where the paper starts.

The difficulty is that the obvious explanation is also the boring one. If the echo helps only because
it makes the trace longer, then nothing interesting is happening: it is just test-time compute spent
on tokens. Separating "the echo helps" from "more tokens help" is the technical problem the paper's
design is built around, and it is why the analyses are length- and suffix-controlled.

## Measuring the echo

Every downstream number depends on being able to detect an echo automatically, so the detector is
part of the evidence rather than a preprocessing detail.

The paper trains a two-layer MLP probe (32-dim hidden, ReLU) on the concatenation of two
Qwen3-Embedding-0.6B sentence embeddings: the full question, and the first 32 word tokens of the
thinking content. Labels come from GPT-4.1 with a deterministic rubric, refined by sentence-level
similarity; 200 randomly sampled annotations were manually reviewed with over 96% agreement. On its
held-out test set the probe reaches accuracy 0.912, F1 0.914, AUROC 0.963 (Tab. 7). Truncation uses a
calibrated threshold with hysteresis (0.6 initial, 0.15 drop).

Two consequences are worth stating plainly. First, the probe is a *binary* detector, not a span
localizer — so when the paper needs an echo removed or inserted, it delegates the span edit to a
teacher model (gpt-oss-120B) under a "do not change the reasoning or the final answer" instruction.
Second, roughly 9% probe error propagates into every group assignment downstream.

## Four lines of evidence

### 1. Frequency: the behavior is systematic

On GSM8K, the probe detects an echo in 78% of Qwen3-8B traces, 71% of DeepSeek-R1-Distill-Llama-8B
traces, and 86% of gpt-oss traces (Fig. 1). The echoes are not token-cheap: the removed prefix
averages about 219 tokens, with most mass between 200 and 240 (Fig. 2, left). Whatever the echo is,
it is a consistent and expensive part of the output budget rather than a stray artifact.

Traces that spontaneously contain an echo are also more accurate than traces that do not — 63.8%
(n=985) versus 57.2% (n=334) on GSM8K (Tab. 10). This comparison is descriptive: problems are not
matched for difficulty, so easier problems may simply invite both an echo and a correct answer. It
motivates the rest of the paper; it does not settle anything.

### 2. Probability: the model pays for the echo, and the payment tracks correctness

To measure what the echo costs, the paper casts echo removal as conditioning on the echo-free subset
of outputs, which defines a trimmed distribution whose partition function is intractable. It then
uses a computable proxy: the **Echo Likelihood Gap**, ΔL = L(y_raw) − L(y_trim), the difference in
length-normalized per-token log-likelihood between a trace and its echo-trimmed counterpart. Positive
ΔL means the model prefers the version with the echo.

Correct traces show a larger gap than wrong ones: 2.5231 versus 2.4421 nats/token (Tab. 1). The
direction is consistent, but the separation is small relative to spread — the difference is 0.0811
against standard deviations near 0.78, i.e. a standardized effect around 0.1. The stronger statement
is the regression: in a logistic model of correctness on 1,319 GSM8K samples, ΔL is a significant
positive predictor (β₁ ≈ 0.24, p ≈ 0.022, odds ratio ≈ 1.27 per nat/token) with echo length included
as a covariate (Tab. 9). The gap also stays positive across every removed-length bin (Fig. 2, right).

The paper reports a result that cuts the other way, and it belongs on this page: the **suffix-only**
gap — the echo's effect on the likelihood of the shared reasoning that follows — is slightly *larger*
for wrong traces (1.2938 vs 1.1449). The paper's reading is that an echo makes whatever follows look
more plausible to the model, including locally coherent but wrong reasoning. So ΔL is best described
as associated with correctness, not as a correctness detector.

### 3. Attention: where the later tokens look

If the echo functions as an anchor, later tokens should attend to it. The paper measures head-averaged
attention from generated answer tokens to (i) the question and (ii) the answer prefix — the echo span,
sized per-sample by the probe.

Correct traces attend more to the answer prefix at every layer group. In layers 7–18 the gap is
14.45% versus 11.58% (+2.87 pp); at the last layer it is 13.69% versus 10.41% (+3.28 pp); averaged
over all layers, 10.64% versus 8.49% (+2.15 pp) (Tab. 2). Discriminability is around AUC 0.72 and
Cohen's d 0.82–0.83 across layer groups (Tab. 3). The gap survives replacing the probe-estimated
prefix with fixed lengths of 32, 64, and 128 tokens, though it narrows at K=128 (+1.08 pp, Tab. 8) —
evidence that the effect is not merely "longer echo, better answer."

The contrast that carries the argument is with the answer→question control, where the same
correct-versus-wrong comparison is much weaker: d falls to 0.18–0.48, and the layers 7–18 gap is
+0.66 pp (Tab. 2–3). Successful reasoning is not distinguished by attending harder to the original
question. It is distinguished by attending to the model's own restatement of it.

Two honest qualifications. The paper localizes the effect to middle layers 7–18, but the layer-group
effect sizes (0.820 / 0.832 / 0.828 for early / mid / late) are close enough that "mid-layer dominance"
is better read as *where the raw gap peaks* than as a resolved claim about which layers matter. And
the answer→question channel is not a pure null: in the token-wise test, wrong traces attend
significantly more to the question at 22 of the first 32 answer positions, while the answer→prefix
difference is significant at 10 of 32 (§A.9). The picture is a *shift* of attention between two
targets, which is stronger than a one-sided effect but weaker than a clean control.

### 4. Causal intervention: forcing an echo into traces that failed

Correlational evidence cannot rule out that echoes are a symptom of already-going-well reasoning. The
intervention addresses this directly. Starting from GSM8K completions the model got wrong, the paper
truncates an echo-free trace to 50% of its tokens, then resumes generation twice from that identical
prefix — once directly, once after inserting the phrase *"now I need to look back at the question
again:"* — under identical questions, decoding parameters, and random seeds.

| Model | Echo-free EM | Echo reinsertion EM | Δ |
|---|---:|---:|---:|
| DeepSeek-R1-Distill-Llama-8B | 15.85% | 26.22% | +10.4 |
| Qwen3-8B | 21.34% | 29.27% | +7.9 |
| Qwen3-8B-Base (no CoT) | 10.56% | 10.56% | 0.0 |

The base-model null is the informative row: the same intervention does nothing for a model without
reasoning post-training, which is what an "anchor the reasoning" account predicts and what a "more
tokens help" account does not.

Three limits. The gains are measured on the previously-failed subset, so the base rates are already
conditioned and these are not benchmark numbers. The paper reports no confidence intervals or
repeated seeds for this table. And the injected text is a fixed template phrase, not a model-generated
echo — so the experiment shows that *re-grounding on the question mid-trace* is causally effective,
which is adjacent to, but not identical with, showing that the spontaneous echo is.

## Two methods that follow from the analysis

**Echo-Distilled SFT (ED-SFT)** trains the pattern in. From a single pool of teacher traces
(gpt-oss-120B on GSM8K, answer-verified), the paper derives two nearly token-identical corpora: one
where missing echoes are minimally inserted, one where present echoes are removed — same reasoning,
same answers. Fine-tuning on 7k samples with identical optimizer, schedule, batch size, and steps,
ED-SFT beats normal-SFT on Qwen3-8B-Base by +3.4 (GSM8K), +11.8 (MathQA), +8.2 (Hendrycks-MATH), and
on instruction-tuned Qwen3-8B by +2.8 / +1.9 / +1.1 (Tab. 5). The largest gains are on the benchmarks
furthest from the GSM8K training distribution.

The result is not uniform, and the page states the exception: on DeepSeek-Distill-Llama-8B, ED-SFT
scores 78.2 strict EM on GSM8K against normal-SFT's 80.5 — a 2.3-point loss — while still gaining on
MathQA (+3.4) and MATH (+2.24). There is also a residual confound the paper discloses: echo-bearing
training sequences are longer (175 vs 136 tokens on average), so ED-SFT is not a perfectly
token-matched comparison.

**Echoic Prompting (EP)** needs no training. After an initial reasoning chain, it appends a reminder
to look back at the question, followed by the question itself, and continues generation. Compared
against thinking-token test-time scaling (TTTS; Qian et al., 2025) reproduced from its official
implementation, EP is higher on both AIME24 and MATH-500 under matched decoding and budgets (Fig. 4).
This is the paper's thinnest evidence and should be cited as such: one model
(DeepSeek-R1-Distill-Llama-8B), greedy decoding (temperature 0.0), no variance reported, and AIME24
has only 30 problems, where a few points is one or two items. The claim it supports is directional —
task-specific re-grounding beat generic thinking tokens in this setup — not a general dominance
result.

## What this paper does not establish

- **Not a circuit-level mechanism.** The evidence is attention- and behavior-level. There is no
  neuron, head, or circuit attribution, and "mechanistic explanation" in the paper's contribution list
  should be read at that resolution.
- **Not a long-context result.** The related work motivates the anchor idea with positional bias
  ("lost in the middle", Liu et al., 2024), but all experiments are short math traces. Nothing here
  is tested at long-context lengths.
- **Not a universal claim.** No result covers models beyond the 8B open-weight class, non-math tasks,
  or non-English prompts.
- **Not a causal account of why EOP emerges.** The paper explicitly leaves the origin of the behavior
  as a hypothesis (§A.3).
- **Not a correctness signal you can deploy.** ΔL is a population-level association with a small
  effect size, and the suffix-only result runs the other way.

Cite this work for: prompt restatement in reasoning traces; attention-level analysis of what long
reasoning attends to; causal interventions applied to model-generated traces; test-time compute spent
on task-specific rather than generic context; or the Echo of Prompt, Echo Likelihood Gap, Echoic
Prompting, and Echo-Distilled SFT constructs by name.

## Reproduction and artifacts

The repository provides ED-SFT data preparation, the MLP probe pipeline (preprocess, label, train),
the two-stage Echoic Prompting evaluation, and the analysis scripts for the likelihood gap
(`compare_trimmed_accuracy.py`) and attention metrics
(`attention_from_converted_refactored.py`). The main EP results were produced inside the MI-PEAKS
framework for baseline parity; the repository ships a standalone two-stage implementation as well.
Fine-tuning itself is standard and uses Llama-Factory full-SFT defaults, so it is not vendored here.

- Repository and quickstart: [github.com/hhh2210/echoes-as-anchors](https://github.com/hhh2210/echoes-as-anchors)
- Machine-readable metadata: [JSON](https://hhh2210.github.io/api/papers/echoes-as-anchors.json) · [codemeta](https://github.com/hhh2210/echoes-as-anchors/blob/master/codemeta.json)
- Author publications: [hhh2210.github.io/publications](https://hhh2210.github.io/publications/)

```bibtex
@inproceedings{hao2026echoes,
  title     = {Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning},
  author    = {Hao, Zhuoyuan and Li, Zhuo and Li, Wu and Liu, Fangming and Zhang, Min and Li, Jing},
  booktitle = {The Fourteenth International Conference on Learning Representations},
  year      = {2026},
  url       = {https://openreview.net/forum?id=vndn1Wrult}
}
```
