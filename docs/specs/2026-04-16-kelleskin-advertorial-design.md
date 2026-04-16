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

## Section Structure

### 1. Editorial Header (`ks-advertorial-header`)
- Full-width sage green bar (`#8B9A7C`)
- Left: "KelleSkin Journal" in small caps (Inter, white)
- Center: category tag — "Skincare + Wellness"
- Right: publication date
- Thin cream divider below
- Purpose: frames page as editorial content, not an ad

### 2. Hero (`ks-advertorial-hero`)
- Split layout: left text, right product image
- Headline (Playfair Display, bold italic, large): *"Why Women Over 40 Are Quietly Ditching Waxing — And Never Going Back"*
- Subheadline (Inter): "The ancient botanical that dermatologists say attacks facial hair at the root — not just the surface."
- No CTA button — advertorials should not open with a sell
- Product image: `data-image-prompt` for hero lifestyle shot (woman 45+, smooth skin, natural light, sage green tones)
- Background: warm cream

### 3. Hook (`ks-advertorial-hook`)
- Cream background, centered layout
- Large stat callout: `$2,400` in Playfair Display (large, sage green)
- Label below: "The average woman spends this every year on waxing and threading."
- 2–3 short body paragraphs (max 3 lines each) explaining the wasted spend
- Closing line (bold): *"And the worst part? Not one of those dollars addressed why the hair keeps coming back."*

### 4. Why Everything Fails (`ks-advertorial-why-fails`)
- Cream background
- H2: "Every Method You've Tried Was Designed to Remove. Not to Stop."
- Three-column icon layout, one per failed method:
  - **Waxing** — removes from root, follicle intact, grows back within days
  - **Laser** — only works on dark pigmented hair, expensive, repeated sessions
  - **Shaving** — cuts at surface, hair returns thicker and faster
- Sage green icons, clean minimal style
- Summary line below columns (bold, centered): *"Every method you've tried was designed to remove. None were designed to stop."*

### 5. Turning Point (`ks-advertorial-turning-point`)
- Full-width sage green background (`#8B9A7C`), centered text, white copy
- Headline (Playfair Display italic, white): *"Then Egyptian Botanists Discovered Something Different"*
- 2 short paragraphs introducing Cyperus Rotundus as an ancient botanical with modern clinical backing
- Closing line (bold white): *"It doesn't remove hair. It tells the follicle to stop producing it."*
- No product name yet — keep the narrative going

### 6. Solution Reveal (`ks-advertorial-solution`)
- Cream background, two-column layout
- Left: body copy explaining mechanism
  - γ-curcumene compound suppresses DHT at follicle level
  - 3-phase process: hair grows back thinner → sparser → stops
  - Safe for all skin types, all hair colors (unlike laser)
- Right: pull-quote stat block (Playfair italic, large, sage green): *"7x thinner hair shaft in 4–6 weeks. Clinically tested."*
- Below columns: "How It Works" — horizontal 3-step row
  1. Apply 3–5 drops to clean skin
  2. Cyperus Rotundus weakens the follicle over time
  3. Hair grows back thinner, slower, then stops
- Product name introduced naturally at end: *"That's the science behind Kelle Skin Cyperus Rotundus Serum."*

### 7. Ingredients Bar (`ks-advertorial-ingredients`)
- Cream background
- H2: "What's Inside"
- 5 ingredient cards in a row (horizontal scroll on mobile):
  1. **Cyperus Rotundus Root Extract** — clinically proven to weaken hair follicles (hero card, slightly larger, sage green border)
  2. **Hyaluronic Acid** — deep hydration, heals irritation
  3. **Ceramide NP** — strengthens skin barrier
  4. **Panthenol (Pro-Vitamin B5)** — soothes redness, supports healing
  5. **Arginine** — supports skin repair after removal
- Each card: ingredient name (bold), one-line benefit (Inter, small)

### 8. Skeptic Testimonials (`ks-advertorial-skeptics`)
- White/light cream background
- H2: "From Women Who Didn't Believe It Would Work"
- 3 testimonial cards, selected for skeptic-to-believer arc:
  - **Amara T.** — "I thought it was just another marketing scam. Six weeks later..."
  - **Maria S.** — "I was skeptical — I've tried so many things. But the 60-day guarantee made me think, 'what do I have to lose?'"
  - **Jennifer T.** — "I calculated that I was spending over $2,400 a year on waxing. Three bottles of this serum later, I barely need to remove hair at all."
