# GitHub Profile Overhaul — Action Plan

This folder contains ready-to-paste READMEs for your 6 keeper repos, plus a step-by-step cleanup playbook.

---

## 📋 Files in this folder

| File | Paste into |
|---|---|
| [`PROFILE_README.md`](./PROFILE_README.md) | `Pratik2895/Pratik2895` — the special profile repo (renders on your profile page) |
| [`Pratik2895.github.io.md`](./Pratik2895.github.io.md) | `Pratik2895/Pratik2895.github.io` — portfolio repo |
| [`ontario-real-estate.md`](./ontario-real-estate.md) | `Pratik2895/ontario-real-estate` |
| [`AI-Stock-Intelligence-CAN-US-Markets.md`](./AI-Stock-Intelligence-CAN-US-Markets.md) | `Pratik2895/AI-Stock-Intelligence-CAN-US-Markets` |
| [`F1race_Data_Engineering_DBricks.md`](./F1race_Data_Engineering_DBricks.md) | `Pratik2895/F1race_Data_Engineering_DBricks` |
| [`Marketing-Analyst-Technical-Assignment.md`](./Marketing-Analyst-Technical-Assignment.md) | `Pratik2895/Marketing-Analyst-Technical-Assignment` |

---

## 🗺️ The three-bucket plan

### ⭐ Bucket 1 — KEEP & PIN (6 repos, in this order)

1. `ontario-real-estate` — medallion flagship
2. `AI-Stock-Intelligence-CAN-US-Markets` — GenAI + RAG
3. `F1race_Data_Engineering_DBricks` — Azure breadth
4. `Marketing-Analyst-Technical-Assignment` — analytics eng.
5. `Pratik2895.github.io` — portfolio
6. `Pratik2895` — profile (hidden by default, pin it to show activity)

### 🔒 Bucket 2 — MAKE PRIVATE (not delete)

These have value to you as reference but clutter your public profile:

- `Claude-code-project`
- `Apache-spark-project-folder-structure`
- `Finance-Spark-Project`
- `azuredatafactory`
- `Business-360-Insights` *(if it's still empty, consider delete instead)*
- `python` *(generic name)*
- `Sql-projects` *(generic name)*
- `Tableau-dashboards` *(generic name)*
- `ML-PYTHON-VS-R` *(old uni project)*
- `Credit-card-fraud-detection-using-machine-learning-with-R` *(old uni project)*

### 🗑️ Bucket 3 — DELETE (forks — they hurt your profile)

All of these are **forks** that clutter your repo list without adding signal:

- `AI_Fundamentals_Data_Domain`
- `RetailProjectspark`
- `tableau-ultimate-course`
- `sql-data-warehouse-project`
- `IPL-2025--DATA-Engineering-`
- `FabricDataEngineering`
- `Trendytech-Azure-Project`
- `data-engineer-handbook-zach`
- `NotesOfYouTubeSQLSeries`
- `Fabric-NYC-Taxi-Data-Project`
- `Databricks-Certified-Data-Engineer-Associate`
- `tokyo-olympic-azure-data-engineering-project`
- `end-to-end-data-engineering-project-4413618`

**Double-check before deleting:** For each fork, click into it and confirm you haven't added your own commits. If you have, move those commits to a new repo under your name first (just clone → push to a new repo).

> ⚠️ **Deletion is permanent.** You'll type the repo name to confirm each time. GitHub retains some data for 90 days but the repo is gone from your profile immediately.

---

## 🛠️ Step-by-step execution — **automated with 2 scripts**

Two bash scripts live alongside this README. Run them in order from this folder.

### One-time setup — authenticate `gh` to public github.com

Your `gh` CLI may already be logged into GitHub Enterprise. Add public github.com:

```bash
gh auth login --hostname github.com
# Choose: HTTPS → login with web browser
# When prompted for scopes, grant:  repo, delete_repo
```

Verify:
```bash
gh api user --hostname github.com --jq '.login'   # should print: Pratik2895
```

### Step 1 — Push READMEs to all 6 keeper repos (~2 min)

```bash
cd github-readmes
bash push-keeper-readmes.sh
```

- Auto-creates the special `Pratik2895/Pratik2895` profile repo if missing
- Asks `y/N` before pushing to each repo
- Strips the HTML comment header and commits a clean `README.md`
- Safe to re-run — it simply overwrites `README.md`

### Step 2 — Delete forks + make noise repos private (~3 min)

```bash
bash cleanup-github-profile.sh
```

- **Asks `y/N` before every destructive action** — default is **N (skip)**
- Extra safety: verifies a repo is actually a fork before offering to delete
- Skips repos that are already private or already gone
- Prints a summary at the end

**What gets prompted:**
- 13 fork deletes (Bucket 3) — one prompt per fork, each asks explicit confirmation
- 10 visibility flips (Bucket 2) — one prompt per repo

Hit **Enter** (default N) on anything you want to keep. Hit **y** to confirm.

### Step 3 — Pin your 6 keepers (~2 min)

1. Go to your profile: `https://github.com/Pratik2895`
2. Click **Customize your pins**
3. Select:
   - ☑️ `ontario-real-estate`
   - ☑️ `AI-Stock-Intelligence-CAN-US-Markets`
   - ☑️ `F1race_Data_Engineering_DBricks`
   - ☑️ `Marketing-Analyst-Technical-Assignment`
   - ☑️ `Pratik2895.github.io`
   - ☑️ *(optional 6th)* `Promotional-Analytics-Unveiling-Success-Strategies` if you want a retail story
4. **Save pins**

### Step 4 — Update your GitHub bio (~30 sec)

On your profile page → click **Edit profile**:

**Bio** (160 char limit):
```
Data & Analytics Engineer · 5+ yrs · Databricks + PySpark + AWS · Bronze/Silver/Gold lakehouses, SLA-monitored pipelines, BI products execs trust.
```

**Additional fields:**
- 📍 Location: `Brampton, ON, Canada`
- 🔗 Website: `https://pratik2895.github.io`
- 🏢 Company: `@intuit`

---

## ✅ After — what your profile will look like

- Cyan portfolio badge in the profile README
- 6 pinned projects, each with a professional README
- ~13 total public repos (down from 30), all meaningful
- GitHub stats card and top-languages chart auto-rendering
- No forks cluttering the repo list

**Estimated total time: ~30 minutes.**

---

## 🧯 Safety checklist before deleting anything

- [ ] I've pulled / backed up any commits from forks I want to keep
- [ ] I've read each fork's commits quickly to confirm I don't care about them
- [ ] I'm okay with deletion being permanent

If uncertain about any single repo, **make it private instead of deleting**. You can always go back and delete it later.
