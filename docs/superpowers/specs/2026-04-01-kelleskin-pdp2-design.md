# KelleSkin PDP v2 — Design Spec

**Date:** 2026-04-01  
**Brand:** KelleSkin (Cyperus Rotundus Serum)  
**Reference:** https://legacareofficial.com/products/original-colour-changing-foundation-4-in-1  
**Approach:** Legacare section structure + KelleSkin proven high-converting sections inserted at key points

---

## Overview

A brand-new product detail page for the KelleSkin Cyperus Rotundus Serum, built with the same section structure and layout philosophy as the Legacare PDP reference. Uses KelleSkin's own brand identity (not Legacare's visual style). The existing PDP (`product.ks-viareline-pdp.json`) is left untouched.

---

## Architecture

### New Files
- **Template:** `templates/product.ks-serum-pdp2.json`
- **Sections (13 new files):**
  - `sections/ks-pdp2-hero.liquid`
  - `sections/ks-pdp2-ugc-row.liquid`
  - `sections/ks-pdp2-press-bar.liquid`
  - `sections/ks-pdp2-why-we-love-it.liquid`
  - `sections/ks-pdp2-three-features.liquid`
  - `sections/ks-pdp2-before-after.liquid`
  - `sections/ks-pdp2-mature-skin.liquid`
  - `sections/ks-pdp2-clinical-stats.liquid`
  - `sections/ks-pdp2-comparison.liquid`
  - `sections/ks-pdp2-results-timeline.liquid`
  - `sections/ks-pdp2-pull-quote.liquid`
  - `sections/ks-pdp2-faq.liquid`
  - `sections/ks-pdp2-reviews.liquid`

All theme files live under `/Users/kosbarb/Documents/personal/shopify-claude/` (the `theme_dir`).

### Brand Tokens
| Token | Value |
|---|---|
| Primary (sage green) | `#8B9A7C` |
| Background (cream) | `#F5F2EE` |
| Accent (purple) | `#7B6B9E` |
| Text | `#303030` |
| Border radius | `14px` |
| Font heading | Playfair Display |
| Font body | Inter |

### Content Source
All content is sourced from `brand-knowledge/brand-info.json` and hardcoded into schema settings in the template JSON. No Shopify metafields are required.

---

## Sections

### 1. Hero (`ks-pdp2-hero`)
**Layout:** Two-column. Left: product image gallery with thumbnails below. Right: product info panel.

**Image gallery:** Renders from `product.images` (standard Shopify approach) — `{% for image in product.images %}`. No hardcoded image URLs in this section.

**Info panel contains (top to bottom):**
- Star rating summary: "4.9 based on 16,374+ reviews"
- Product title: "Kelle Skin Cyperus Rotundus *Serum*" (with italic styling)
- Tagline: "Achieve smoother, hair-free skin with a clinically proven Egyptian botanical"
- Bundle variant selector: renders from `product.variants` using `{% for variant in product.variants %}`. Each variant is styled as a clickable card. Variant switching uses standard Shopify JS (`/cart/add` with `id: variantId`). The three expected variants are Buy 1 / Buy 2 Get 1 Free / Buy 3 Get 3 Free — their labels and prices come from the actual product variants, not hardcoded schema settings.
- Add to Cart button (sage green, pill-shaped) — standard `{% form 'product', product %}` with `name="id"` hidden input for selected variant
- "60-DAY MONEY-BACK GUARANTEE" trust badge
- No-subscription note: "One-time purchase. No subscriptions or repeated charges."
- Countdown timer (controlled by `show_countdown_timer` boolean schema setting, default false). Label configurable via `timer_label` schema setting.
- Stock warning (controlled by `show_stock_warning` boolean schema setting, default true). Headline via `stock_warning_headline`, body via `stock_warning_body` schema settings.

**Schema blocks:** `info_tab` blocks (Benefits / How It Works / How To Use / Safe for Sensitive Skin / Guarantee) shown as expandable accordions below the ATC button — same pattern as existing hero.

