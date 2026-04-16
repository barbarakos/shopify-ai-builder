# KelleSkin Advertorial Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a 13-section KelleSkin advertorial page — annotated HTML design, translated to Shopify Liquid sections and a JSON template, pushed to the `dev` branch for merchant review.

**Architecture:** local-designer builds a single annotated HTML file → shopify-designer mechanically translates each `data-shopify-section` to a `.liquid` file + wires a `page.ks-advertorial.json` template → theme check validates output → pushed to `dev` branch (not `main`).

**Tech Stack:** Shopify Liquid, JSON templates, Playwright (visual review), Shopify CLI (`shopify theme check`, `shopify theme dev`), Git.

**Spec:** `docs/specs/2026-04-16-kelleskin-advertorial-design.md`
**Brand data:** `brand-knowledge/brand-info.json`
**Theme dir:** `/Users/kosbarb/Documents/personal/shopify-claude` (prefix: `ks`)

---

## Files

### Created by local-designer
- `local-design/ks-advertorial/index.html` — single annotated HTML file with all 13 sections and mock data

### Created by shopify-designer
- `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-advertorial-header.liquid`
- `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-advertorial-hero.liquid`
- `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-advertorial-hook.liquid`
- `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-advertorial-why-fails.liquid`
- `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-advertorial-turning-point.liquid`
- `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-advertorial-solution.liquid`
- `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-advertorial-ingredients.liquid`
- `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-advertorial-skeptics.liquid`
- `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-advertorial-stats.liquid`
- `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-advertorial-offer.liquid`
- `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-advertorial-faq.liquid`
- `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-advertorial-final-cta.liquid`
- `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-advertorial-disclaimer.liquid`
- `/Users/kosbarb/Documents/personal/shopify-claude/templates/page.ks-advertorial.json`

---

## Chunk 1: Dev Branch + Local HTML Design

### Task 1: Create dev branch

**Files:**
- Modify: `/Users/kosbarb/Documents/personal/shopify-claude` (git)

- [ ] **Step 1: Create and push dev branch**

```bash
git -C /Users/kosbarb/Documents/personal/shopify-claude checkout -b dev
git -C /Users/kosbarb/Documents/personal/shopify-claude push -u origin dev
```

Expected: Branch `dev` created and tracked on remote.

- [ ] **Step 2: Verify**

```bash
git -C /Users/kosbarb/Documents/personal/shopify-claude branch -a
```

Expected: both `main` and `remotes/origin/dev` visible.

---

### Task 2: Build annotated HTML — sections 1–7

**Files:**
- Create: `local-design/ks-advertorial/index.html`

Read the spec at `docs/specs/2026-04-16-kelleskin-advertorial-design.md` and `brand-knowledge/brand-info.json` before building. Check whether `brand-knowledge/ks-product-ref.jpg` exists — if it does, add `data-image-ref="brand-knowledge/ks-product-ref.jpg"` to both image tags; if not, note it in an HTML comment for the image-generator.

- [ ] **Step 1: Build the HTML file with sections 1–7**

Create `local-design/ks-advertorial/index.html` as a single self-contained HTML file with inline CSS. Include:

**Section 1 — `data-shopify-section="advertorial-header"`**
- Full-width sage green bar (`#8B9A7C`)
- Left: "KelleSkin Journal" small caps, center: "Skincare + Wellness", right: "April 2026"
- Thin cream divider below
- Mobile: single row, center-aligned

**Section 2 — `data-shopify-section="advertorial-hero"`**
- Split layout (left: text, right: image placeholder)
- Headline in Playfair Display bold italic: *"Why Women Over 40 Are Quietly Ditching Waxing — And Never Going Back"*
- Subheadline in Inter: "The ancient botanical that dermatologists say attacks facial hair at the root — not just the surface."
- Image placeholder: `src="{{ 'placeholder.svg' | asset_url }}"` with `data-image-prompt="Confident woman over 45, smooth glowing skin, holding Kelle Skin serum bottle, natural light, botanical greenery, warm cream and sage green tones, lifestyle skincare photography"` and `data-image-filename="ks-advertorial-hero.jpg"`
- Mobile: image top, text below

**Section 3 — `data-shopify-section="advertorial-hook"`**
- Centered, cream background
- `$2,400` in large Playfair Display sage green
- Label: "The average woman spends this every year on waxing and threading."
- 3 body paragraphs (from spec)
- Closing bold italic line

