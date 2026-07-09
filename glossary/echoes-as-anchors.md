---
layout: page
title: Echoes as Anchors Glossary
permalink: /glossary/echoes-as-anchors/
description: "Glossary and concept map for Echoes as Anchors (ICLR 2026), covering mechanistic interpretability of reasoning models, reasoning attention, test-time compute, long chain-of-thought grounding, lost in the middle, Echo of Prompt, Echo Likelihood Gap, attention refocusing, Echoic Prompting, and ED-SFT."
keywords: "Echoes as Anchors glossary, mechanistic interpretability, interpretability of reasoning models, reasoning attention, attention analysis, test-time compute, test-time scaling, long chain-of-thought, long-context reasoning, lost in the middle, reasoning drift, chain-of-thought faithfulness, Echo of Prompt, Echo Likelihood Gap, attention refocusing, Echoic Prompting, ED-SFT, LLM reasoning concepts"
---

# Echoes as Anchors Glossary

This glossary maps the main concepts in **Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning**.

## LLM Reasoning

**LLM reasoning** refers to multi-step problem solving by large language models. In this paper, the focus is not only final answer accuracy, but also the model's reasoning trajectory: how it keeps track of the original problem while generating intermediate reasoning steps.

Related concepts: chain-of-thought reasoning, large reasoning models, mathematical reasoning, test-time compute.

## Mechanistic Interpretability (Scope in This Paper)

**Mechanistic interpretability** explains model behavior through internal evidence — attention patterns, probes, likelihood decomposition, and causal interventions — rather than input-output correlation alone. Echoes as Anchors provides what it calls "a mechanistic explanation" at the attention and behavior level: layer-wise attention analysis over all 32 layers localizes the echo effect to middle layers 7–18 (Cohen's d = 0.832), an MLP probe detects echoes, and causal echo reinsertion establishes cause and effect, with answer-to-question attention as a negative control. The paper does not claim neuron- or circuit-level reverse engineering.

Related concepts: interpretability of reasoning models, reasoning probes, attention analysis, causal intervention, chain-of-thought faithfulness.

## Reasoning Attention

**Reasoning attention** refers to attention patterns that route information during multi-step reasoning. The paper's measured version: in middle layers, answer tokens in correct traces attend to the echoed answer-prefix at 14.45% vs. 11.58% in wrong traces, and token-wise tests show wrong traces attending more to the raw question while correct traces attend to the model's own echoed restatement. Information-flow analysis finds echo tokens acting as an internal hub between question and answer.

Related concepts: attention analysis, attention refocusing, chain-of-thought reasoning, problem grounding.

## Long Chain-of-Thought Grounding

**Long chain-of-thought grounding** is the problem of keeping a long reasoning trace anchored to the original problem. Long traces create the same pressure as long contexts — earlier tokens become under-attended, as in "lost in the middle" positional-bias findings — and models drift. In Echoes as Anchors, the echo prefix (averaging ~219 tokens) is the model's self-generated re-injection of the problem statement; Echoic Prompting applies the same re-grounding move mid-trace.

Related concepts: long-context reasoning, lost in the middle, reasoning drift, context engineering, prompt grounding.

## Test-Time Compute

**Test-time compute** is the computation a model spends at inference, and how to allocate it is a central question for large reasoning models. Echoes as Anchors frames Echo of Prompt as a *front-loaded, compute-shaping mechanism*: tokens spent echoing up front make subsequent reasoning more grounded. Its Echoic Prompting method outperforms thinking-token test-time scaling (TTTS) on AIME24 and MATH-500 under identical budgets.

Related concepts: test-time scaling, inference-time methods, overthinking, large reasoning models.

## Large Reasoning Models

**Large reasoning models (LRMs)** are large language models optimized or prompted for multi-step reasoning. Echoes as Anchors studies behaviors that appear inside LRM reasoning traces, especially prompt repetition and attention refocusing.

Related concepts: LLM reasoning, chain-of-thought, test-time compute.

## Echo of Prompt

**Echo of Prompt (EOP)** is the behavior where a model repeats or rephrases the original user question inside its reasoning trajectory. The paper treats EOP as a measurable reasoning behavior rather than only a stylistic artifact.

Related concepts: prompt restatement, chain-of-thought, attention refocusing.

## Prompt Restatement

**Prompt restatement** is a broader form of Echo of Prompt. It includes exact repetition, paraphrasing, or partial re-grounding in the original problem statement during reasoning.

Related concepts: Echo of Prompt, re-grounding, reasoning drift.

## Echo Likelihood Gap

**Echo Likelihood Gap** is a probabilistic measure used to quantify the likelihood effect of prompt echoes. It provides a way to connect early prompt repetition with model likelihood and downstream reasoning performance.

Related concepts: probabilistic costs, rejection-based conditioning, reasoning accuracy.

## Attention Refocusing

**Attention refocusing** describes how Echo of Prompt can shift model attention back toward important problem or answer-prefix tokens during reasoning. This is one mechanism-level explanation for why prompt echoes may help multi-step reasoning.

Related concepts: attention analysis, middle layers, prompt grounding.

## Echoic Prompting

**Echoic Prompting (EP)** is a training-free inference-time strategy. It reintroduces the original question or a reminder during generation so the model can re-ground its reasoning without additional fine-tuning.

Related concepts: test-time prompting, inference-time re-grounding, prompt restatement.

## Echo-Distilled SFT

**Echo-Distilled Supervised Fine-Tuning (ED-SFT)** is a data preparation and fine-tuning strategy that encourages an echo-then-reason pattern.

Related concepts: supervised fine-tuning, finetuning, reasoning data.

## Reasoning Probe

A **reasoning probe** is a classifier or diagnostic tool used to detect patterns inside model reasoning traces. In this project, MLP probes help detect repetition behavior in thinking traces.

Related concepts: MLP probe, repetition detection, reasoning trajectory analysis.

## Reasoning Drift

**Reasoning drift** is when a model loses track of the original problem during a long reasoning trace. Echo of Prompt may reduce drift by re-anchoring the model to the task statement.

Related concepts: prompt grounding, attention refocusing, multi-step reasoning, long-context reasoning.

## Concept Map

- Echo of Prompt is a form of prompt restatement.
- Prompt restatement can act as an anchor during LLM reasoning.
- Anchoring can support attention refocusing.
- Attention refocusing can reduce reasoning drift.
- Reasoning attention links prompt anchors to long chain-of-thought grounding.
- Mechanistic-interpretability methods (attention analysis, probes, causal echo insertion) establish that EOP is functional, not decorative.
- Echo of Prompt is a front-loaded, compute-shaping mechanism for test-time compute.
- Echo Likelihood Gap measures the probabilistic side of prompt echoes.
- Echoic Prompting uses the EOP idea at inference time.
- Echo-Distilled SFT uses the EOP idea during fine-tuning.

## Links

- Paper page: https://hhh2210.github.io/papers/echoes-as-anchors/
- FAQ: https://hhh2210.github.io/faq/echoes-as-anchors/
- Structured concept JSON: https://hhh2210.github.io/api/papers/echoes-concepts.json
- Repository: https://github.com/hhh2210/echoes-as-anchors
- OpenReview: https://openreview.net/forum?id=vndn1Wrult
