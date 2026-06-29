# Atolla — landing site

A single-file static landing page (`index.html`). No build step, no dependencies — it deploys to Vercel as-is.

The page's only job: make a clear first impression and capture two kinds of interested people — scientists who might contribute data, and organizations that might license it. It is intentionally minimal and jargon-free.

**Repository:** https://github.com/LMMinale/Atolla_Pivot1

---

## 1. Connect this folder to GitHub and push

Run these on your computer, from inside this `atolla_pivot` folder.

> If a stray `.git` folder is already here (an artifact of the cloud sync), delete it first so you start clean.
> Windows PowerShell: `Remove-Item -Recurse -Force .git`

```bash
git init -b main
git add .
git commit -m "Atolla landing page v1"
git remote add origin https://github.com/LMMinale/Atolla_Pivot1.git
git push -u origin main
```

After this first push, you never touch git again — just double-click **`deploy.bat`** to ship future changes.

> If `git push` says the remote already has commits (e.g. you created the repo with a README), run `git pull origin main --allow-unrelated-histories` once, then push again.

## 2. Deploy on Vercel

1. Go to vercel.com → **Add New… → Project**.
2. Import the **Atolla_Pivot1** repo.
3. Framework Preset: **Other** (it's plain HTML — no build command, output dir is the repo root).
4. **Deploy.** You'll get a live `https://atolla-pivot1-xxxx.vercel.app` URL in under a minute.
5. When you're ready, add your custom domain (`atolla.bio`) under **Project → Settings → Domains**. The old site keeps serving the domain until you point DNS at Vercel, so flip it only when you're happy.

Every push to `main` redeploys automatically.

## 3. Wire up the two forms (required before launch)

The page is static, so the forms need a third-party endpoint to receive submissions. We use **[Sheet Monkey](https://sheetmonkey.io)** (free up to ~100 submissions/month), which writes submissions straight into a Google Sheet.

1. Sign in to Sheet Monkey with Google and create (or connect) a Google Sheet.
2. In **row 1** of the sheet, add these column headers exactly (case-sensitive) so both forms can share one sheet:
   `Timestamp` · `audience` · `name` · `email` · `about_data` · `organization`
3. In Sheet Monkey, create a **form** pointed at that sheet. It gives you an endpoint like `https://api.sheetmonkey.io/form/AbC123`.
4. In `index.html`, replace the two placeholders with that endpoint ID:
   - `https://api.sheetmonkey.io/form/REPLACE_WITH_SCIENTIST_FORM_ID`
   - `https://api.sheetmonkey.io/form/REPLACE_WITH_BUYER_FORM_ID`
   Use the **same** ID for both to collect everything in one sheet (filter by the `audience` column), or make two Sheet Monkey forms for two separate sheets.
5. Submissions then append to your Google Sheet as new rows. The endpoint is write-only, so it's safe to leave in the public HTML.

The forms submit via `fetch` (AJAX): visitors stay on the page and see an inline "Thanks" message instead of being redirected. The hidden `Timestamp` field auto-fills the submission time (Sheet Monkey magic value), and a hidden `audience` field tags each row `scientist` or `buyer`.

Alternatives that work the same way: Form2Sheet, Getform, Tally, or a Vercel serverless function if you'd rather keep it in-house later.

## 3a. Analytics (PostHog)

The site sends product analytics to **[PostHog](https://posthog.com)** (US Cloud). The snippet sits in the `<head>` of `index.html` and `privacy.html` with the public project key (`phc_…`), which is write-only and safe to expose. On top of automatic pageviews/clicks, the site fires named custom events: `button_clicked` (with button text), `outbound_link_clicked`, `scroll_depth_reached` (25/50/75/100%), and `lead_form_submitted` (with `audience`). The project's authorized URL is set to `https://atolla.bio` in PostHog settings.

## 4. Editing content

Everything lives in `index.html`. Copy is in plain HTML — search for the section you want (`id="problem"`, `id="how"`, `id="dataset"`, `id="scientists"`, `id="buyers"`) and edit the text directly. The visual style (fonts, the teal `#0e7c7b` accent, borders) is in the `<style>` block at the top, matched to the original Atolla site.

To add a real hero photo, drop an image at `images/hero.jpg` and add `url('images/hero.jpg')` to the `background` line in the `.hero` rule.

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
atolla_pivot/
├── index.html    # the main landing page (forms + analytics live here)
├── privacy.html  # privacy policy page
├── images/       # hero / background images
├── deploy.bat    # double-click to commit + push (auto-deploys via Vercel)
├── vercel.json   # Vercel config (clean URLs)
├── .gitignore
└── README.md     # this file
```