**Schema settings include:** `bg_color`, `primary_color`, `accent_color`, `text_color`, `border_radius`, `review_summary`, `product_title`, `product_tagline`, `guarantee_text`, `atc_label`, `no_sub_text`, `show_countdown_timer`, `timer_label`, `show_stock_warning`, `stock_warning_headline`, `stock_warning_body`, `snippet_name`, `snippet_quote`.

---

### 2. UGC Row (`ks-pdp2-ugc-row`)
**Layout:** Horizontally scrolling row of customer photo cards. Heading above: "See It In Action".

**Each card:** customer photo, name, short quote (1–2 sentences).  
**Content:** Sarah M., Caroline T., Simone J., Carry S., Tamara F. (photos from existing `ks-pdp-before-after` section).

**Image handling:** Reuse existing CDN image URLs from the existing `ks-pdp-before-after` template blocks (Sarah M., Caroline T., Simone J., Carry S., Tamara F.). Do NOT use placeholder.svg for these — the images already exist and are hosted.

**Schema:** `review_card` blocks with `name`, `image_url`, `quote` settings.

---

### 3. Press Bar (`ks-pdp2-press-bar`)
**Layout:** Full-width, horizontally scrolling or static strip of media publication names/logos.  
**Content:** Placeholder logos (Vogue, Bazaar, InStyle, etc.) — configurable via schema blocks.  
**Fallback:** If a `logo` block has no `image_url`, render the `name` text in styled uppercase Inter font (12px, letter-spacing 0.1em, color `#8B9A7C`).  
**Schema:** `logo` blocks with `name` (text) and optional `image_url` settings.

---

### 4. Why We Love It (`ks-pdp2-why-we-love-it`)
**Layout:** Center product image with benefit callout items arranged around it (grid-based on desktop, stacked on mobile). Heading: "Why We Love It".

**Desktop layout:** 3-column CSS grid. Left column: 3 benefit items stacked vertically (right-aligned text). Center column: product image. Right column: 3 benefit items stacked vertically (left-aligned text). On mobile: single column, image on top, all 6 benefits below stacked.

**Benefits (6 items):**
1. Clinically Proven Formula
2. Works on All Hair Colors (including blonde, white, grey, red)
3. Hormone-Safe — no bloodstream absorption
4. Deeply Hydrates & Soothes Skin
5. No Daily Removal Needed
6. 60-Day Money-Back Guarantee

**Image handling:** Center image is the product serum bottle. Use `{{ 'placeholder.svg' | asset_url }}` with `data-image-prompt="Kelle Skin Cyperus Rotundus Serum bottle on cream background, botanical leaves, sage green and cream tones, clean product photography"` and `data-image-filename="ks-pdp2-why-we-love-it.jpg"`.

**Schema:** `benefit` blocks with `title` and `description` settings. Center `image_url` setting for the product image.

---

### 5. Three Features (`ks-pdp2-three-features`)
**Layout:** 3-column card grid. Heading: "A Serum That Works For You".

**Columns:**
1. **Works on All Hair Colors** — Unlike laser, targets the follicle not the pigment. Blonde, white, grey, red all respond.
2. **Hormone-Safe** — Works locally on applied area. Does not enter the bloodstream or affect hormones.
3. **60-Day Guarantee** — If you don't see results, return it for a full refund. No questions asked.

**Schema:** `feature` blocks with `icon`, `title`, `body` settings.

---

### 6. Before / After (`ks-pdp2-before-after`)
**Layout:** Grid of customer photo cards (2–3 per row). Heading: "Visibly Reduced Regrowth In 4 Weeks". Subheading: "Real results from real customers".

**Cards:** Same 5 customers as UGC row (intentionally — same people, different section layout). Each card has photo, name, quote. This section uses a grid layout (2–3 per row) vs the UGC Row's horizontal scroll layout.  
**Image handling:** Reuse existing CDN image URLs from the existing `ks-pdp-before-after` template blocks. Do NOT use placeholder.svg.  
**Schema:** `review_card` blocks — `name`, `image_url`, `quote`.

---

### 7. Mature Skin Story (`ks-pdp2-mature-skin`)
**Layout:** Two-column. Left: lifestyle image of woman 40+. Right: heading, body copy, CTA button.