- Each card: name, 5-star rating, quote
- Muted cream cards on light background

### 9. Stats Bar (`ks-advertorial-stats`)
- Full-width sage green band
- 4 stats in a row, white text:
  - `87,395+` — customers who broke free from daily hair removal
  - `16,374+` — five-star reviews
  - `98%` — report softer, less stubborn regrowth within weeks
  - `60 days` — money-back guarantee
- Numbers in Playfair Display bold, labels in Inter small caps

### 10. Offer Section (`ks-advertorial-offer`)
- Cream background
- H2 (Playfair italic): *"Try It For Less Than Two Waxing Appointments"*
- 3 pricing cards:
  - Buy 1 — $53 AUD — 4-week supply
  - **Buy 2 Get 1 Free — $106 AUD — 12-week supply + free shipping** (elevated: larger, sage green border, "Most Popular" badge)
  - Buy 3 Get 3 Free — $159 AUD — 24-week supply + free shipping
- Savings comparison line below cards: *"12 weeks of KelleSkin: $106. 12 weeks of waxing: ~$600."*
- CTA button (sage green pill, uppercase): "CLAIM YOUR 3-BOTTLE BUNDLE"
- Button links to product page, pre-selecting Buy 2 Get 1 Free variant

### 11. FAQ (`ks-advertorial-faq`)
- Cream background
- H2: "Common Questions"
- 4 accordion-style questions targeting skeptic objections:
  1. *"I've tried serums before and nothing worked — why is this different?"*
  2. *"Does it work on light, blonde, white, or grey hair?"*
  3. *"Is it safe for sensitive or mature skin?"*
  4. *"Will the hair come back if I stop using it?"*
- Answers from `brand-info.json` FAQ entries

### 12. Final CTA + Guarantee (`ks-advertorial-final-cta`)
- Cream background, split layout
- Left: 60-day money-back guarantee badge + copy — *"If you don't see thinner, slower regrowth in 60 days, we'll refund every cent. No questions."*
- Right: product image + CTA button (same sage green pill style) + subtext: *"Free shipping on your 3-bottle bundle."*

### 13. Disclaimer (`ks-advertorial-disclaimer`)
- White background, small gray Inter text
- Standard disclaimer: individual results may vary, not a substitute for medical advice

---

## Shopify Annotations

Every section wrapper needs `data-shopify-section`. Key editable fields per section:

| Section | Key settings |
|---|---|
| Header | publication_name, category, date |
| Hero | headline, subheadline, hero_image (image_picker) |
| Hook | stat_amount, stat_label, body_copy, closing_line |
| Why fails | column titles + body (3x blocks) |
| Turning point | headline, body_1, body_2, closing_line |
| Solution | body_copy, pull_quote_stat, steps (3x blocks) |
| Ingredients | ingredient cards (5x blocks: name, benefit) |
| Skeptics | testimonial cards (3x blocks: name, quote) |
| Stats | stat cards (4x blocks: number, label) |
| Offer | headline, pricing cards (3x blocks), savings_line, cta_text, cta_url |
| FAQ | faq items (4x blocks: question, answer) |
| Final CTA | guarantee_text, cta_text, cta_url, product_image |
| Disclaimer | disclaimer_text |

---

## Image Placeholders Required

| Filename | Prompt |
|---|---|
| `ks-advertorial-hero.jpg` | Confident woman over 45, smooth glowing skin, holding Kelle Skin serum bottle, natural light, botanical greenery, warm cream and sage green tones, lifestyle skincare photography |
| `ks-advertorial-product.jpg` | Kelle Skin Cyperus Rotundus Serum bottle on clean surface with sage green botanical accents, professional product photography |

---

## Pipeline

1. `local-designer` — builds `local-design/ks-advertorial/index.html` with all annotations and mock data
2. `shopify-designer` — translates to `sections/ks-advertorial-*.liquid` + `templates/page.ks-advertorial.json`
3. `image-generator` — fills image placeholders
4. Push to `dev` branch → brother previews dev Shopify theme → merges to `main`