**Section 4 — `data-shopify-section="advertorial-why-fails"`**
- H2: "Every Method You've Tried Was Designed to Remove. Not to Stop."
- 3-column icon layout (Waxing / Laser / Shaving) with sage green SVG icons
- Summary line below
- Mobile: stack to single column

**Section 5 — `data-shopify-section="advertorial-turning-point"`**
- Full-width sage green background, white centered text
- Headline + 2 paragraphs + closing bold line (exact copy from spec)

**Section 6 — `data-shopify-section="advertorial-solution"`**
- 2-column: left body copy, right pull-quote stat
- "How It Works" 3-step row below columns
- Mobile: pull-quote on top, body below

**Section 7 — `data-shopify-section="advertorial-ingredients"`**
- H2: "What's Inside"
- 5 ingredient cards horizontal (scroll on mobile), hero card with sage green border
- Use exactly the 5 ingredients listed in spec

Every editable element needs `data-shopify-setting="<key>"` and `data-shopify-type="<type>"`. Every block-level element needs `data-shopify-block="<type>"`.

- [ ] **Step 2: Take desktop screenshot (1200px)**

```javascript
// Playwright — navigate to local file and screenshot
await page.goto('file:///Users/kosbarb/Documents/personal/shopify-ai-builder/local-design/ks-advertorial/index.html');
await page.setViewportSize({ width: 1200, height: 900 });
await page.screenshot({ path: 'local-design/ks-advertorial/desktop-1-7.png', fullPage: true });
```

- [ ] **Step 3: Take mobile screenshot (375px)**

```javascript
await page.setViewportSize({ width: 375, height: 812 });
await page.screenshot({ path: 'local-design/ks-advertorial/mobile-1-7.png', fullPage: true });
```

- [ ] **Step 4: Review screenshots and fix any issues**

Check: brand colors applied, fonts loaded, columns collapsing correctly on mobile, no overflow, icons visible, spacing consistent.

---

### Task 3: Build annotated HTML — sections 8–13

- [ ] **Step 1: Add sections 8–13 to `local-design/ks-advertorial/index.html`**

Every editable element needs `data-shopify-setting="<key>"` and `data-shopify-type="<type>"`. Every block-level element needs `data-shopify-block="<type>"`. Pay special attention to the following elements which must be annotated:
- Section 10 CTA anchor: `data-shopify-setting="cta_url" data-shopify-type="url"`
- Section 10 CTA button text: `data-shopify-setting="cta_text" data-shopify-type="text"`
- Section 12 CTA anchor: `data-shopify-setting="cta_url" data-shopify-type="url"`
- Section 12 CTA button text: `data-shopify-setting="cta_text" data-shopify-type="text"`
- Section 12 product image: `data-shopify-setting="product_image" data-shopify-type="image_picker"`

**Section 8 — `data-shopify-section="advertorial-skeptics"`**
- H2: "From Women Who Didn't Believe It Would Work"
- 3 testimonial cards — use **full quotes** from spec (Amara T., Maria S., Jennifer T.)
- Name, 5-star rating (★★★★★), full quote
- Muted cream cards
- Mobile: stack vertically

**Section 9 — `data-shopify-section="advertorial-stats"`**
- Full-width sage green band
- 4 stats: `87,395+` / `16,374+` / `98%` / `60 days` with labels
- Playfair Display bold numbers, Inter small caps labels
- Mobile: 2×2 grid

**Section 10 — `data-shopify-section="advertorial-offer"`**
- H2 (Playfair italic): *"Try It For Less Than Two Waxing Appointments"*
- 3 pricing cards — Buy 1, **Buy 2 Get 1 Free** (elevated, "Most Popular" badge), Buy 3 Get 3 Free
- Savings comparison line
- Sage green pill CTA: "CLAIM YOUR 3-BOTTLE BUNDLE"
- Mobile: stack vertically, highlighted card on top

**Section 11 — `data-shopify-section="advertorial-faq"`**
- H2: "Common Questions"
- 4 accordion items — questions and answers exactly as written in spec
- Simple CSS expand/collapse

**Section 12 — `data-shopify-section="advertorial-final-cta"`**
- Split: left guarantee block, right product image + CTA
- Guarantee badge + copy from spec
- Product image placeholder with `data-image-prompt` and `data-image-filename="ks-advertorial-product.jpg"`
- Sage green pill CTA: "GET YOUR 3-BOTTLE BUNDLE"
- Mobile: guarantee above, image + CTA below

