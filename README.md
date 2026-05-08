# Reshma Beauty — Henna Haircare Campaign

Two-piece marketing funnel for the Henna Shampoo + Conditioner bundle (-30%):

1. **Email newsletter** (`/index.html`) — table-based, inline CSS, ESP-ready
2. **Landing page** (`/landing/`) — Tailwind, mobile-first, sticky CTA, Vercel-ready

## File structure

```
.
├── index.html                Newsletter (table-based, inline CSS)
├── images/                   Newsletter assets (~580 KB)
├── landing/
│   ├── index.html            Landing page
│   ├── style.css             Compiled Tailwind (19 KB minified)
│   ├── src/input.css         Tailwind source
│   ├── tailwind.config.js
│   ├── package.json          npm run build / dev / deploy
│   ├── vercel.json           Vercel config (cache headers, security headers)
│   ├── favicon.svg           Brand favicon (R initial, gold on green)
│   ├── favicon-32.png        Fallback PNG favicon
│   ├── apple-touch-icon.png  iOS home-screen icon
│   ├── robots.txt
│   ├── sitemap.xml
│   └── images/               Same assets as newsletter (self-contained for Vercel)
├── scripts/
│   └── set-url.sh            Run after first Vercel deploy to swap [YOUR_VERCEL_URL]
└── README.md
```

## Deploy the landing page to Vercel

**Option A — Web UI (zero CLI):**

1. Go to https://vercel.com/new
2. Import the `jflpro/henna` repo
3. Set **Root Directory** to `landing`
4. **Framework preset**: `Other`
5. **Build Command**: `npm run build`
6. **Output Directory**: `.`
7. Click **Deploy**

**Option B — CLI:**

```bash
cd landing
npx vercel login    # browser flow
npx vercel deploy --prod
```

**After first deploy** — Vercel gives you a URL like `https://reshma-henna.vercel.app`.
Run the helper to swap it everywhere (Open Graph, canonical, sitemap, robots, AND newsletter CTAs):

```bash
./scripts/set-url.sh https://reshma-henna.vercel.app
git add . && git commit -m "Wire production URL" && git push
```

## Tech specs

- 600 px container with mobile-first media query at `max-width: 600px`
- Table-based layout, inline CSS, no JS, no web fonts
- Tested-friendly with: Gmail, Outlook (mso conditionals), Apple Mail, Mailchimp
- Total weight: HTML ~32 KB + images ~580 KB = under 1 MB ✓

## Color palette

| Role | Hex |
|---|---|
| Background | `#F9F9F7` |
| Primary green | `#1B3B26` |
| Secondary green | `#3D6346` |
| CTA brown | `#704F37` |
| Accent gold | `#F2C94C` |
| Text | `#1A1A1A` |

## Deployment

1. Open `index.html` in a browser to preview locally.
2. Upload to your ESP:
   - **Mailchimp**: Templates → Create → Code your own → Paste in code → upload images via the campaign builder
   - **Klaviyo**: Templates → Create New → HTML editor → paste source → host images on Klaviyo CDN
3. Replace relative `images/...` paths with absolute CDN URLs once images are uploaded.

## UTM tracking

All 5 CTAs carry the same campaign tag:

```
?utm_source=email&utm_medium=newsletter&utm_campaign=henna_bundle_30
```

`utm_content` differs per placement: `hero_cta`, `product_shampoo`, `product_conditioner`, `bundle_primary`, `bundle_reinforce`.

## Production readiness

### 🟢 Landing page — code is ready to ship

| Item | Status |
|---|---|
| Deployed live | ✅ https://henna-pied.vercel.app/ |
| Tailwind compiled (~24 KB minified) | ✅ |
| Mobile-first responsive + sticky promo banner + sticky bottom CTA | ✅ |
| SEO + Open Graph + favicons + sitemap + robots | ✅ |
| Lighthouse mobile | ✅ Performance 90 / Accessibility 93 / SEO 100 |
| Real Shopify variant IDs wired | ✅ shampoo `42332141519070`, conditioner `42332142043358` |
| Auto-add-to-cart on every "Buy bundle" CTA (banner / card / final / popups) | ✅ |
| Solo product CTAs route through Compare popup (3 options) | ✅ |
| Popup funnel: bundle (centered) / upsell / product detail / compare | ✅ |
| Hover triggers on PC, time + exit-intent triggers on mobile | ✅ |

### 🟡 Newsletter — code is ready, ESP setup needed

