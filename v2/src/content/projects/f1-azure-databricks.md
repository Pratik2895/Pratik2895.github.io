---
title: "F1 Azure Databricks Lakehouse"
tagline: "End-to-end Azure lakehouse with Unity Catalog governance."
summary: "Formula 1 analytics pipeline on Azure Databricks: ADF orchestration, ADLS Gen2 storage, Delta Lake lakehouse, Unity Catalog governance, and Power BI reporting."
role: "Sole Engineer"
period: "2025 – 2026"
stack: ["Azure Databricks", "PySpark", "Spark SQL", "ADLS Gen2", "Azure Data Factory", "Power BI", "Unity Catalog"]
tags: ["Azure", "Lakehouse", "Governance"]
repo: "https://github.com/Pratik2895/F1race_Data_Engineering_DBricks"
featured: true
order: 3
arch: azure
accent: amber
metrics:
  - label: "Cloud"
    value: "Azure"
  - label: "Governance"
    value: "Unity Catalog"
  - label: "Load modes"
    value: "Incremental + Full"
---

## The problem

F1 race data is rich but heavily normalized across many feeds (results, lap times, pit stops, standings). Turning it into analyst-ready tables requires the full lakehouse pattern — not just raw storage.

## What I built

A full **Azure lakehouse** demonstrating incremental + full-load patterns with enterprise governance:

- **Storage:** ADLS Gen2 with raw/cleansed/curated zones.
- **Compute:** Azure Databricks — PySpark ingestion, Spark SQL transformations, Delta Lake writes with schema enforcement.
- **Orchestration:** Azure Data Factory pipelines trigger Databricks notebooks.
- **Governance:** Unity Catalog with row-level access and lineage.
- **Serving:** Power BI dashboards for race performance, driver stats, and constructor standings.

## Why it matters

Complements the AWS/Databricks work in my day job by demonstrating the parallel Azure stack: ADF + Unity Catalog + Power BI. Shows I can move between clouds without losing the shape of a good pipeline.