**Section 13 — `data-shopify-section="advertorial-disclaimer"`**
- Small gray Inter text, centered
- Disclaimer copy from spec

- [ ] **Step 2: Take full desktop screenshot**

```javascript
await page.setViewportSize({ width: 1200, height: 900 });
await page.screenshot({ path: 'local-design/ks-advertorial/desktop-full.png', fullPage: true });
```

- [ ] **Step 3: Take full mobile screenshot**

```javascript
await page.setViewportSize({ width: 375, height: 812 });
await page.screenshot({ path: 'local-design/ks-advertorial/mobile-full.png', fullPage: true });
```

- [ ] **Step 4: Review and fix issues**

Present screenshots to user. Iterate until approved.

- [ ] **Step 5: Commit approved design**

```bash
git -C /Users/kosbarb/Documents/personal/shopify-ai-builder add local-design/ks-advertorial/
git -C /Users/kosbarb/Documents/personal/shopify-ai-builder commit -m "feat: add ks-advertorial local HTML design"
```

---

## Chunk 2: Shopify Liquid Translation

Read `docs/shopify-annotation-spec.md` before translating. Translation rules: `data-shopify-setting` + `data-shopify-type` → Liquid variable + schema entry. `data-shopify-block` → `{% for block in section.blocks %}` loop. Scope all CSS to `.<prefix>-section-{{ section.id }}`.

**NEVER modify existing theme files. NEVER push to `main`. Work on `dev` branch.**

Ensure on dev branch before starting:
```bash
git -C /Users/kosbarb/Documents/personal/shopify-claude checkout dev && git -C /Users/kosbarb/Documents/personal/shopify-claude pull origin dev
```

---

### Task 4: Translate sections 1–4

**Files:**
- Create: `sections/ks-advertorial-header.liquid`
- Create: `sections/ks-advertorial-hero.liquid`
- Create: `sections/ks-advertorial-hook.liquid`
- Create: `sections/ks-advertorial-why-fails.liquid`

All paths relative to `/Users/kosbarb/Documents/personal/shopify-claude/`.

- [ ] **Step 1: Create `ks-advertorial-header.liquid`**

Structure:
```liquid
{% style %}
  .ks-section-{{ section.id }} { /* scoped vars */ }
{% endstyle %}

<div class="ks-advertorial-header ks-section-{{ section.id }}">
  <!-- header HTML -->
</div>

{% schema %}
{
  "name": "KS Advertorial Header",
  "tag": "section",
  "class": "ks-section",
  "settings": [
    {"type": "text", "id": "publication_name", "label": "Publication name", "default": "KelleSkin Journal"},
    {"type": "text", "id": "category", "label": "Category", "default": "Skincare + Wellness"},
    {"type": "text", "id": "date", "label": "Date", "default": "April 2026"}
  ],
  "presets": [{"name": "KS Advertorial Header"}]
}
{% endschema %}
```

- [ ] **Step 2: Create `ks-advertorial-hero.liquid`**

Settings: `headline` (text), `subheadline` (text), `hero_image` (image_picker).

Image output pattern:
```liquid
{%- if section.settings.hero_image -%}
  {{ section.settings.hero_image | image_url: width: 800 | image_tag: loading: 'lazy', alt: section.settings.hero_image.alt }}
{%- else -%}
  <svg ... data-image-prompt="..." data-image-filename="ks-advertorial-hero.jpg">...</svg>
{%- endif -%}
```

- [ ] **Step 3: Create `ks-advertorial-hook.liquid`**

Settings: `stat_amount` (text), `stat_label` (text), `body_copy` (richtext), `closing_line` (text).

- [ ] **Step 4: Create `ks-advertorial-why-fails.liquid`**

Settings: `summary_line` (text). Blocks (type: `method`): `method_name` (text), `method_body` (richtext).

Block loop:
```liquid
{% for block in section.blocks %}
  {% if block.type == "method" %}
    <div {{ block.shopify_attributes }}>
      <h3>{{ block.settings.method_name }}</h3>
      {{ block.settings.method_body }}
    </div>
  {% endif %}
{% endfor %}
```

- [ ] **Step 5: Commit**

```bash
git -C /Users/kosbarb/Documents/personal/shopify-claude add sections/ks-advertorial-header.liquid sections/ks-advertorial-hero.liquid sections/ks-advertorial-hook.liquid sections/ks-advertorial-why-fails.liquid
git -C /Users/kosbarb/Documents/personal/shopify-claude commit -m "feat: add ks-advertorial sections 1-4 (header, hero, hook, why-fails)"
```

