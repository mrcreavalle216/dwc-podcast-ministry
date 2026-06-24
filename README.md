# Dominion World Center — Podcast Ministry Training App

A mobile-first, app-style training manual for the Dominion World Center Podcast Ministry volunteer team. Built as a single, self-contained HTML file that runs offline in any browser — no build step, no dependencies, no internet required.

> **"People are the mission. The equipment is the tool."**

## What it is

An interactive onboarding and training tool that replaces a long printed handbook with a tap-driven experience. It is designed for volunteers with little to no podcasting experience.

## Features

- **Bottom tab navigation** — Home, Learn, Gear, Session, Quiz
- **Progress tracking** — live rings for Learn, Checklists, and Quiz (saved in the browser)
- **Learn** — 7 bite-size lessons, including a swipeable, tap-to-flip "7 Principles" carousel
- **Gear** — tap-to-flip equipment cards with setup tips, plus a quick-fix troubleshooting list
- **Session** — role-based pre/production/post checklists with a "Draw a surprise challenge" team activity
- **Quiz** — 6-question knowledge check with instant feedback and scoring
- **Dark mode** and full offline support
- Illustrated throughout with inline SVG (no external images)

## The equipment covered

Sony FX30 · DJI Pocket 3 · RØDECaster Duo · 2× Shure SM7B · MacBook Air · Ecamm Live

## Usage

Open `Dominion_World_Center_Podcast_Ministry_Training_Manual.html` in any modern browser, or add it to a phone's home screen for an app-like launch. Progress is stored per-device in the browser, so each volunteer tracks their own.

## Deploying to Vercel

This is a zero-config static site. `index.html` is the entry point Vercel serves at the root URL; `vercel.json` adds clean URLs and basic security headers.

**Option A — Vercel CLI (fastest):**

```bash
npm i -g vercel        # one-time
cd dwc-podcast-ministry
vercel                 # follow prompts, then:
vercel --prod          # promote to production
```

**Option B — GitHub + Vercel dashboard:**

1. Push this repo to GitHub.
2. In the Vercel dashboard, "Add New… → Project" and import the repo.
3. Framework preset: **Other**. Build command: none. Output dir: `.` (root). Deploy.

Either way the app is live at `https://<your-project>.vercel.app`.

## Notes

- The HTML file is the single source of truth.
- A PDF can be generated for handouts, but it reflects an earlier document-style layout and is intentionally excluded from version control (see `.gitignore`).

## License / use

Internal ministry resource for Dominion World Center.
