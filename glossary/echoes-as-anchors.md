---
layout: page
title: Echoes as Anchors Glossary
permalink: /glossary/echoes-as-anchors/
description: "Glossary and concept map for Echoes as Anchors: Echo of Prompt, Echo Likelihood Gap, attention refocusing, Echoic Prompting, ED-SFT, and LLM reasoning."
keywords: "Echoes as Anchors glossary, Echo of Prompt, Echo Likelihood Gap, attention refocusing, Echoic Prompting, ED-SFT, LLM reasoning concepts"
---

# Echoes as Anchors Glossary

This glossary maps the main concepts in **Echoes as Anchors: Probabilistic Costs and Attention Refocusing in LLM Reasoning**.

## LLM Reasoning

**LLM reasoning** refers to multi-step problem solving by large language models. In this paper, the focus is not only final answer accuracy, but also the model's reasoning trajectory: how it keeps track of the original problem while generating intermediate reasoning steps.

Related concepts: chain-of-thought reasoning, large reasoning models, mathematical reasoning, test-time compute.

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

Related concepts: prompt grounding, attention refocusing, multi-step reasoning.

## Concept Map

- Echo of Prompt is a form of prompt restatement.
- Prompt restatement can act as an anchor during LLM reasoning.
- Anchoring can support attention refocusing.
- Attention refocusing can reduce reasoning drift.
- Echo Likelihood Gap measures the probabilistic side of prompt echoes.
- Echoic Prompting uses the EOP idea at inference time.
- Echo-Distilled SFT uses the EOP idea during fine-tuning.

## Links

- Paper page: https://hhh2210.github.io/papers/echoes-as-anchors/
- FAQ: https://hhh2210.github.io/faq/echoes-as-anchors/
- Structured concept JSON: https://hhh2210.github.io/api/papers/echoes-concepts.json
- Repository: https://github.com/hhh2210/echoes-as-anchors
- OpenReview: https://openreview.net/forum?id=vndn1Wrult