---

### Task 5: Translate sections 5–8

**Files:**
- Create: `sections/ks-advertorial-turning-point.liquid`
- Create: `sections/ks-advertorial-solution.liquid`
- Create: `sections/ks-advertorial-ingredients.liquid`
- Create: `sections/ks-advertorial-skeptics.liquid`

- [ ] **Step 1: Create `ks-advertorial-turning-point.liquid`**

Settings: `headline` (text), `body_1` (richtext), `body_2` (richtext), `closing_line` (text).

- [ ] **Step 2: Create `ks-advertorial-solution.liquid`**

Settings: `body_copy` (richtext), `pull_quote_stat` (text). Blocks (type: `step`): `step_title` (text), `step_body` (text).

- [ ] **Step 3: Create `ks-advertorial-ingredients.liquid`**

Blocks (type: `ingredient`): `ingredient_name` (text), `ingredient_benefit` (text). No section-level settings beyond colors/fonts. Include `"presets": [{"name": "KS Advertorial Ingredients"}]` in the schema — this section has no settings so it is easy to forget the presets array, which will cause a theme check error.

- [ ] **Step 4: Create `ks-advertorial-skeptics.liquid`**

Settings: `heading` (text, default: "From Women Who Didn't Believe It Would Work"). Blocks (type: `testimonial`): `reviewer_name` (text), `review_text` (richtext).

- [ ] **Step 5: Commit**

```bash
git -C /Users/kosbarb/Documents/personal/shopify-claude add sections/ks-advertorial-turning-point.liquid sections/ks-advertorial-solution.liquid sections/ks-advertorial-ingredients.liquid sections/ks-advertorial-skeptics.liquid
git -C /Users/kosbarb/Documents/personal/shopify-claude commit -m "feat: add ks-advertorial sections 5-8 (turning-point, solution, ingredients, skeptics)"
```

---

### Task 6: Translate sections 9–13 + template JSON

**Files:**
- Create: `sections/ks-advertorial-stats.liquid`
- Create: `sections/ks-advertorial-offer.liquid`
- Create: `sections/ks-advertorial-faq.liquid`
- Create: `sections/ks-advertorial-final-cta.liquid`
- Create: `sections/ks-advertorial-disclaimer.liquid`
- Create: `templates/page.ks-advertorial.json`

- [ ] **Step 1: Create `ks-advertorial-stats.liquid`**

Blocks (type: `stat`): `stat_number` (text), `stat_label` (text).

- [ ] **Step 2: Create `ks-advertorial-offer.liquid`**

Settings: `headline` (text), `savings_line` (text), `cta_text` (text, default: "CLAIM YOUR 3-BOTTLE BUNDLE"), `cta_url` (url). Note: `url` type cannot have a `"default"` value — omit default.

Blocks (type: `pricing_card`): `variant_name` (text), `variant_price` (text), `variant_supply` (text), `variant_badge` (text).

- [ ] **Step 3: Create `ks-advertorial-faq.liquid`**

Blocks (type: `faq_item`): `question` (text), `answer` (richtext).

Accordion uses CSS + checkbox hack or simple `<details>`/`<summary>` HTML elements (no JS dependency).

- [ ] **Step 4: Create `ks-advertorial-final-cta.liquid`**

