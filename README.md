# Atolla — landing site

A single-file static landing page (`index.html`). No build step, no dependencies — it deploys to Vercel as-is.

The page's only job: make a clear first impression and capture two kinds of interested people — scientists who might contribute data, and organizations that might license it. It is intentionally minimal and jargon-free.

---

## 1. Keep the old site, start a new repo

Don't touch the existing Atolla repo — leave it live. Create a **new** repo for this rebuild:

```bash
# from inside this atolla-site folder
git init
git add .
git commit -m "Atolla landing page v1"
git branch -M main
git remote add origin https://github.com/<your-org>/atolla-site.git
git push -u origin main
```

The old site stays untouched and online until you decide to switch the domain — so there's no downtime risk.

## 2. Deploy on Vercel

1. Go to vercel.com → **Add New… → Project**.
2. Import the new `atolla-site` repo.
3. Framework Preset: **Other** (it's plain HTML — no build command, output dir is the repo root).
4. **Deploy.** You'll get a live `https://atolla-site-xxxx.vercel.app` URL in under a minute.
5. When you're ready, add your custom domain (`atolla.bio`) under **Project → Settings → Domains**. The old site keeps serving the domain until you point DNS at Vercel, so flip it only when you're happy.

Every push to `main` redeploys automatically.

## 3. Wire up the two forms (required before launch)

The page is static, so the forms need a third-party endpoint to receive submissions. Easiest option: **[Formspree](https://formspree.io)** (free tier is fine).

1. Create two Formspree forms — one for scientists, one for buyers.
2. In `index.html`, replace the two placeholders:
   - `https://formspree.io/f/REPLACE_SCIENTIST_ID`
   - `https://formspree.io/f/REPLACE_BUYER_ID`
   with your real endpoint URLs.
3. Submissions then land in your inbox / Formspree dashboard.

Alternatives that work the same way: Tally, Getform, or a Vercel serverless function if you'd rather keep it in-house later.

## 4. Editing content

Everything lives in `index.html`. Copy is in plain HTML — search for the section you want (`id="problem"`, `id="how"`, `id="proof"`, etc.) and edit the text directly. Colors are CSS variables at the top of the `<style>` block (ocean palette, matched to the pitch deck).

To preview locally, just open `index.html` in a browser, or run:

```bash
python3 -m http.server 8000   # then visit http://localhost:8000
```

---

## What this site deliberately does NOT include

Keep these **off** the public site (they're investor/internal only):

- The pitch deck (send it gated, after someone replies)
- The cap table
- The founders' agreement
- The financial model and the worked-transaction dollar figures

Two guardrails baked into the copy, keep them:

- The scientist path says **"let's talk" / "founding contributor"** — it does **not** advertise "get equity." Publicly offering equity for data is a securities solicitation; keep equity conversations private and per-person.
- The footer carries a short disclaimer that the site is informational and not an offer of securities or a binding agreement.

---

## Files

```
atolla-site/
├── index.html   # the entire site
└── README.md    # this file
```