**Heading:** "Made for Women Over 40"  
**Body copy (exact):**  
"After 40, your skin changes — and so does unwanted hair. Hormonal shifts during perimenopause and menopause can trigger new facial hair growth on the chin, upper lip, and cheeks. Harsh removal methods like waxing or shaving only make it worse, leaving behind irritation, ingrowns, and dark spots on mature, sensitive skin.

Cyperus Rotundus Serum by Kelle was formulated specifically for this. It gently weakens hair follicles at the source — without hormones, without chemicals, without pain. Just softer, sparser regrowth until the hair stops coming back entirely. Safe for sensitive and mature skin. Dermatologist recommended."

**CTA button:** "Shop Now" — `href="#ks-pdp2-hero"` to scroll back to hero ATC.

**Image:** Lifestyle photo of a confident woman 45+. Use `{{ 'placeholder.svg' | asset_url }}` with `data-image-prompt="Confident woman aged 45-55 with smooth glowing skin, natural light, warm cream and sage green tones, premium skincare lifestyle photography, serene expression"` and `data-image-filename="ks-pdp2-mature-skin.jpg"`.

**Schema:** `heading`, `body`, `image_url`, `cta_label`, `cta_url`, `bg_color`, `primary_color`, `text_color` settings.

---

### 8. Clinical Stats (`ks-pdp2-clinical-stats`)
**Layout:** 3 stat cards in a row. Heading: "Clinically Proven Results".

**Cards:**
1. **84%** Reduced Regrowth Speed — Cyperus Rotundus extends the dormant phase of the hair follicle
2. **79%** Reduced Hair Thickness — Over 7x thinner hair shaft in 4–6 weeks
3. **81%** Reduced Removal Frequency — Users go from daily to weekly or monthly maintenance

Each card: large stat number, descriptor label, title, body paragraph, optional image.

**Image handling:** Reuse existing CDN image URLs from the existing `ks-pdp-clinical` template blocks (result-1, result-2, result-3). Do NOT use placeholder.svg for these images.

**Schema:** `result_card` blocks with `stat`, `stat_descriptor`, `title`, `image_url`, `body`.

---

### 9. Comparison Table (`ks-pdp2-comparison`)
**Layout:** Table with KelleSkin, Shaving, Plucking, Laser as columns. KelleSkin column highlighted.

**Rows (checkmarks/crosses):**
1. Damages Skin — ✗ Kelle / ✓ Shaving / ✓ Plucking / ✓ Laser
2. Daily Removal Needed — ✗ / ✓ / ✓ / ✗
3. High Cost — ✗ / ✗ / ✗ / ✓
4. Ingrown Hairs — ✗ / ✓ / ✓ / ✗
5. Thick Stubble — ✗ / ✓ / ✗ / ✗

**Header:** "A Better Way to a Hair-Free Life" / "Without pain, irritation, or daily struggles."

**Schema:** `row` blocks with `label`, `kelle` (boolean), `shaving`, `plucking`, `laser` settings. Column header schema settings: `col_kelle` (default "Kelle Serum"), `col_shaving` (default "Shaving"), `col_plucking` (default "Plucking"), `col_laser` (default "Laser").

---

### 10. Results Timeline (`ks-pdp2-results-timeline`)
**Layout:** Left: step-by-step timeline list. Right: lifestyle image. Heading: "Your Journey to *Hair-Free Skin*".

**Steps:**
- **1 Week** — Softer Hair & Skin: Hairs feel noticeably softer. Skin hydrated, irritation soothed.
- **2 Weeks** — Thinner & Sparser Regrowth: Hair grows back slower, thinner, lighter.
- **4 Weeks** — Nearly Invisible Hair: Hair grows back fine and barely noticeable.
- **3 Months** — Hair Removal Struggle Gone: Follicles weakened, smooth skin without daily removal.

**Image handling:** Reuse existing CDN image URL from the existing `ks-pdp-journey` template (`image_url` setting, the side lifestyle image). Do NOT use placeholder.svg.

**Schema:** `step` blocks with `week_label`, `step_title`, `step_body`. Section `image_url` and `side_image_alt` settings.

---

### 11. Pull Quote (`ks-pdp2-pull-quote`)
**Layout:** Full-width centered. Large quotation mark, quote text, customer name, star rating.

