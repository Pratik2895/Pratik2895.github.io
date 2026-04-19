<!-- README for Pratik2895/AI-Stock-Intelligence-CAN-US-Markets -->

# 🤖 AI Stock Intelligence — CAN / US Markets

> End-to-end **GenAI-powered analytics platform** for 40 stocks across TSX, NYSE and NASDAQ. Ingests 8+ financial & social sources, scores via a 5-factor composite model, and answers natural-language questions through a RAG-powered Streamlit dashboard.

![Python](https://img.shields.io/badge/Python-3.11-3776AB?style=flat-square&logo=python&logoColor=white)
![Airflow](https://img.shields.io/badge/Airflow-2.x-017CEE?style=flat-square&logo=apacheairflow&logoColor=white)
![Delta Lake](https://img.shields.io/badge/Delta%20Lake-3.x-00ADD4?style=flat-square)
![ChromaDB](https://img.shields.io/badge/ChromaDB-Vector%20Store-FF6F61?style=flat-square)
![Gemini](https://img.shields.io/badge/Google%20Gemini-LLM-4285F4?style=flat-square&logo=google&logoColor=white)
![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?style=flat-square&logo=streamlit&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

🔗 **Portfolio case study →** https://pratik2895.github.io/projects/ai-stock-intelligence/

---

## 🎯 The problem

Retail investors drown in fragmented signals — price ticks, news, Reddit chatter, analyst notes — with no way to unify them into a single, explainable recommendation.

## 🏗️ Architecture

```
 ┌────────┐  ┌────────┐  ┌──────────┐
 │ News   │─▶│        │  │  Delta   │     ┌──────────┐
 │ Reddit │─▶│Airflow │─▶│  Lake    │────▶│  RAG UI  │
 │yfinance│─▶│ DAGs   │  │ (prices) │     │ Streamlit│
 └────────┘  └───┬────┘  └──────────┘     │  + Gemini│
                │                         └──────────┘
                │       ┌──────────┐           ▲
                └──────▶│ ChromaDB │───────────┘
                        │ (embed)  │
                        └──────────┘
```

- **Ingestion** — `yfinance`, NewsAPI, Reddit PRAW, and 5+ supplementary sources
- **Processing** — TextBlob sentiment + **5-factor composite scoring model**
- **Storage** — Delta Lake (structured price history) + **ChromaDB** (unstructured embeddings)
- **AI layer** — Google Gemini + RAG for grounded Q&A
- **Orchestration** — Airflow DAGs, fully containerized with Docker / Podman

---

## 📊 Coverage

| | |
|---|---|
| Stocks tracked | **40** |
| Markets | TSX · NYSE · NASDAQ |
| Data sources | **8+** |
| Deploy target | Streamlit Cloud (minimum: Gemini API key) |

---

## 🚀 Quick start

```bash
# 1. Clone
git clone https://github.com/Pratik2895/AI-Stock-Intelligence-CAN-US-Markets
cd AI-Stock-Intelligence-CAN-US-Markets

# 2. Configure
cp .env.example .env        # add your GEMINI_API_KEY (required)

# 3. Option A — Docker / Podman
docker compose up -d

# 3. Option B — local Python
pip install -r requirements.txt
airflow scheduler &         # run DAGs
streamlit run app.py        # open http://localhost:8501
```

---

## 🧭 Repo structure

```
.
├── airflow/
│   ├── dags/            # Ingestion, scoring, embedding pipelines
│   └── plugins/
├── app/                 # Streamlit dashboard + RAG UI
├── src/
│   ├── ingest/          # yfinance, NewsAPI, Reddit clients
│   ├── scoring/         # 5-factor composite model
│   ├── embedding/       # ChromaDB vector builder
│   └── rag/             # Gemini retrieval chain
├── infra/               # docker-compose, Dockerfiles
└── tests/
```

---

## 🧠 Why this project matters

Modern data platforms don't stop at tabular ETL. This repo is my hands-on answer to: **"what does a 2026 data platform look like?"** Vector stores, LLM APIs, grounded retrieval, full orchestration — all stitched together with the same discipline I bring to classic Bronze/Silver/Gold work.

---

## 📫 Contact

**Pratik Bhikadiya** · Data & Analytics Engineer
[Portfolio](https://pratik2895.github.io) · [LinkedIn](https://www.linkedin.com/in/pratikbhikadiya/) · bhikadi@uwindsor.ca