| Item | Status |
|---|---|
| HTML structure + responsive + 100 % English copy | ✅ |
| Compressed images (~580 KB total) | ✅ |
| 5 CTAs route through https://henna-pied.vercel.app | ✅ |
| Real postal address in footer | 🔴 placeholder `[REGISTERED ADDRESS]` (CAN-SPAM blocker) |
| Unsub / Update-preferences merge tags | 🔴 awaits ESP choice (CAN-SPAM blocker) |
| Real social icons | 🟡 PNGs to provide |
| Subject line + From email + Reply-to | 🟡 to set in ESP |
| Litmus / device test | 🟡 to run |
| Email-friendly image hosting (ESP CDN or absolute URLs) | 🟡 to do at upload |

### 🔴 Shopify — admin setup blocking

| Item | Status |
|---|---|
| Variant IDs wired & cart permalinks tested HTTP 200 | ✅ |
| **Automatic discount code `HENNA30` (30 % off bundle)** | 🔴 **BLOCKER** — must be created in Shopify Admin |
| Real campaign end date (currently Sun May 10 2026 23:59 PST in the countdown) | 🔴 confirm |

---

## What's left to ship — checklist

### TIER 1 — Landing-only launch (do this NOW)

The landing is code-ready. **Only one blocker** before traffic can convert:

- [ ] **Create `HENNA30` automatic discount** in Shopify Admin → Discounts → Create automatic discount → 30 % off, applied when cart contains both Henna Shampoo + Henna Conditioner. Without it, clicking a bundle CTA opens the Shopify cart with both products but **at full price** ($31.98 instead of $22.39).
- [ ] **End-to-end test**: open https://henna-pied.vercel.app/ on a phone → click "Unlock 30% Bundle" → confirm both products land in the cart with the discount applied
- [ ] (optional) Confirm `Sun May 10 2026 23:59 PST` is the real campaign end date in the countdown banner — adjust if not

### TIER 2 — Newsletter send (when you're ready to mail)

Cannot send without:

- [ ] **Real postal address** — pull from Shopify Admin → Settings → Store details and replace `[REGISTERED ADDRESS]` in the newsletter footer
- [ ] **Pick ESP** (Mailchimp / Klaviyo / Brevo) — replace the two `href="#"` in the newsletter footer with the ESP's merge tags for *Unsubscribe* and *Update preferences*
- [ ] **Real social icons** (4 PNGs, ~36 × 36 px, gold on dark green) for IG / FB / TikTok / YouTube
- [ ] **Verify** that `@reshmabeauty` exists on Instagram + Facebook (HTTP probes hit the login wall, manual check needed)
- [ ] **Subject line** — pick from the 5 variants in the section below or A/B-test
- [ ] **From name + From email + Reply-to** (recommend `Reshma Beauty <hello@reshmabeauty.com>`)
- [ ] **Image hosting**: upload the 5 images via the ESP's image library (simplest) OR replace `src="images/..."` with absolute CDN URLs
- [ ] **Litmus test** — Gmail desktop+mobile, Outlook 365, Apple Mail iOS+macOS, dark mode
- [ ] **Self-test**: send to your own inbox, open on iPhone + Android, click every link to validate redirects and UTMs
- [ ] **Mail-Tester** score ≥ 8/10

### TIER 3 — Nice-to-have polish (post-launch)

- [ ] **Custom domain** for the landing (e.g. `henna-bundle.com`) — better trust, better SEO. Vercel → Project Settings → Domains → Add. Re-run `scripts/set-url.sh` afterward.
- [ ] **Analytics** — pick one:
  - Vercel Analytics (1 click in dashboard, free up to 2 500 events/mo)
  - Plausible (snippet ready in `<head>` as a comment, ~9 $/mo)
  - Google Analytics 4 (free, but cookie banner becomes mandatory in EU)
- [ ] **Heatmap** — Microsoft Clarity (free, unlimited) to see where users click
- [ ] **Re-run Lighthouse** after deploy to confirm scores held (target ≥ 95 perf/a11y after the latest fixes)
- [ ] **PageSpeed Insights** at https://pagespeed.web.dev/?url=https://henna-pied.vercel.app
- [ ] **Open Graph preview** at https://www.opengraph.xyz
- [ ] **Real device test** — Android Chrome + iOS Safari
- [ ] **A/B test plan** — subject line + bundle CTA copy + popup variants
- [ ] **Day-3 re-engagement email** to non-openers with a different subject

---

---

## TO-DO — Newsletter (pre-send checklist)

### Legal blockers (cannot send without)

- [ ] Pull real postal address from Shopify Admin → *Settings → Store details* and replace `[REGISTERED ADDRESS]` in the footer
- [ ] Pick the ESP (Mailchimp / Klaviyo / Brevo / other) and replace the two `href="#"` in the footer with the unsubscribe and update-preferences merge tags