**Content:**  
> "I calculated that I was spending over $2,400 a year on waxing. Three bottles of this serum later, I barely need to remove hair at all. The savings are unreal."  
> — Jennifer T., ★★★★★

**Stars rendering:** Use Liquid to output `★` characters: `{% assign star_count = section.settings.rating %} {% for i in (1..star_count) %}★{% endfor %}`. Rendered in sage green (`#8B9A7C`).

**Schema:** `quote`, `customer_name`, `rating` (integer 1–5, default 5), `bg_color` settings.

---

### 12. FAQ (`ks-pdp2-faq`)
**Layout:** Left: product image. Right: accordion list of questions. Heading: "Frequently Asked *Questions*".

**Image handling:** Reuse existing CDN image URL from the existing `ks-pdp-faq` template (`image_url` setting). Do NOT use placeholder.svg.

**10 FAQ items** (from brand-info.json):
1. How Do I Use It?
2. When Can I Expect To See Results?
3. Can I Use The Serum On Other Areas Apart From Face?
4. Are There Any Side Effects?
5. Is There A Money-Back Guarantee?
6. Does it work on light/blonde/white/grey hair?
7. How long does one bottle last?
8. Will the hair grow back if I stop using the serum?
9. Does it impact my hormones and endocrine system?
10. What is the full list of ingredients?

**Schema:** `faq_item` blocks with `question`, `answer` settings. `image_url` setting.

---

### 13. Reviews (`ks-pdp2-reviews`)
**Layout:** Overall rating header ("4.9 based on 16,374+ reviews"), then review cards in a grid. Heading: "Real Women. Real Results."

**Review cards:** photo, verified badge, reviewer name, quote.  
**Reviewers and image handling:**
- Carol S., Amara T., Laura M. — reuse existing CDN image URLs from existing `ks-pdp-reviews` template blocks. Do NOT use placeholder.svg.
- Rachel M. — new image. Use `{{ 'placeholder.svg' | asset_url }}` with `data-image-prompt="Woman aged 40s with smooth skin smiling, natural indoor light, beauty lifestyle photography, warm cream tones"` and `data-image-filename="ks-pdp2-review-rachel.jpg"`
- Jennifer T. — new image. Use `{{ 'placeholder.svg' | asset_url }}` with `data-image-prompt="Confident woman aged 45 looking at camera, bright natural light, clean background, lifestyle beauty portrait"` and `data-image-filename="ks-pdp2-review-jennifer.jpg"`
- Maria S. — new image. Use `{{ 'placeholder.svg' | asset_url }}` with `data-image-prompt="Woman aged 50s with glowing skin, skeptical-then-pleased expression, natural window light, beauty lifestyle photography"` and `data-image-filename="ks-pdp2-review-maria.jpg"`

**Schema:** `review` blocks with `reviewer_name`, `verified` (boolean), `image_url`, `quote`.

---

## Template JSON Structure

`product.ks-serum-pdp2.json` follows the same pattern as `product.ks-viareline-pdp.json`:
- `sections` object keyed by section name
- Each section has `type`, `blocks`, `block_order`, `settings`
- `order` array defines render sequence
- All 13 sections listed in order above

---

## CSS / JS Assets

Each section includes its own `<style>` block with scoped CSS (no shared stylesheet). No `ks-pdp2.css` or `ks-pdp2.js` asset file is needed. Any JavaScript (accordion toggles, variant switching, countdown timer, sticky CTA) is inlined in a `<script>` block within the relevant section file. This follows the same pattern as the existing `ks-pdp-*` sections.

**Template JSON key naming:** Section keys in `product.ks-serum-pdp2.json` match the section `type` (filename without `.liquid`). Example: key `"ks-pdp2-hero"`, type `"ks-pdp2-hero"`. The `order` array uses the same keys.

---

## Constraints

- All image `src` attributes on `<img>` tags that need AI generation must use `{{ 'placeholder.svg' | asset_url }}` with `data-image-prompt="..."` and `data-image-filename="ks-..."` attributes
- Run `shopify theme check` before committing
- Do not modify any existing theme files
- Theme dir: `/Users/kosbarb/Documents/personal/shopify-claude/`
- Theme prefix: `ks`
