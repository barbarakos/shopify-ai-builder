# Listicle Page: 7 Reasons Why Women Over 40 Are Switching to This Serum

**Date:** 2026-03-18
**Brand:** KelleSkin
**Prefix:** `ks`
**Theme dir:** `/Users/kosbarb/Documents/personal/shopify-claude`

---

## Overview

A conversion-focused listicle landing page targeting women over 40 dealing with unwanted facial hair. The page presents 7 compelling reasons to switch to the Kelle Skin Cyperus Rotundus Serum, supported by social proof, and drives traffic to the product page.

**Primary CTA:** Links to product page (`/products/viareline-skin-serum-pro`)
**Template URL:** `/pages/ks-listicle` (handle assigned in Shopify admin)

---

## Files to Create

| File | Purpose |
|------|---------|
| `sections/ks-listicle-hero.liquid` | Hero banner with headline and CTA |
| `sections/ks-listicle-reasons.liquid` | 7 alternating image/text reason rows |
| `sections/ks-listicle-stats.liquid` | 4-stat social proof bar |
| `sections/ks-listicle-testimonials.liquid` | 3-card testimonial strip |
| `sections/ks-listicle-cta.liquid` | Final CTA section |
| `templates/page.ks-listicle.json` | Shopify template wiring all sections |

---

## Section Designs

### Hero (`ks-listicle-hero.liquid`)
- **Background:** sage green (`#8B9A7C`)
- **Headline:** "7 Reasons Why Women Over 40 Are Switching to This Serum"
- **Subheadline:** "Discover why 87,000+ women have ditched the razor — for good."
- **CTA button:** "See the Serum →" → `/products/viareline-skin-serum-pro`
- **Typography:** Playfair Display headline, Inter subheadline, cream text
- **Schema settings:** headline, subheadline, button text, button URL

---

### Reasons (`ks-listicle-reasons.liquid`)

Layout: alternating image/text rows — odd reasons have image left, even have image right. On mobile, image stacks above text.

Each row contains:
- **Image:** square/4:3 ratio, 14px border-radius, AI placeholder with `data-image-prompt`
- **Decorative number:** large sage green (`#8B9A7C`) Playfair Display
- **Headline:** Playfair Display bold
- **Body copy:** Inter, ~40–60 words
- **No per-reason CTA** (global CTA at bottom)

| # | Headline | Copy Angle | Image Prompt |
|---|----------|-----------|--------------|
| 1 | It Works on All Hair Colors — Including Blonde, Grey & White | Unlike laser, which only targets pigment, this serum works on every hair color. Whether you have fine blonde peach fuzz or coarse grey chin hair, Cyperus Rotundus targets the follicle's growth mechanism — not the color. | Woman over 45 with silver/blonde hair examining smooth facial skin in mirror, natural light, warm cream tones |
| 2 | Most Women See Results in as Little as 2 Weeks | Within the first two weeks, hair starts growing back thinner and slower. By week 4–6, regrowth is up to 7x thinner. By week 8–12, most women barely need to remove hair at all. | Close-up of smooth glowing skin on a mature woman's face, soft natural light, botanical background |
| 3 | Say Goodbye to Razor Burns, Ingrowns & Irritation | Daily shaving and waxing leave skin textured, irritated, and full of dark spots. This serum doesn't just reduce hair — it heals. Hyaluronic Acid and Ceramide NP restore the skin barrier so your face finally feels smooth and calm. | Before/after style — irritated skin vs smooth hydrated skin, clinical aesthetic with warm tones |
| 4 | 100% Hormone-Safe — Works Locally, Not Systemically | A common concern for perimenopausal and menopausal women. This serum works only on the area where it's applied and does not enter the bloodstream or interfere with your hormones. Safe for sensitive, mature skin. | Woman confidently applying serum to face in natural light, sage green botanical background |
| 5 | Go From Daily Removal to Once a Week — or Less | Most users start removing hair once a week within a month, and once a month by month three. Some stop needing removal entirely. Imagine reclaiming your morning routine. | Woman enjoying coffee in morning light, relaxed, no makeup, glowing mature skin |
| 6 | Save Thousands vs. Laser, Waxing & Threading | The average woman spends $2,400+ per year on waxing alone. Three bottles of this serum cost $159. The math is obvious — and unlike laser, it works on all hair colors with no pain, no downtime. | Lifestyle flat lay: serum bottle alongside calculator or coins, cream and sage green styling |
| 7 | 60-Day Money-Back Guarantee — Zero Risk | We're so confident in this formula that if you don't see results in 60 days, you get a full refund. No questions asked. Over 16,374 five-star reviews say you won't need it. | Serum bottle with a soft gold/cream guarantee badge overlay, clean minimal product photography |

