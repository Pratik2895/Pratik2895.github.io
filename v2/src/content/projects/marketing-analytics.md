---
title: "Multi-Channel Marketing Analytics"
tagline: "Unified KPI model across Facebook, Google Ads, and TikTok."
summary: "Analytics engineering project: a single standardized data model and interactive dashboard unifying Facebook / Google / TikTok ad spend, with built-in data-quality checks and ROI-driven KPIs."
role: "Sole Engineer — model, UI, QC"
period: "2026"
stack: ["Python", "Pandas", "Streamlit", "Plotly"]
tags: ["Analytics Engineering", "Data Quality", "Marketing"]
repo: "https://github.com/Pratik2895/Marketing-Analyst-Technical-Assignment"
featured: true
order: 4
arch: analytics
accent: emerald
metrics:
  - label: "Channels"
    value: "3 (FB / Google / TikTok)"
  - label: "KPIs modeled"
    value: "CTR · CPC · CPA · ROAS · CPM"
  - label: "Deploy target"
    value: "Streamlit Cloud"
---

## The problem

Marketing teams running campaigns across Facebook, Google, and TikTok get three different schemas, three different KPI definitions, and three different timezone conventions. Comparing cross-channel performance in that state is guesswork.

## What I built

An **analytics-engineering layer** that standardizes the three platforms into one model and an interactive dashboard on top:

- **Unified model:** Column-level standardization (spend, impressions, clicks, conversions, revenue) across all three channels.
- **KPI library:** CTR, CPC, CPA, ROAS, CPM computed consistently — with clear formulas in code.
- **Dashboard:** Streamlit + Plotly — real-time filtering, comparative channel analysis, trend views.
- **Data quality:** Dedicated QC script validates dashboard numbers against source CSVs; mismatch → fail loud.
- **Deliverables:** CSV export + auto-generated campaign recommendations.

## Why it matters

Shows the **analytics-engineer** half of my title: business-facing metrics with defensible definitions, not just pipelines moving bytes. The QC script is the tell — real analytics engineering is as much about trust as it is about SQL.
