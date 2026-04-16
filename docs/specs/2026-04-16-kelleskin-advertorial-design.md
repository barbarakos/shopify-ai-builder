# KelleSkin Advertorial — Design Spec
**Date:** 2026-04-16
**Brand:** KelleSkin (`ks` prefix)
**Page type:** Advertorial
**Template:** `page.ks-advertorial.json`

---

## Context

Retargeting advertorial for the Kelle Skin Cyperus Rotundus Serum. Traffic is warm — visitors have seen the brand before but haven't converted. Primary objection to crush: *"I've tried things before and nothing worked."* Angle: authority + savings — explains why every previous hair removal method fails at the follicle level, then positions Cyperus Rotundus as the clinically proven solution. Primary offer: **Buy 2 Get 1 Free — $106 AUD, 12-week supply, free shipping.**

---

## Brand Tokens

| Token | Value |
|---|---|
| Primary color | `#8B9A7C` (sage green) |
| Secondary / background | `#F5F2EE` (warm cream) |
| Accent | `#7B6B9E` (muted purple) |
| Text | `#303030` |
| Font heading | Playfair Display |
| Font body | Inter |
| Border radius | `14px` |
| CTA style | Sage green pill, white uppercase text |

---

## Naming Convention

`data-shopify-section` values use the **unprefixed** section name (e.g. `advertorial-header`). The shopify-designer agent prepends the brand prefix when naming files, producing `sections/ks-advertorial-header.liquid`. Do NOT include `ks-` in the `data-shopify-section` attribute — it will result in double-prefixed filenames.

---

## Section Structure

### 1. Editorial Header
**`data-shopify-section="advertorial-header"`**
- Full-width sage green bar (`#8B9A7C`)
- Left: "KelleSkin Journal" in small caps (Inter, white)
- Center: category tag — "Skincare + Wellness"
- Right: publication date
- Thin cream divider below
- Purpose: frames page as editorial content, not an ad
- **Mobile:** single row, center-aligned, smaller text

### 2. Hero
**`data-shopify-section="advertorial-hero"`**
- Split layout: left text, right product image. **Mobile:** image above, text below.
- Headline (Playfair Display, bold italic, large): *"Why Women Over 40 Are Quietly Ditching Waxing — And Never Going Back"*
- Subheadline (Inter): "The ancient botanical that dermatologists say attacks facial hair at the root — not just the surface."
- No CTA button — advertorials should not open with a sell
- Product image: lifestyle shot placeholder (see Image Placeholders)
- Background: warm cream

### 3. Hook
**`data-shopify-section="advertorial-hook"`**
- Cream background, centered layout
- Large stat callout: `$2,400` in Playfair Display (large, sage green)
- Label below: "The average woman spends this every year on waxing and threading."
- Body copy (3 short paragraphs, max 3 lines each):
  - *"You book the appointment. You pay the price. You go through the pain. And a week later — there it is again."*
  - *"Whether it's waxing, threading, laser, or shaving — every option on the market treats the same symptom over and over. None of them treat the cause."*
  - *"So the hair comes back. And so do the costs."*
- Closing line (bold italic): *"And the worst part? Not one of those dollars addressed why the hair keeps coming back."*
- **Mobile:** same layout, full-width centered

### 4. Why Everything Fails
**`data-shopify-section="advertorial-why-fails"`**
- Cream background
- H2: "Every Method You've Tried Was Designed to Remove. Not to Stop."
- Three-column icon layout, one per failed method:
  - **Waxing** — removes from root, but the follicle is untouched and fully intact. Hair returns within days.
  - **Laser** — only disrupts pigmented follicles. Does nothing for blonde, white, grey, or red hair. Requires 6–12 expensive sessions.
  - **Shaving** — cuts at surface only. Hair returns faster and appears thicker with every pass.