### Assets to provide

- [ ] Real social icons — 4 transparent PNGs (36×36 px), gold `#F2C94C` on dark green: Instagram, Facebook, TikTok, YouTube. Currently rendered as text "IG/FB/TT/YT"
- [ ] Manually confirm `@reshmabeauty` exists on Instagram and Facebook (HTTP probes hit the login wall)
- [ ] Light-version footer logo if contrast on dark green is too low

### Shopify / e-commerce

- [ ] Create automatic discount code `HENNA30` (30% off Henna Shampoo + Henna Conditioner) in Shopify Admin → *Discounts*. Alternative: re-point Bundle CTAs to the existing `Henna Haven Deluxe Hair Care Bundle` product
- [ ] Confirm the real campaign end date (the urgency line currently reads "Sunday at 11:59 PM PST" — which Sunday?)

### Image hosting (technical blocker)

- [ ] Choose hosting strategy:
  1. Upload directly into the ESP (Mailchimp/Klaviyo handle their own CDN) — **simplest, recommended**
  2. External CDN (Cloudinary / Bunny / Imgix)
  3. Shopify CDN of reshmabeauty.com
- [ ] Once uploaded, replace `src="images/..."` with absolute `https://...` URLs

### ESP configuration

- [ ] Subject line — pick one of the 5 variants (or A/B test):
  1. `Save 30% — your strongest hair is one ritual away ✦`
  2. `Your henna duo is 30% off (until Sunday)`
  3. `Stronger, fuller hair starts here — 30% off the bundle`
  4. `Botanical haircare, the way Ayurveda intended`
  5. `Open before Sunday: -30% on Henna Shampoo + Conditioner`