Settings: `guarantee_text` (richtext), `cta_text` (text, default: "GET YOUR 3-BOTTLE BUNDLE"), `cta_url` (url — define independently in this section's schema; merchant sets same product URL as offer section), `product_image` (image_picker).

- [ ] **Step 5: Create `ks-advertorial-disclaimer.liquid`**

Settings: `disclaimer_text` (richtext, default: `"<p>Individual results may vary. This page is not intended to diagnose, treat, cure, or prevent any medical condition. Consult a qualified healthcare professional before starting any new skincare treatment.</p>"` — richtext defaults must be wrapped in `<p>` tags or theme check will error).

- [ ] **Step 6: Create `templates/page.ks-advertorial.json`**

```json
{
  "layout": "theme",
  "sections": {
    "advertorial-header": {"type": "ks-advertorial-header", "settings": {}},
    "advertorial-hero": {"type": "ks-advertorial-hero", "settings": {}},
    "advertorial-hook": {"type": "ks-advertorial-hook", "settings": {}},
    "advertorial-why-fails": {"type": "ks-advertorial-why-fails", "settings": {}},
    "advertorial-turning-point": {"type": "ks-advertorial-turning-point", "settings": {}},
    "advertorial-solution": {"type": "ks-advertorial-solution", "settings": {}},
    "advertorial-ingredients": {"type": "ks-advertorial-ingredients", "settings": {}},
    "advertorial-skeptics": {"type": "ks-advertorial-skeptics", "settings": {}},
    "advertorial-stats": {"type": "ks-advertorial-stats", "settings": {}},
    "advertorial-offer": {"type": "ks-advertorial-offer", "settings": {}},
    "advertorial-faq": {"type": "ks-advertorial-faq", "settings": {}},
    "advertorial-final-cta": {"type": "ks-advertorial-final-cta", "settings": {}},
    "advertorial-disclaimer": {"type": "ks-advertorial-disclaimer", "settings": {}}
  },
  "order": [
    "advertorial-header", "advertorial-hero", "advertorial-hook",
    "advertorial-why-fails", "advertorial-turning-point", "advertorial-solution",
    "advertorial-ingredients", "advertorial-skeptics", "advertorial-stats",
    "advertorial-offer", "advertorial-faq", "advertorial-final-cta",
    "advertorial-disclaimer"
  ]
}
```

- [ ] **Step 7: Commit**

```bash
git -C /Users/kosbarb/Documents/personal/shopify-claude add sections/ks-advertorial-stats.liquid sections/ks-advertorial-offer.liquid sections/ks-advertorial-faq.liquid sections/ks-advertorial-final-cta.liquid sections/ks-advertorial-disclaimer.liquid templates/page.ks-advertorial.json
git -C /Users/kosbarb/Documents/personal/shopify-claude commit -m "feat: add ks-advertorial sections 9-13 + page template"
```

---

## Chunk 3: Validation + Visual Review + Push

### Task 7: Theme check and fix errors

- [ ] **Step 1: Run theme check**

```bash
shopify theme check --path /Users/kosbarb/Documents/personal/shopify-claude
```

- [ ] **Step 2: Fix ALL errors before continuing**

Common issues to watch for:
- `url` type settings with a `"default"` value — remove the default
- `color` type defaults must be hex strings (e.g. `"#8B9A7C"`)
- `font_picker` type cannot have a `"default"` — remove it
- Missing `"presets"` array in schema — add `"presets": [{"name": "..."}]`
- `richtext` default values must be wrapped in `<p>` tags

- [ ] **Step 3: Re-run theme check — must pass with 0 errors**

```bash
shopify theme check --path /Users/kosbarb/Documents/personal/shopify-claude
```

Expected: No errors. Warnings are acceptable.

---

### Task 8: Visual review via dev server

- [ ] **Step 1: Start dev server (user runs this in a terminal tab)**

```bash
shopify theme dev --store mp4rb9-0q.myshopify.com --path /Users/kosbarb/Documents/personal/shopify-claude
```

- [ ] **Step 2: Create a page using the advertorial template**

> Go to **Shopify Admin → Online Store → Pages → Add page**
> Title: "Why Women Are Ditching Waxing"
> Theme template dropdown: select `ks-advertorial`
> Click Save

- [ ] **Step 3: Take desktop screenshot via Playwright**

```javascript
await page.goto('http://127.0.0.1:9292/pages/why-women-are-ditching-waxing');
await page.setViewportSize({ width: 1200, height: 900 });
await page.screenshot({ path: 'local-design/ks-advertorial/shopify-desktop.png', fullPage: true });
```

- [ ] **Step 4: Take mobile screenshot**

```javascript
await page.setViewportSize({ width: 375, height: 812 });
await page.screenshot({ path: 'local-design/ks-advertorial/shopify-mobile.png', fullPage: true });
```

- [ ] **Step 5: Compare against approved local HTML**

Report any differences: layout drift, missing content, color/font mismatches. Fix and re-screenshot until matching.

---

### Task 9: Push to dev and notify

- [ ] **Step 1: Push to dev branch**

```bash
git -C /Users/kosbarb/Documents/personal/shopify-claude push origin dev
```

- [ ] **Step 2: Confirm dev theme updated**

The `dev` Shopify theme is connected to the `dev` branch via GitHub integration. Once the push completes, the dev theme will reflect all changes.

- [ ] **Step 3: Notify user**

> "Changes are live on your dev theme. Go to **Shopify Admin → Online Store → Themes → find your dev theme → click Preview** to review. When happy, merge the `dev` branch into `main` in GitHub Desktop."