- Sage green icons, clean minimal style
- Summary line below columns (bold, centered): *"Every method you've tried was designed to remove. None were designed to stop."*
- **Mobile:** three columns stack to single column

### 5. Turning Point
**`data-shopify-section="advertorial-turning-point"`**
- Full-width sage green background (`#8B9A7C`), centered text, white copy
- Headline (Playfair Display italic, white): *"Then Egyptian Botanists Discovered Something Different"*
- Para 1: *"For centuries, women in ancient Egypt used a botanical called Cyperus Rotundus — not to remove hair, but to slow its growth over time. Modern clinical research has since confirmed what they observed: this root extract progressively weakens hair follicles, causing hair to grow back thinner, slower, and sparser."*
- Para 2: *"The key compound — γ-curcumene — suppresses the hormonal signals (DHT) that tell follicles to produce hair. It doesn't pull. It doesn't burn. It works from inside the follicle."*
- Closing line (bold white): *"It doesn't remove hair. It tells the follicle to stop producing it."*
- No product name yet — keep the narrative going
- **Mobile:** same full-width, centered, padding adjusted

### 6. Solution Reveal
**`data-shopify-section="advertorial-solution"`**
- Cream background, two-column layout. **Mobile:** pull-quote stat first (top), body copy below.
- Left: body copy
  - *"Cyperus Rotundus targets the DHT hormone signals at the follicle level — the same signals responsible for hair growth cycles in mature skin. With consistent daily use, it disrupts the follicle's ability to produce normal hair in three phases: hair grows back thinner, then sparser, then stops altogether."*
  - *"Unlike laser, it works on all hair colors — including the fine white and grey hairs that appear with age. Unlike waxing, it isn't a repeat appointment. It's a permanent reduction."*
  - *"That's the science behind Kelle Skin Cyperus Rotundus Serum."*
- Right: pull-quote stat block (Playfair italic, large, sage green): *"7x thinner hair shaft in 4–6 weeks. Clinically tested."*
- Below columns: "How It Works" — horizontal 3-step row:
  1. Apply 3–5 drops to clean skin after hair removal
  2. γ-curcumene weakens the follicle with each application
  3. Hair grows back thinner, slower, then stops

### 7. Ingredients Bar
**`data-shopify-section="advertorial-ingredients"`**
- Cream background
- H2: "What's Inside"
- **Use exactly these 5 ingredients** (remaining 4 in brand-info.json are base/filler ingredients not featured):
  1. **Cyperus Rotundus Root Extract** — clinically proven to weaken hair follicles (hero card: slightly larger, sage green border)
  2. **Hyaluronic Acid** — deep hydration, heals irritation from previous removal
  3. **Ceramide NP** — strengthens skin barrier, locks in moisture
  4. **Panthenol (Pro-Vitamin B5)** — soothes redness, supports healing
  5. **Arginine** — supports skin repair after hair removal
- Each card: ingredient name (bold), one-line benefit (Inter, small)
- **Mobile:** horizontal scroll row

### 8. Skeptic Testimonials
**`data-shopify-section="advertorial-skeptics"`**
- White/light cream background
- H2: "From Women Who Didn't Believe It Would Work"
- 3 testimonial cards — use **full quotes** exactly as written in `brand-info.json → content.testimonials`:
  - **Amara T.** — *"My sister kept pushing me to try this after she saw how many ingrowns, bumps, and dark spots I have from daily shaving. I thought it was just another marketing scam. Six weeks later, and I'm only tweezing a few hairs that are left on my sideburns once a week."*
  - **Maria S.** — *"I was skeptical — I've tried so many things. But the 60-day guarantee made me think, 'what do I have to lose?' Three weeks in, I'm already seeing thinner regrowth. I won't be needing that refund."*
  - **Jennifer T.** — *"I calculated that I was spending over $2,400 a year on waxing. Three bottles of this serum later, I barely need to remove hair at all. The savings are unreal."*
