---
title: "Ontario Real Estate Lakehouse"
tagline: "Production-grade Medallion pipeline on 1.2M civic records."
summary: "Bronze/Silver/Gold lakehouse pipeline for Ontario real estate analytics, ingesting 1.2M+ authentic records from Toronto Open Data and Statistics Canada into a Streamlit dashboard."
role: "Sole Engineer — Design, build, deploy"
period: "2026"
stack: ["PySpark", "Delta Lake", "Databricks", "Streamlit", "Python"]
tags: ["Medallion", "Lakehouse", "Data Engineering"]
repo: "https://github.com/Pratik2895/ontario-real-estate"
featured: true
order: 1
arch: medallion
accent: cyan
metrics:
  - label: "Records processed"
    value: "1.2M+"
  - label: "Data volume"
    value: "540 MB"
  - label: "Gold tables"
    value: "6"
  - label: "Dashboard tabs"
    value: "6"
---

## The problem

Toronto and the Ontario government publish valuable real estate data (property boundaries, building permits, rental evaluations, housing price indices) — but it's fragmented across portals, inconsistently shaped, and updated on different cadences. No single place gives decision-makers a trustworthy view of what's happening in the market.

## What I built

A production-style **Medallion (Bronze/Silver/Gold) lakehouse** on Databricks + Delta Lake:

- **Bronze (8 tables):** Raw API landing from Toronto Open Data + StatsCan — idempotent ingestion with audit columns.
- **Silver (4 tables):** Type-cast, deduplicated, enriched with geospatial keys; schema-enforced Delta writes.
- **Gold (6 tables):** Business-ready aggregates powering the dashboard — permit trends, construction investment, apartment quality scores, price indices.

A **Streamlit dashboard** on top surfaces six analytical tabs tied directly to the Gold layer.

## Why it matters

This was my playground for putting my day-job patterns into a public, portable repo: incremental Delta, schema enforcement, layered refinement, and a thin but real UI. Full CI-style reruns, audit trails, and documented Gold grain.
