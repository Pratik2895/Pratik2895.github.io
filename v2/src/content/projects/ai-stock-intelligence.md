---
title: "AI Stock Intelligence — CAN/US Markets"
tagline: "Multi-source ingestion + RAG on 40 stocks across TSX/NYSE/NASDAQ."
summary: "End-to-end GenAI-powered analytics platform: ingests 8+ financial and social sources, scores stocks via a 5-factor composite model, and answers natural-language questions through a RAG-powered Streamlit dashboard."
role: "Sole Engineer — architecture, pipelines, UI"
period: "2026"
stack: ["Python", "Delta Lake", "Airflow", "ChromaDB", "Google Gemini", "Streamlit", "Docker"]
tags: ["GenAI", "RAG", "Pipelines", "NLP"]
repo: "https://github.com/Pratik2895/AI-Stock-Intelligence-CAN-US-Markets"
featured: true
order: 2
arch: rag
accent: violet
metrics:
  - label: "Data sources"
    value: "8+"
  - label: "Stocks tracked"
    value: "40"
  - label: "Markets"
    value: "TSX · NYSE · NASDAQ"
  - label: "Orchestration"
    value: "Airflow / Docker"
---

## The problem

Retail investors drown in fragmented signals — price ticks, news, Reddit chatter, analyst notes — with no way to unify them into a single, explainable recommendation.

## What I built

A containerized analytics platform that merges **financial, news, and social data** into a unified Delta Lake store, applies NLP sentiment, and surfaces recommendations via a RAG-powered Q&A interface:

- **Ingestion:** `yfinance`, NewsAPI, Reddit PRAW, and 5+ supplementary sources.
- **Processing:** TextBlob sentiment, a **5-factor composite scoring model**, feature enrichment.
- **Storage:** Delta Lake for structured history + **ChromaDB** vector store for unstructured embeddings.
- **AI Layer:** Google Gemini + RAG for natural-language questions grounded in ingested data.
- **Orchestration:** Airflow DAGs, full Docker/Podman infra, deployable on Streamlit Cloud.

## Why it matters

This project shows I can reach beyond classic batch ETL — modern data engineering now includes vector stores, LLM APIs, and grounded retrieval. It's an honest answer to *"what does a 2026 data platform look like?"*