- Each card: name, 5-star rating, full quote
- Muted cream cards on light background
- **Mobile:** cards stack vertically

### 9. Stats Bar
**`data-shopify-section="advertorial-stats"`**
- Full-width sage green band
- 4 stats in a row, white text:
  - `87,395+` — customers who broke free from daily hair removal
  - `16,374+` — five-star reviews
  - `98%` — report softer, less stubborn regrowth within weeks
  - `60 days` — money-back guarantee
- Numbers in Playfair Display bold, labels in Inter small caps
- **Mobile:** 2×2 grid

### 10. Offer Section
**`data-shopify-section="advertorial-offer"`**
- Cream background
- H2 (Playfair italic): *"Try It For Less Than Two Waxing Appointments"*
- 3 pricing cards. **Mobile:** stack vertically, highlighted card on top.
  - Buy 1 — $53 AUD — 4-week supply
  - **Buy 2 Get 1 Free — $106 AUD — 12-week supply + free shipping** (elevated: larger, sage green border, "Most Popular" badge)
  - Buy 3 Get 3 Free — $159 AUD — 24-week supply + free shipping
- Savings comparison line below cards: *"12 weeks of KelleSkin: $106. 12 weeks of waxing: ~$600."*
- CTA button (sage green pill, uppercase): "CLAIM YOUR 3-BOTTLE BUNDLE"
- `cta_url` setting type: `url`. Set to the product page URL. **Post-build note for merchant:** append `?variant=<variant_id>` for the Buy 2 Get 1 Free variant to pre-select it. The variant ID is found in Shopify Admin → Products → [product] → variants.

### 11. FAQ
**`data-shopify-section="advertorial-faq"`**
- Cream background
- H2: "Common Questions"
- 4 accordion-style questions. Answers written inline below — do NOT defer to brand-info.json for questions 1 and 3 (no direct match exists):

  **Q1: "I've tried serums before and nothing worked — why is this different?"**
  Answer: *"Most serums treat the skin surface — hydration, brightness, texture. Kelle Skin works differently: the active compound (γ-curcumene from Cyperus Rotundus) targets the hair follicle itself, suppressing the hormonal signals that tell it to produce hair. It's not a removal method. It's the first step toward your follicles not producing hair at all."*

  **Q2: "Does it work on light, blonde, white, or grey hair?"**
  Answer: *"Yes. Unlike laser hair removal, which targets melanin (pigment) in the hair shaft, Cyperus Rotundus works on the follicle's growth mechanism — not the hair's colour. This makes it the ideal solution for the fine white and grey hairs that appear with age and are invisible to laser treatment."*

  **Q3: "Is it safe for sensitive or mature skin?"**
  Answer: *"Yes. The formula contains no parabens, sulfates, or synthetic hormones. It's hormone-safe and works locally on the applied area — it does not enter the bloodstream. The supporting ingredients (Hyaluronic Acid, Ceramide NP, Panthenol) actively soothe and repair skin, making it ideal for mature and sensitive skin that has been irritated by years of removal methods."*

  **Q4: "Will the hair come back if I stop using it?"**
  Answer: *"Cyperus Rotundus Serum does not cause dependency. Once you've achieved your desired results, most customers switch to a few times per week for maintenance. If you stop completely, gradual regrowth may occur over a longer period — but the follicles that have fully stopped producing hair do not suddenly reactivate."*

- **Mobile:** accordion expands full-width

### 12. Final CTA + Guarantee
**`data-shopify-section="advertorial-final-cta"`**
- Cream background, split layout. **Mobile:** guarantee block above, product image + CTA below.
- Left: 60-day money-back guarantee badge + copy — *"If you don't see thinner, slower regrowth in 60 days, we'll refund every cent. No questions."*
- Right: product image + CTA button (sage green pill, uppercase): "GET YOUR 3-BOTTLE BUNDLE" + subtext: *"Free shipping on your 3-bottle bundle."*
- `cta_url` (`url` type) — define in this section's schema independently; merchant sets it to the same product URL as the offer section, appending `?variant=<variant_id>` post-build

