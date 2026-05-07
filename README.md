# Reshma Beauty — Henna Haircare Newsletter

Production-ready responsive HTML email promoting the Henna Shampoo + Conditioner with a 30% bundle discount.

## File structure

```
.
├── index.html               Email template (table-based, inline CSS)
└── images/                  Compressed assets (~580 KB total)
    ├── logo-reshma.png
    ├── hero-banner.jpg
    ├── shampoo-bottle.jpg
    ├── conditioner-bottle.jpg
    └── botanical-lifestyle.jpg
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

## Current state

| Block | Status |
|---|---|
| HTML structure & responsive | ✅ |
| English conversion-optimized copy | ✅ |
| Compressed images (-97%) | ✅ |
| URLs verified against live site | ✅ |
| UTMs on 5 CTAs | ✅ |
| Timezone PST | ✅ |
| Postal address | 🟡 placeholder, awaits real value |
| Unsub / preferences links | 🟡 awaits ESP choice |
| Shopify discount code `HENNA30` | 🟡 awaits creation |
| Real social icon PNGs | 🔴 to provide |
| Litmus / QA | 🔴 to run |

---

## TO-DO — Pre-send checklist

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