**Schema:** Each reason is a **block** of type `reason` with fields:
- `heading` (text)
- `body` (textarea)
- `image` (image_picker)
- `image_alt` (text)

Image placeholders use `{{ 'placeholder.svg' | asset_url }}` with `data-image-prompt` and `data-image-filename` attributes. Images use `loading="lazy"` on all below-fold instances (reasons 2–7); reason 1 image uses `loading="eager"` as it may be above the fold.

---

### Stats Bar (`ks-listicle-stats.liquid`)
- **Background:** sage green (`#8B9A7C`)
- **Text:** cream white
- **4 stats displayed:**
  - 16,374+ Five-Star Reviews
  - 98% Report Results
  - 7x Thinner Hair in 4–6 Weeks
  - 87,000+ Customers
- Displayed as a horizontal row on desktop, 2×2 grid on mobile
- **Schema settings:** each stat label and value editable

**Placement:** inserted between reason #4 and reason #5 in the template JSON.

---

### Testimonials (`ks-listicle-testimonials.liquid`)
- **Background:** warm cream (`#F5F2EE`)
- **3 testimonial cards** (white background, 14px border-radius, subtle shadow):
  - Sarah M. — ingrowns + irritation story
  - Caroline T. — perimenopause discovery story
  - Laura M. — menopause + laser comparison story
- Each card: star rating (5 stars), quote text, customer name
- Layout: 3-column desktop, single column mobile (stacked)
- **Schema:** Each testimonial is a **block** of type `testimonial` with fields:
  - `name` (text)
  - `quote` (textarea)
  - `rating` (range, 1–5, default 5)

---

### Final CTA (`ks-listicle-cta.liquid`)
- **Background:** cream `#F5F2EE`
- **Headline:** "Ready to stop the daily routine?"
- **Subheadline:** "Join 87,000+ women who made the switch."
- **Button:** "Shop the Serum →" → `/products/viareline-skin-serum-pro`
- **Schema settings:** headline, subheadline, button text, button URL

---

### Template (`templates/page.ks-listicle.json`)

The reasons section is **block-based** — each reason is a block of type `reason` with fields: `heading`, `body`, `image`, `image_alt`. The section is instantiated **twice** in the template JSON using distinct keys (`ks-listicle-reasons-1` and `ks-listicle-reasons-2`). The first instance contains blocks for reasons 1–4; the second contains blocks for reasons 5–7. The stats section is inserted between them.

Section order (with template JSON keys):
1. `ks-listicle-hero`
2. `ks-listicle-reasons-1` (reasons 1–4, blocks assigned individually)
3. `ks-listicle-stats`
4. `ks-listicle-reasons-2` (reasons 5–7, blocks assigned individually)
5. `ks-listicle-testimonials`
6. `ks-listicle-cta`

---

## Visual Specifications

| Property | Value |
|----------|-------|
| Page background | `#F5F2EE` (warm cream) |
| Heading font | Playfair Display |
| Body font | Inter |
| Primary color | `#8B9A7C` (sage green) |
| Accent color | `#7B6B9E` (purple) |
| Border radius | `14px` |
| Button style | Sage green pill, white uppercase text |
| Reason number style | Large (~120px), sage green, Playfair Display, low opacity decorative |
| Section alternation | White `#FFFFFF` / cream `#F5F2EE` backgrounds |

---

## Mobile Behavior
- Hero: stacks text, full-width button
- Reasons: image on top, text below (single column)
- Stats bar: 2×2 grid
- Testimonials: stacked single column
- All images: full-width on mobile

---

## Image Placeholders
All images use `{{ 'placeholder.svg' | asset_url }}` with:
- `data-image-prompt="<prompt>"` — for AI generation
- `data-image-filename="ks-listicle-<n>.jpg"` — for file naming

---

## Out of Scope
- No cart drawer integration
- No bundle picker on this page
- No video embeds
- No quiz integration
