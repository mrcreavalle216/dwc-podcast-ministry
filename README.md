# Dominion World Center — Podcast Ministry Training App

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/YOUR_GITHUB_USERNAME/dwc-podcast-ministry)

A mobile-first, app-style training manual for the Dominion World Center Podcast Ministry volunteer team. Built as a single, self-contained HTML file that runs offline in any browser — no build step, no dependencies, no internet required.

> **"People are the mission. The equipment is the tool."**

> Replace `YOUR_GITHUB_USERNAME` above with your GitHub username once the repo is pushed (see "Push to GitHub" below). The badge then becomes a one-click "Deploy to Vercel" button.

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

First push this repo to GitHub (see below), then in the Vercel dashboard choose
"Add New… → Project", import the repo, set framework preset to **Other**
(build command: none, output dir: `.`), and deploy. After this, every
`git push` auto-deploys.

Either way the app is live at `https://<your-project>.vercel.app`.

### Push to GitHub

Create an empty repo on GitHub named `dwc-podcast-ministry` (no README/license —
this repo already has them), then from the extracted project folder:

```bash
cd dwc-podcast-ministry
git remote add origin https://github.com/YOUR_GITHUB_USERNAME/dwc-podcast-ministry.git
git branch -M main
git push -u origin main
```

If you used the `.bundle` file instead, clone from it first:

```bash
git clone dwc-podcast-ministry.bundle dwc-podcast-ministry
cd dwc-podcast-ministry
git remote set-url origin https://github.com/YOUR_GITHUB_USERNAME/dwc-podcast-ministry.git
git push -u origin main
```

### Custom domain

1. In the Vercel project: **Settings → Domains → Add**, enter your domain
   (e.g. `podcast.dominionwc.org`).
2. Vercel shows a DNS record to add. For a subdomain, add a **CNAME** record at
   your DNS provider pointing the subdomain to `cname.vercel-dns.com`.
3. Wait for DNS to propagate; Vercel issues an HTTPS certificate automatically.

For an apex/root domain (`dominionwc.org`), Vercel will instead give you an
**A record** to add. Since the church site already lives on that root domain,
a subdomain like `podcast.` or `training.` is usually the cleaner choice.

## Login & progress sync (optional)

By default the app needs no login and stores each person's progress in their own
browser. To add accounts, cloud sync across devices, and a leader dashboard of
who's completed training, follow **[SUPABASE.md](SUPABASE.md)** — a ~15-minute,
no-code setup using a free Supabase project (run `supabase-setup.sql`, paste two
keys). Until configured, the app runs exactly as it does now.

## Notes

- The HTML file is the single source of truth.
- A PDF can be generated for handouts, but it reflects an earlier document-style layout and is intentionally excluded from version control (see `.gitignore`).

## License / use

Internal ministry resource for Dominion World Center.
