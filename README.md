# pratik2895.github.io

**My personal portfolio** — a production-grade data engineer site built with Astro + Tailwind and deployed to GitHub Pages.

🌐 **Live:** https://pratik2895.github.io/

![Astro](https://img.shields.io/badge/Astro-5.x-BC52EE?style=flat-square&logo=astro&logoColor=white)
![Tailwind](https://img.shields.io/badge/Tailwind-3.x-06B6D4?style=flat-square&logo=tailwindcss&logoColor=white)
![GitHub Pages](https://img.shields.io/badge/Deploy-GitHub%20Pages-222?style=flat-square&logo=github)

---

## ✨ Features

- **Animated Medallion Flow** — SVG diagram of Kafka → Bronze → Silver → Gold → BI/ML with flowing data particles
- **Simulated Spark driver log stream** — realistic ingestion events (stage completions, AQE promotions, skew warnings, Delta commits). Pausable.
- **Per-project architecture diagrams** — each project card has its own animated dataflow SVG
- **Live rows-processed counter** — ticks up in real time against a career-scale seed
- **⌘K command palette** — Linear/Raycast-style fuzzy search for navigation
- **Scroll-progress bar · spotlight cursor · magnetic buttons**
- **Full SEO** — OpenGraph, Twitter cards, JSON-LD `Person` schema, sitemap, robots.txt
- **Zero JS by default** (Astro) — fast, accessible, GitHub-Pages-ready

---

## 🗂️ Structure

```
.
├── index.html                 # Built site served by GitHub Pages
├── assets/                    # Built CSS/JS bundles
├── projects/                  # Per-project case-study pages
├── images/                    # Profile + assets
├── PRATIK_A_BHIKADIYA_CV.pdf  # CV
└── v2/                        # Astro source
    ├── src/
    │   ├── components/        # Hero · About · Projects · SparkStream · CmdK · MedallionFlow …
    │   ├── content/projects/  # MD case studies (one file per project)
    │   ├── layouts/
    │   ├── pages/
    │   └── styles/
    ├── public/                # Static assets (favicon, robots.txt)
    ├── astro.config.mjs
    └── tailwind.config.mjs
```

---

## 🧪 Local development

```bash
cd v2
npm install
npm run dev          # http://127.0.0.1:4321
```

## 🚢 Rebuild and deploy

```bash
cd v2
npm run build        # outputs to v2/dist/

# from repo root
cp -r v2/dist/* .
git add -A
git commit -m "chore: rebuild site"
git push             # GitHub Pages auto-deploys
```

---

## 🧰 Tech

- [Astro 5](https://astro.build) — static site, zero JS by default
- [Tailwind CSS](https://tailwindcss.com) + typography plugin
- Google Fonts — Fraunces (display) + JetBrains Mono + Inter
- Content collections for type-safe project frontmatter
- Deploys straight from `main` via GitHub Pages (no workflow required, `.nojekyll` included)

---

## 📫 Contact

- 🌐 [pratik2895.github.io](https://pratik2895.github.io)
- 💼 [LinkedIn](https://www.linkedin.com/in/pratikbhikadiya/)
- 📧 bhikadi@uwindsor.ca