- [ ] From name (e.g. `Reshma Beauty`)
- [ ] From email (e.g. `hello@reshmabeauty.com` — avoid `noreply@`)
- [ ] Reply-to address (must be monitored)
- [ ] Audience segment (full list / 30-day engaged / past buyers / etc.)
- [ ] Send time (recommended for cosmetics: Tuesday or Thursday 10 AM in recipient's local time)

### QA before send

- [ ] Litmus / Email-on-Acid render test: Gmail desktop+mobile, Outlook 365, Apple Mail iOS+macOS, dark mode
- [ ] Self-test send opened on iPhone + Android
- [ ] Click every link on the test version to validate redirects + UTMs
- [ ] Images-off test: verify all `alt` attributes are intelligible
- [ ] Mail-Tester score ≥ 8/10

### Optimization (optional)

- [ ] A/B test subject line and bundle button copy ("Unlock My 30% Bundle" vs "Get the Deal")
- [ ] Define KPI targets: Open >25%, CTR >3%, Conversion >1%
- [ ] Set up Shopify Analytics attribution for `utm_campaign=henna_bundle_30`
- [ ] Day-3 follow-up plan (resend to non-openers with a different subject line)

---

## TO-DO — Landing page

### Already done

- [x] Mobile-first responsive design (3 cards stack vertical, side-by-side on `md:`)
- [x] Sticky bottom CTA on mobile, header CTA on desktop, with iOS safe-area inset
- [x] Tailwind compiled to production: 3 MB CDN runtime → **18 KB minified `style.css`**
- [x] SEO meta + Open Graph + Twitter Card + canonical (absolute URLs for og:image)
- [x] Favicons: SVG (gold "R" on green), 32×32 PNG, 180×180 Apple touch icon
- [x] `robots.txt` + `sitemap.xml`
- [x] `vercel.json`: long cache on assets, security headers
- [x] Plausible analytics snippet placed in `<head>` (commented, ready to activate)
- [x] `scripts/set-url.sh` to swap placeholder URL everywhere after first deploy
- [x] **Deployed to Vercel** — live at https://henna-pied.vercel.app/
- [x] **Production URL wired everywhere** (og:url, canonical, sitemap, robots, AND newsletter CTAs)
- [x] **Newsletter ↔ Landing funnel connected** — all 5 newsletter CTAs now route through the landing
- [x] **Lighthouse fixes applied** (commit `ef2e2e4`):
  - Hero preload + `fetchpriority="high"` + WebP source (177 KB → 144 KB)
  - Explicit `width`/`height` on every `<img>` (kills layout shift, fixes audit)
  - Google Fonts deferred via `preload + onload` pattern (saves ~530 ms render-block)
  - Lazy-load + `decoding="async"` on below-fold images
  - Contrast bumped on `text-white/70` and `text-white/60` lines

### Live site smoke tests

- [x] All 5 newsletter CTAs return HTTP 200 on the live URL with full UTM strings
- [x] og:image accessible at `https://henna-pied.vercel.app/images/hero-banner.jpg`
- [x] Landing renders the expected `<title>` + Hero copy
- [x] Lighthouse mobile: **Performance 90 · Accessibility 93 · Best Practices 73 · SEO 100**
  - LCP 3.5 s · FCP 1.6 s · CLS 0.001 · TBT 80 ms · SI 1.6 s

### P0 — Still to verify (user-side)

- [ ] **Re-run Lighthouse** after the LCP/contrast fixes to confirm Performance ≥ 95 and Accessibility ≥ 95
- [ ] Test the live URL on a real Android (Chrome) + iOS (Safari) — focus on sticky CTA + safe-area
- [ ] PageSpeed Insights https://pagespeed.web.dev/ (the API quota was hit during automated test, use the web UI)
- [ ] Open Graph preview check at https://www.opengraph.xyz/url/https%3A%2F%2Fhenna-pied.vercel.app/

### P1 — Custom domain (optional but recommended)

- [ ] Buy a domain (Namecheap / Cloudflare, ~$12/yr) — e.g. `henna-bundle.com`, `reshma-henna.com`
- [ ] Vercel → Project Settings → Domains → Add → follow DNS instructions
- [ ] Update `og:url`, canonical, sitemap, robots with the new domain
- [ ] Re-run `set-url.sh` with the custom domain

### P1 — Analytics / tracking

- [ ] Pick the tool:
  - **Plausible.io** — snippet already prepared in `<head>` as a comment. Sign up, uncomment, replace `YOUR_DOMAIN`
  - **Google Analytics 4** — paste the gtag.js snippet into `<head>`
  - **Vercel Analytics** — toggle on inside the Vercel dashboard (zero code)
- [ ] Configure events: clicks on each CTA, scroll depth (25/50/75/100%), outbound clicks to reshmabeauty.com
- [ ] Verify UTM parameters surface correctly in the analytics dashboard

### P1 — Funnel → Shopify

- [ ] Create the `HENNA30` automatic discount in Shopify Admin → Discounts (30% off Henna Shampoo + Henna Conditioner)
- [ ] Test a real click from the landing → confirm Shopify cart opens with the bundle and -30% applied
- [ ] Alternative if you don't want to create the code: re-point Bundle CTAs to the existing `Henna Haven Deluxe Hair Care Bundle` product

### P2 — Content enrichment (lifts conversion)

- [ ] Customer testimonials section (3-5 reviews with photos — pull from existing reshmabeauty.com reviews)
- [ ] FAQ section (4-5 questions: color-treated hair, frequency of use, vegan, shipping, returns)
- [ ] Real countdown timer synced with the offer end date (JS, e.g. `2d 14h 32m`)
- [ ] Before/after hair photos (high-impact in cosmetics)
- [ ] Trust badges row: "Made in USA", "Cruelty-Free", "100% Plant-Based"

### P2 — Email capture (for non-buyers)

- [ ] Exit-intent popup or banner: "Not ready? Grab 10% off your first order" → email capture
- [ ] Wire it to Klaviyo / Mailchimp to nurture the list

### P2 — Legal

- [ ] Real postal address — replace `[REGISTERED ADDRESS]` in the footer (same blocker as the newsletter)
- [ ] No cookie banner needed if Plausible. Required if GA4 is used and traffic includes EU
- [ ] Verify Privacy / Terms / Contact links resolve to existing pages on reshmabeauty.com

### P3 — Post-launch optimization

- [ ] Heatmap: Hotjar (free up to 35 sessions/day) or Microsoft Clarity (free, unlimited)
- [ ] A/B tests:
  - CTA color (gold vs brown)
  - Hero headline ("Stronger, Fuller Hair" vs "Save 30% This Week")
  - Mobile card order (Bundle first?)
- [ ] KPI targets:
  - Bounce rate < 50%
  - Time on page > 45 sec
  - CTR to Shopify > 8%
  - Landing → purchase conversion > 3%

### Recommended sequence

| Priority | Task | Time |
|---|---|---|
| **P0** (now)        | Provide Vercel URL → run `set-url.sh`        | 2 min |
| **P0**              | Lighthouse + PageSpeed on the live URL       | 5 min |
| **P1** (this week)  | Activate Plausible + Vercel Analytics        | 15 min |
| **P1**              | Create Shopify `HENNA30` discount             | 10 min |
| **P1**              | Test landing → Shopify checkout              | 5 min |
| **P2**              | Add testimonials + FAQ section               | 1 h |
| **P2**              | Real postal address in footer                | 5 min |
| **P3** (post-launch) | Heatmap + A/B tests                          | continuous |
