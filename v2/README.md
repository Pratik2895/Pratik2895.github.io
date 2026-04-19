# Portfolio v2 — Astro + Tailwind

Source for the `pratik2895.github.io` portfolio. The **built static output is
committed to the repo root** so GitHub Pages serves it directly.

## Local development

```bash
cd v2
npm install
npm run dev     # http://127.0.0.1:4321
```

## Rebuild and ship

```bash
cd v2
npm run build   # outputs to v2/dist/

# From repo root:
cp -r v2/dist/* .
git add -A
git commit -m "chore: rebuild site"
git push
```

## Editing content

- **Project cards** — `v2/src/content/projects/*.md` (one file per project; frontmatter
  drives the card and detail page)
- **Hero / About / Experience / Skills / Contact** — `v2/src/components/*.astro`
- **Global styles** — `v2/src/styles/global.css`
- **Tailwind tokens** — `v2/tailwind.config.mjs`

## Feature stack

- Astro 5 static site — zero JS by default
- Tailwind CSS + typography plugin
- JetBrains Mono + Fraunces + Inter (Google Fonts)
- Animated SVG architecture diagrams per project (`ArchDiagram.astro`)
- Live medallion-flow animation in hero (`MedallionFlow.astro`)
- Simulated Spark driver log stream (`SparkStream.astro`)
- Cmd/Ctrl+K command palette (`CmdK.astro`)
- Full SEO: OpenGraph, Twitter cards, JSON-LD Person, sitemap, robots.txt