### 13. Disclaimer
**`data-shopify-section="advertorial-disclaimer"`**
- White background, small gray Inter text, centered
- Copy: *"Individual results may vary. This page is not intended to diagnose, treat, cure, or prevent any medical condition. Consult a qualified healthcare professional before starting any new skincare treatment."*

---

## Shopify Annotations

Every section wrapper needs `data-shopify-section` (unprefixed). Key settings per section with types:

| Section | Setting key | Type |
|---|---|---|
| Header | `publication_name` | `text` |
| Header | `category` | `text` |
| Header | `date` | `text` |
| Hero | `headline` | `text` |
| Hero | `subheadline` | `text` |
| Hero | `hero_image` | `image_picker` |
| Hook | `stat_amount` | `text` |
| Hook | `stat_label` | `text` |
| Hook | `body_copy` | `richtext` |
| Hook | `closing_line` | `text` |
| Why fails | blocks (×3): `method_name` | `text` |
| Why fails | blocks (×3): `method_body` | `richtext` |
| Why fails | `summary_line` | `text` |
| Turning point | `headline` | `text` |
| Turning point | `body_1` | `richtext` |
| Turning point | `body_2` | `richtext` |
| Turning point | `closing_line` | `text` |
| Solution | `body_copy` | `richtext` |
| Solution | `pull_quote_stat` | `text` |
| Solution | blocks (×3): `step_title` | `text` |
| Solution | blocks (×3): `step_body` | `text` |
| Ingredients | blocks (×5): `ingredient_name` | `text` |
| Ingredients | blocks (×5): `ingredient_benefit` | `text` |
| Skeptics | blocks (×3): `reviewer_name` | `text` |
| Skeptics | blocks (×3): `review_text` | `richtext` |
| Stats | blocks (×4): `stat_number` | `text` |
| Stats | blocks (×4): `stat_label` | `text` |
| Offer | `headline` | `text` |
| Offer | blocks (×3): `variant_name` | `text` |
| Offer | blocks (×3): `variant_price` | `text` |
| Offer | blocks (×3): `variant_supply` | `text` |
| Offer | blocks (×3): `variant_badge` | `text` |
| Offer | `savings_line` | `text` |
| Offer | `cta_text` | `text` |
| Offer | `cta_url` | `url` |
| FAQ | blocks (×4): `question` | `text` |
| FAQ | blocks (×4): `answer` | `richtext` |
| Final CTA | `guarantee_text` | `richtext` |
| Final CTA | `cta_text` | `text` |
| Final CTA | `cta_url` | `url` |
| Final CTA | `product_image` | `image_picker` |
| Disclaimer | `disclaimer_text` | `richtext` |

---

## Image Placeholders Required

Both images reference the product bottle — the local-designer must check whether `brand-knowledge/ks-product-ref.jpg` exists. If it does, add `data-image-ref="brand-knowledge/ks-product-ref.jpg"` to both image tags. If it does not exist, ask the user for a product photo before proceeding.

| Filename | Prompt |
|---|---|
| `ks-advertorial-hero.jpg` | Confident woman over 45, smooth glowing skin, holding Kelle Skin serum bottle, natural light, botanical greenery, warm cream and sage green tones, lifestyle skincare photography |
| `ks-advertorial-product.jpg` | Kelle Skin Cyperus Rotundus Serum bottle on clean surface with sage green botanical accents, professional product photography |

---

## Pipeline

1. `local-designer` — builds `local-design/ks-advertorial/index.html` with all annotations and mock data
2. `shopify-designer` — translates to `sections/ks-advertorial-*.liquid` + `templates/page.ks-advertorial.json`
3. `image-generator` — fills image placeholders
4. Push to `dev` branch → preview dev Shopify theme → merge to `main` when approved
