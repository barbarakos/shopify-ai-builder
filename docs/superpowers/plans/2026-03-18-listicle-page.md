# KelleSkin Listicle Page Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a "7 Reasons Why Women Over 40 Are Switching to This Serum" conversion listicle page for KelleSkin using 5 new Shopify sections and a page template.

**Architecture:** Six Liquid section files and one JSON template. The reasons section is block-based and instantiated twice in the template (reasons 1–4, then 5–7) with a stats bar inserted between. All sections use inline `{% stylesheet %}` for scoped CSS and `{% schema %}` for theme editor editability.

**Tech Stack:** Shopify Liquid, inline `{% stylesheet %}`, `{% schema %}` JSON, Shopify CLI (`shopify theme check`)

---

## Context & Conventions

- **Theme dir:** `/Users/kosbarb/Documents/personal/shopify-claude`
- **Prefix:** `ks`
- **Brand colors:** sage green `#8B9A7C`, cream `#F5F2EE`, purple `#7B6B9E`, text `#303030`
- **Fonts:** `Playfair Display` (headings), `Inter` (body)
- **Border radius:** `14px`
- **CTA target:** `/products/viareline-skin-serum-pro`
- **Image placeholders:** `{{ 'placeholder.svg' | asset_url }}` with `data-image-prompt` and `data-image-filename` on every `<img>` that needs AI generation
- **Pattern reference:** `sections/ks-testimonials-carousel.liquid` — follow this for schema structure, `{% stylesheet %}`, `page-width` class, and `spacing-style` render

---

## File Map

| File | Action | Responsibility |
|------|--------|---------------|
| `sections/ks-listicle-hero.liquid` | Create | Hero banner — headline, subheadline, CTA |
| `sections/ks-listicle-reasons.liquid` | Create | Block-based alternating image/text reasons (used twice in template) |
| `sections/ks-listicle-stats.liquid` | Create | 4-stat social proof bar |
| `sections/ks-listicle-testimonials.liquid` | Create | 3-card testimonial strip |
| `sections/ks-listicle-cta.liquid` | Create | Final CTA section |
| `templates/page.ks-listicle.json` | Create | Wires all sections; pre-populates content |

---

## Chunk 1: Hero, Reasons, Stats Sections

### Task 1: Create `ks-listicle-hero.liquid`

**Files:**
- Create: `sections/ks-listicle-hero.liquid`

- [ ] **Step 1: Create the hero section file**

Create `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-listicle-hero.liquid` with this content:

```liquid
<div
  class="ks-listicle-hero"
  style="{% render 'spacing-style', settings: section.settings %}"
>
  <div class="ks-listicle-hero__inner page-width">
    <h1 class="ks-listicle-hero__heading">{{ section.settings.heading }}</h1>
    {%- if section.settings.subheading != blank -%}
      <p class="ks-listicle-hero__subheading">{{ section.settings.subheading }}</p>
    {%- endif -%}
    {%- if section.settings.button_text != blank -%}
      <a href="{{ section.settings.button_url }}" class="ks-btn ks-listicle-hero__btn">
        {{ section.settings.button_text }}
      </a>
    {%- endif -%}
  </div>
</div>

{% stylesheet %}
.ks-listicle-hero {
  background-color: #8B9A7C;
  text-align: center;
  padding: 80px 24px;
}
.ks-listicle-hero__inner {
  max-width: 760px;
  margin: 0 auto;
}
.ks-listicle-hero__heading {
  font-family: 'Playfair Display', Georgia, serif;
  font-size: clamp(2rem, 4vw, 3rem);
  font-weight: 700;
  color: #F5F2EE;
  line-height: 1.2;
  margin: 0 0 1rem;
}
.ks-listicle-hero__subheading {
  font-family: 'Inter', sans-serif;
  font-size: clamp(1rem, 2vw, 1.25rem);
  color: #F5F2EE;
  opacity: 0.9;
  margin: 0 0 2rem;
}
.ks-btn {
  display: inline-block;
  background-color: #8B9A7C;
  color: #F5F2EE;
  font-family: 'Inter', sans-serif;
  font-size: 0.9rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  text-decoration: none;
  padding: 16px 36px;
  border-radius: 14px;
  border: 2px solid #F5F2EE;
  transition: background-color 0.2s, color 0.2s;
}
.ks-btn:hover {
  background-color: #F5F2EE;
  color: #303030;
}
.ks-listicle-hero .ks-btn {
  background-color: transparent;
  border-color: #F5F2EE;
  color: #F5F2EE;
}
.ks-listicle-hero .ks-btn:hover {
  background-color: #F5F2EE;
  color: #8B9A7C;
}
@media (max-width: 749px) {
  .ks-listicle-hero .ks-btn {
    width: 100%;
    text-align: center;
  }
}
{% endstylesheet %}

{% schema %}
{
  "name": "KS Listicle Hero",
  "tag": "section",
  "settings": [
    {
      "type": "text",
      "id": "heading",
      "label": "Heading",
      "default": "7 Reasons Why Women Over 40 Are Switching to This Serum"
    },
    {
      "type": "text",
      "id": "subheading",
      "label": "Subheading",
      "default": "Discover why 87,000+ women have ditched the razor — for good."
    },
    {
      "type": "text",
      "id": "button_text",
      "label": "Button text",
      "default": "See the Serum →"
    },
    {
      "type": "url",
      "id": "button_url",
      "label": "Button URL",
      "default": "/products/viareline-skin-serum-pro"
    },
    {
      "type": "header",
      "content": "Padding"
    },
    {
      "type": "range",
      "id": "padding-block-start",
      "label": "Padding top",
      "min": 0,
      "max": 120,
      "step": 4,
      "unit": "px",
      "default": 80
    },
    {
      "type": "range",
      "id": "padding-block-end",
      "label": "Padding bottom",
      "min": 0,
      "max": 120,
      "step": 4,
      "unit": "px",
      "default": 80
    }
  ],
  "presets": [
    {
      "name": "KS Listicle Hero"
    }
  ]
}
{% endschema %}
```

- [ ] **Step 2: Run theme check**

```bash
cd /Users/kosbarb/Documents/personal/shopify-claude && shopify theme check sections/ks-listicle-hero.liquid
```

Expected: No errors. Fix any reported issues before proceeding.

- [ ] **Step 3: Commit**

```bash
cd /Users/kosbarb/Documents/personal/shopify-claude && git add sections/ks-listicle-hero.liquid && git commit -m "feat: add ks-listicle-hero section"
```

---

### Task 2: Create `ks-listicle-reasons.liquid`

**Files:**
- Create: `sections/ks-listicle-reasons.liquid`

- [ ] **Step 1: Create the reasons section file**

Create `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-listicle-reasons.liquid`:

```liquid
<div
  class="ks-listicle-reasons"
  style="{% render 'spacing-style', settings: section.settings %}"
>
  {%- for block in section.blocks -%}
    {%- assign is_even = forloop.index | modulo: 2 -%}
    {%- assign img_loading = 'lazy' -%}
    {%- if forloop.first -%}{%- assign img_loading = 'eager' -%}{%- endif -%}
    <div
      class="ks-listicle-reasons__row{% if is_even == 0 %} ks-listicle-reasons__row--reverse{% endif %} ks-listicle-reasons__row--bg-{{ forloop.index | modulo: 2 }}"
      {{ block.shopify_attributes }}
    >
      <div class="page-width ks-listicle-reasons__inner">
        <div class="ks-listicle-reasons__image-col">
          {%- if block.settings.image != blank -%}
            {{
              block.settings.image
              | image_url: width: 800
              | image_tag:
                loading: img_loading,
                alt: block.settings.image_alt,
                class: 'ks-listicle-reasons__img',
                widths: '400, 600, 800',
                sizes: '(max-width: 749px) 100vw, 50vw'
            }}
          {%- else -%}
            <img
              src="{{ 'placeholder.svg' | asset_url }}"
              alt="{{ block.settings.image_alt | default: block.settings.heading }}"
              class="ks-listicle-reasons__img"
              loading="{{ img_loading }}"
              data-image-prompt="{{ block.settings.image_prompt }}"
              data-image-filename="ks-listicle-{{ forloop.index }}.jpg"
              width="600"
              height="500"
            >
          {%- endif -%}
        </div>
        <div class="ks-listicle-reasons__text-col">
          <span class="ks-listicle-reasons__number" aria-hidden="true">{{ forloop.index }}</span>
          <h2 class="ks-listicle-reasons__heading">{{ block.settings.heading }}</h2>
          <p class="ks-listicle-reasons__body">{{ block.settings.body }}</p>
        </div>
      </div>
    </div>
  {%- endfor -%}
</div>

{% stylesheet %}
.ks-listicle-reasons__row {
  padding: 60px 0;
}
.ks-listicle-reasons__row--bg-0 {
  background-color: #F5F2EE;
}
.ks-listicle-reasons__row--bg-1 {
  background-color: #ffffff;
}
.ks-listicle-reasons__inner {
  display: flex;
  flex-direction: row;
  gap: 60px;
  align-items: center;
}
.ks-listicle-reasons__row--reverse .ks-listicle-reasons__inner {
  flex-direction: row-reverse;
}
.ks-listicle-reasons__image-col,
.ks-listicle-reasons__text-col {
  flex: 1;
}
.ks-listicle-reasons__image-col {
  position: relative;
}
.ks-listicle-reasons__img {
  width: 100%;
  height: auto;
  border-radius: 14px;
  display: block;
  object-fit: cover;
  aspect-ratio: 4 / 3;
}
.ks-listicle-reasons__text-col {
  position: relative;
  padding-top: 1rem;
}
.ks-listicle-reasons__number {
  font-family: 'Playfair Display', Georgia, serif;
  font-size: clamp(5rem, 10vw, 8rem);
  font-weight: 700;
  color: #8B9A7C;
  opacity: 0.2;
  line-height: 1;
  position: absolute;
  top: -1rem;
  left: -0.5rem;
  pointer-events: none;
  user-select: none;
}
.ks-listicle-reasons__heading {
  font-family: 'Playfair Display', Georgia, serif;
  font-size: clamp(1.4rem, 2.5vw, 2rem);
  font-weight: 700;
  color: #303030;
  line-height: 1.3;
  margin: 0 0 1rem;
  padding-top: 2.5rem;
}
.ks-listicle-reasons__body {
  font-family: 'Inter', sans-serif;
  font-size: 1rem;
  line-height: 1.7;
  color: #303030;
  margin: 0;
}
@media (max-width: 749px) {
  .ks-listicle-reasons__inner {
    flex-direction: column;
    gap: 24px;
  }
  .ks-listicle-reasons__row--reverse .ks-listicle-reasons__inner {
    flex-direction: column;
  }
  .ks-listicle-reasons__image-col {
    order: -1;
  }
  .ks-listicle-reasons__number {
    font-size: 5rem;
  }
  .ks-listicle-reasons__row {
    padding: 40px 0;
  }
}
{% endstylesheet %}

{% schema %}
{
  "name": "KS Listicle Reasons",
  "tag": "section",
  "blocks": [
    {
      "type": "reason",
      "name": "Reason",
      "settings": [
        {
          "type": "text",
          "id": "heading",
          "label": "Heading",
          "default": "Reason headline goes here"
        },
        {
          "type": "textarea",
          "id": "body",
          "label": "Body copy",
          "default": "Explain this reason in 40–60 words. Focus on the benefit and how it solves a real problem for women over 40."
        },
        {
          "type": "image_picker",
          "id": "image",
          "label": "Image"
        },
        {
          "type": "text",
          "id": "image_alt",
          "label": "Image alt text"
        },
        {
          "type": "text",
          "id": "image_prompt",
          "label": "AI image prompt (for generation)",
          "info": "Used by the image-generator agent to create the image."
        }
      ]
    }
  ],
  "settings": [
    {
      "type": "header",
      "content": "Padding"
    },
    {
      "type": "range",
      "id": "padding-block-start",
      "label": "Padding top",
      "min": 0,
      "max": 60,
      "step": 4,
      "unit": "px",
      "default": 0
    },
    {
      "type": "range",
      "id": "padding-block-end",
      "label": "Padding bottom",
      "min": 0,
      "max": 60,
      "step": 4,
      "unit": "px",
      "default": 0
    }
  ],
  "presets": [
    {
      "name": "KS Listicle Reasons"
    }
  ]
}
{% endschema %}
```

- [ ] **Step 2: Run theme check**

```bash
cd /Users/kosbarb/Documents/personal/shopify-claude && shopify theme check sections/ks-listicle-reasons.liquid
```

Expected: No errors.

- [ ] **Step 3: Commit**

```bash
cd /Users/kosbarb/Documents/personal/shopify-claude && git add sections/ks-listicle-reasons.liquid && git commit -m "feat: add ks-listicle-reasons section"
```

---

### Task 3: Create `ks-listicle-stats.liquid`

**Files:**
- Create: `sections/ks-listicle-stats.liquid`

- [ ] **Step 1: Create the stats section file**

Create `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-listicle-stats.liquid`:

```liquid
<div
  class="ks-listicle-stats"
  style="{% render 'spacing-style', settings: section.settings %}"
>
  <div class="page-width ks-listicle-stats__grid">
    {%- for block in section.blocks -%}
      <div class="ks-listicle-stats__item" {{ block.shopify_attributes }}>
        <span class="ks-listicle-stats__value">{{ block.settings.value }}</span>
        <span class="ks-listicle-stats__label">{{ block.settings.label }}</span>
      </div>
    {%- endfor -%}
  </div>
</div>

{% stylesheet %}
.ks-listicle-stats {
  background-color: #8B9A7C;
  padding: 48px 24px;
}
.ks-listicle-stats__grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 24px;
  text-align: center;
}
.ks-listicle-stats__item {
  display: flex;
  flex-direction: column;
  gap: 6px;
}
.ks-listicle-stats__value {
  font-family: 'Playfair Display', Georgia, serif;
  font-size: clamp(1.5rem, 3vw, 2.25rem);
  font-weight: 700;
  color: #F5F2EE;
  line-height: 1.1;
}
.ks-listicle-stats__label {
  font-family: 'Inter', sans-serif;
  font-size: 0.85rem;
  color: #F5F2EE;
  opacity: 0.85;
  letter-spacing: 0.03em;
  text-transform: uppercase;
}
@media (max-width: 749px) {
  .ks-listicle-stats__grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 32px 16px;
  }
}
{% endstylesheet %}

{% schema %}
{
  "name": "KS Listicle Stats",
  "tag": "section",
  "blocks": [
    {
      "type": "stat",
      "name": "Stat",
      "settings": [
        {
          "type": "text",
          "id": "value",
          "label": "Stat value",
          "default": "16,374+"
        },
        {
          "type": "text",
          "id": "label",
          "label": "Stat label",
          "default": "Five-Star Reviews"
        }
      ]
    }
  ],
  "settings": [
    {
      "type": "header",
      "content": "Padding"
    },
    {
      "type": "range",
      "id": "padding-block-start",
      "label": "Padding top",
      "min": 0,
      "max": 120,
      "step": 4,
      "unit": "px",
      "default": 48
    },
    {
      "type": "range",
      "id": "padding-block-end",
      "label": "Padding bottom",
      "min": 0,
      "max": 120,
      "step": 4,
      "unit": "px",
      "default": 48
    }
  ],
  "presets": [
    {
      "name": "KS Listicle Stats",
      "blocks": [
        { "type": "stat", "settings": { "value": "16,374+", "label": "Five-Star Reviews" } },
        { "type": "stat", "settings": { "value": "98%", "label": "Report Results" } },
        { "type": "stat", "settings": { "value": "7x", "label": "Thinner Hair in 4–6 Weeks" } },
        { "type": "stat", "settings": { "value": "87K+", "label": "Customers" } }
      ]
    }
  ]
}
{% endschema %}
```

- [ ] **Step 2: Run theme check**

```bash
cd /Users/kosbarb/Documents/personal/shopify-claude && shopify theme check sections/ks-listicle-stats.liquid
```

Expected: No errors.

- [ ] **Step 3: Commit**

```bash
cd /Users/kosbarb/Documents/personal/shopify-claude && git add sections/ks-listicle-stats.liquid && git commit -m "feat: add ks-listicle-stats section"
```

---

## Chunk 2: Testimonials, CTA, Template

### Task 4: Create `ks-listicle-testimonials.liquid`

**Files:**
- Create: `sections/ks-listicle-testimonials.liquid`

- [ ] **Step 1: Create the testimonials section file**

Create `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-listicle-testimonials.liquid`:

```liquid
<div
  class="ks-listicle-testimonials"
  style="{% render 'spacing-style', settings: section.settings %}"
>
  <div class="page-width">
    {%- if section.settings.heading != blank -%}
      <h2 class="ks-listicle-testimonials__heading">{{ section.settings.heading }}</h2>
    {%- endif -%}
    <div class="ks-listicle-testimonials__grid">
      {%- for block in section.blocks -%}
        <div class="ks-listicle-testimonials__card" {{ block.shopify_attributes }}>
          <div class="ks-listicle-testimonials__stars" aria-label="{{ block.settings.rating }} out of 5 stars">
            {%- for i in (1..block.settings.rating) -%}
              <span aria-hidden="true">★</span>
            {%- endfor -%}
          </div>
          {%- if block.settings.quote != blank -%}
            <blockquote class="ks-listicle-testimonials__quote">
              "{{ block.settings.quote }}"
            </blockquote>
          {%- endif -%}
          {%- if block.settings.name != blank -%}
            <cite class="ks-listicle-testimonials__name">— {{ block.settings.name }}</cite>
          {%- endif -%}
        </div>
      {%- endfor -%}
    </div>
  </div>
</div>

{% stylesheet %}
.ks-listicle-testimonials {
  background-color: #F5F2EE;
  padding: 80px 24px;
}
.ks-listicle-testimonials__heading {
  font-family: 'Playfair Display', Georgia, serif;
  font-size: clamp(1.5rem, 3vw, 2.25rem);
  font-weight: 700;
  color: #303030;
  text-align: center;
  margin: 0 0 2.5rem;
}
.ks-listicle-testimonials__grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
}
.ks-listicle-testimonials__card {
  background: #ffffff;
  border-radius: 14px;
  padding: 28px 24px;
  display: flex;
  flex-direction: column;
  gap: 14px;
  box-shadow: 0 2px 12px rgba(48, 48, 48, 0.06);
}
.ks-listicle-testimonials__stars {
  color: #8B9A7C;
  font-size: 1.1rem;
  letter-spacing: 2px;
}
.ks-listicle-testimonials__quote {
  margin: 0;
  font-family: 'Inter', sans-serif;
  font-size: 0.95rem;
  line-height: 1.7;
  font-style: italic;
  color: #303030;
}
.ks-listicle-testimonials__name {
  font-family: 'Inter', sans-serif;
  font-size: 0.85rem;
  font-style: normal;
  font-weight: 600;
  color: #8B9A7C;
}
@media (max-width: 749px) {
  .ks-listicle-testimonials__grid {
    grid-template-columns: 1fr;
  }
  .ks-listicle-testimonials {
    padding: 60px 24px;
  }
}
{% endstylesheet %}

{% schema %}
{
  "name": "KS Listicle Testimonials",
  "tag": "section",
  "blocks": [
    {
      "type": "testimonial",
      "name": "Testimonial",
      "settings": [
        {
          "type": "text",
          "id": "name",
          "label": "Customer name",
          "default": "Sarah M."
        },
        {
          "type": "textarea",
          "id": "quote",
          "label": "Quote",
          "default": "This product changed my skin completely!"
        },
        {
          "type": "range",
          "id": "rating",
          "label": "Star rating",
          "min": 1,
          "max": 5,
          "step": 1,
          "default": 5
        }
      ]
    }
  ],
  "settings": [
    {
      "type": "text",
      "id": "heading",
      "label": "Section heading",
      "default": "What Women Are Saying"
    },
    {
      "type": "header",
      "content": "Padding"
    },
    {
      "type": "range",
      "id": "padding-block-start",
      "label": "Padding top",
      "min": 0,
      "max": 120,
      "step": 4,
      "unit": "px",
      "default": 80
    },
    {
      "type": "range",
      "id": "padding-block-end",
      "label": "Padding bottom",
      "min": 0,
      "max": 120,
      "step": 4,
      "unit": "px",
      "default": 80
    }
  ],
  "presets": [
    {
      "name": "KS Listicle Testimonials"
    }
  ]
}
{% endschema %}
```

- [ ] **Step 2: Run theme check**

```bash
cd /Users/kosbarb/Documents/personal/shopify-claude && shopify theme check sections/ks-listicle-testimonials.liquid
```

Expected: No errors.

- [ ] **Step 3: Commit**

```bash
cd /Users/kosbarb/Documents/personal/shopify-claude && git add sections/ks-listicle-testimonials.liquid && git commit -m "feat: add ks-listicle-testimonials section"
```

---

### Task 5: Create `ks-listicle-cta.liquid`

**Files:**
- Create: `sections/ks-listicle-cta.liquid`

- [ ] **Step 1: Create the CTA section file**

Create `/Users/kosbarb/Documents/personal/shopify-claude/sections/ks-listicle-cta.liquid`:

```liquid
<div
  class="ks-listicle-cta"
  style="{% render 'spacing-style', settings: section.settings %}"
>
  <div class="page-width ks-listicle-cta__inner">
    <h2 class="ks-listicle-cta__heading">{{ section.settings.heading }}</h2>
    {%- if section.settings.subheading != blank -%}
      <p class="ks-listicle-cta__subheading">{{ section.settings.subheading }}</p>
    {%- endif -%}
    {%- if section.settings.button_text != blank -%}
      <a href="{{ section.settings.button_url }}" class="ks-btn ks-listicle-cta__btn">
        {{ section.settings.button_text }}
      </a>
    {%- endif -%}
  </div>
</div>

{% stylesheet %}
.ks-listicle-cta {
  background-color: #F5F2EE;
  text-align: center;
  padding: 80px 24px;
}
.ks-listicle-cta__inner {
  max-width: 600px;
  margin: 0 auto;
}
.ks-listicle-cta__heading {
  font-family: 'Playfair Display', Georgia, serif;
  font-size: clamp(1.75rem, 3.5vw, 2.5rem);
  font-weight: 700;
  color: #303030;
  margin: 0 0 1rem;
  line-height: 1.2;
}
.ks-listicle-cta__subheading {
  font-family: 'Inter', sans-serif;
  font-size: 1.05rem;
  color: #303030;
  opacity: 0.8;
  margin: 0 0 2rem;
}
.ks-listicle-cta .ks-btn {
  background-color: #8B9A7C;
  color: #F5F2EE;
  border-color: #8B9A7C;
  font-size: 1rem;
  padding: 18px 44px;
}
.ks-listicle-cta .ks-btn:hover {
  background-color: #7a8a6b;
  border-color: #7a8a6b;
}
{% endstylesheet %}

{% schema %}
{
  "name": "KS Listicle CTA",
  "tag": "section",
  "settings": [
    {
      "type": "text",
      "id": "heading",
      "label": "Heading",
      "default": "Ready to stop the daily routine?"
    },
    {
      "type": "text",
      "id": "subheading",
      "label": "Subheading",
      "default": "Join 87,000+ women who made the switch."
    },
    {
      "type": "text",
      "id": "button_text",
      "label": "Button text",
      "default": "Shop the Serum →"
    },
    {
      "type": "url",
      "id": "button_url",
      "label": "Button URL",
      "default": "/products/viareline-skin-serum-pro"
    },
    {
      "type": "header",
      "content": "Padding"
    },
    {
      "type": "range",
      "id": "padding-block-start",
      "label": "Padding top",
      "min": 0,
      "max": 120,
      "step": 4,
      "unit": "px",
      "default": 80
    },
    {
      "type": "range",
      "id": "padding-block-end",
      "label": "Padding bottom",
      "min": 0,
      "max": 120,
      "step": 4,
      "unit": "px",
      "default": 80
    }
  ],
  "presets": [
    {
      "name": "KS Listicle CTA"
    }
  ]
}
{% endschema %}
```

- [ ] **Step 2: Run theme check**

```bash
cd /Users/kosbarb/Documents/personal/shopify-claude && shopify theme check sections/ks-listicle-cta.liquid
```

Expected: No errors.

- [ ] **Step 3: Commit**

```bash
cd /Users/kosbarb/Documents/personal/shopify-claude && git add sections/ks-listicle-cta.liquid && git commit -m "feat: add ks-listicle-cta section"
```

---

### Task 6: Create `templates/page.ks-listicle.json`

**Files:**
- Create: `templates/page.ks-listicle.json`

This template wires all 5 sections together and pre-populates all content (7 reasons, 4 stats, 3 testimonials) so the page is ready to preview immediately.

- [ ] **Step 1: Create the template JSON**

Create `/Users/kosbarb/Documents/personal/shopify-claude/templates/page.ks-listicle.json`:

```json
{
  "sections": {
    "ks-listicle-hero": {
      "type": "ks-listicle-hero",
      "settings": {
        "heading": "7 Reasons Why Women Over 40 Are Switching to This Serum",
        "subheading": "Discover why 87,000+ women have ditched the razor — for good.",
        "button_text": "See the Serum →",
        "button_url": "/products/viareline-skin-serum-pro",
        "padding-block-start": 80,
        "padding-block-end": 80
      }
    },
    "ks-listicle-reasons-1": {
      "type": "ks-listicle-reasons",
      "blocks": {
        "reason-1": {
          "type": "reason",
          "settings": {
            "heading": "It Works on All Hair Colors — Including Blonde, Grey & White",
            "body": "Unlike laser, which only targets pigment, this serum works on every hair color. Whether you have fine blonde peach fuzz or coarse grey chin hair, Cyperus Rotundus targets the follicle's growth mechanism — not the color. It's the reason dermatologists recommend it as the laser alternative.",
            "image_alt": "Woman with silver hair examining smooth facial skin",
            "image_prompt": "Woman over 45 with silver/blonde hair examining smooth facial skin in mirror, natural light, warm cream tones, soft botanical background, skincare lifestyle photography"
          }
        },
        "reason-2": {
          "type": "reason",
          "settings": {
            "heading": "Most Women See Results in as Little as 2 Weeks",
            "body": "Within the first two weeks, hair starts growing back thinner and slower. By week 4–6, regrowth is up to 7x thinner. By week 8–12, most women barely need to remove hair at all. 98% of users report softer, less stubborn regrowth — often faster than expected.",
            "image_alt": "Close-up of smooth glowing mature skin",
            "image_prompt": "Close-up of smooth glowing skin on a mature woman's cheek and jaw, soft natural light, botanical background, warm cream and sage green tones, skincare photography"
          }
        },
        "reason-3": {
          "type": "reason",
          "settings": {
            "heading": "Say Goodbye to Razor Burns, Ingrowns & Irritation",
            "body": "Daily shaving and waxing leave skin textured, irritated, and full of dark spots. This serum doesn't just reduce hair — it heals. Hyaluronic Acid and Ceramide NP restore the skin barrier so your face finally feels smooth and calm. No more morning dread.",
            "image_alt": "Smooth hydrated skin, no irritation",
            "image_prompt": "Serene close-up of smooth, hydrated, irritation-free mature skin, clean clinical aesthetic, soft lighting, sage green and cream color palette, skincare photography"
          }
        },
        "reason-4": {
          "type": "reason",
          "settings": {
            "heading": "100% Hormone-Safe — Works Locally, Not Systemically",
            "body": "A common concern for perimenopausal and menopausal women. This serum works only on the area where it's applied and does not enter the bloodstream or interfere with your hormones. No parabens, sulfates, or synthetic hormones. Safe for sensitive, mature skin.",
            "image_alt": "Woman confidently applying serum to face",
            "image_prompt": "Confident woman over 45 applying a few drops of serum to clean facial skin in natural light, sage green botanical background, warm and calm aesthetic, skincare lifestyle photography"
          }
        }
      },
      "block_order": ["reason-1", "reason-2", "reason-3", "reason-4"],
      "settings": {
        "padding-block-start": 0,
        "padding-block-end": 0
      }
    },
    "ks-listicle-stats": {
      "type": "ks-listicle-stats",
      "blocks": {
        "stat-1": {
          "type": "stat",
          "settings": { "value": "16,374+", "label": "Five-Star Reviews" }
        },
        "stat-2": {
          "type": "stat",
          "settings": { "value": "98%", "label": "Report Results" }
        },
        "stat-3": {
          "type": "stat",
          "settings": { "value": "7x", "label": "Thinner Hair in 4–6 Weeks" }
        },
        "stat-4": {
          "type": "stat",
          "settings": { "value": "87K+", "label": "Customers" }
        }
      },
      "block_order": ["stat-1", "stat-2", "stat-3", "stat-4"],
      "settings": {
        "padding-block-start": 48,
        "padding-block-end": 48
      }
    },
    "ks-listicle-reasons-2": {
      "type": "ks-listicle-reasons",
      "blocks": {
        "reason-5": {
          "type": "reason",
          "settings": {
            "heading": "Go From Daily Removal to Once a Week — or Less",
            "body": "Most users start removing hair once a week within a month, and once a month by month three. Some stop needing removal entirely. Imagine reclaiming your morning routine — no razor, no wax appointment, no tweezing. Just smooth skin.",
            "image_alt": "Woman relaxing in morning light with glowing skin",
            "image_prompt": "Woman over 40 enjoying morning coffee in natural light, relaxed and confident, no makeup, glowing mature skin, warm home interior, lifestyle photography"
          }
        },
        "reason-6": {
          "type": "reason",
          "settings": {
            "heading": "Save Thousands vs. Laser, Waxing & Threading",
            "body": "The average woman spends $2,400+ per year on waxing alone — not counting laser sessions at $200–$500 each. Three bottles of this serum cost $159. The math is obvious. And unlike laser, it works on all hair colors with no pain, no downtime, no clinic visits.",
            "image_alt": "Serum bottle with cost comparison styling",
            "image_prompt": "Kelle Skin serum bottle on a cream marble surface with minimalist botanical styling, warm natural light, sage green and cream tones, premium product photography"
          }
        },
        "reason-7": {
          "type": "reason",
          "settings": {
            "heading": "60-Day Money-Back Guarantee — Zero Risk",
            "body": "We're so confident in this formula that if you don't see results in 60 days, you get a full refund. No questions asked. Over 16,374 five-star reviews say you won't need it — but the guarantee means you have absolutely nothing to lose by trying.",
            "image_alt": "Serum bottle with guarantee badge",
            "image_prompt": "Kelle Skin serum bottle on soft cream background with a subtle golden guarantee ribbon element, clean minimal product photography, warm light"
          }
        }
      },
      "block_order": ["reason-5", "reason-6", "reason-7"],
      "settings": {
        "padding-block-start": 0,
        "padding-block-end": 0
      }
    },
    "ks-listicle-testimonials": {
      "type": "ks-listicle-testimonials",
      "blocks": {
        "testimonial-1": {
          "type": "testimonial",
          "settings": {
            "name": "Sarah M.",
            "quote": "I tried shaving. I tried threading. I tried everything, but it only made everything worse. All those years of struggle just for this serum to make the stubble literally invisible in like 2 months! My skin is finally healed.",
            "rating": 5
          }
        },
        "testimonial-2": {
          "type": "testimonial",
          "settings": {
            "name": "Caroline T.",
            "quote": "I recently entered perimenopause and these white fine hairs started growing all over my face. I'm honestly so shocked by how fast this worked. It's not even been a full two weeks and my skin is pretty much fully smooth and hair-free again.",
            "rating": 5
          }
        },
        "testimonial-3": {
          "type": "testimonial",
          "settings": {
            "name": "Laura M.",
            "quote": "Menopause made my chin grow out thick, stubborn hair. Tried everything — laser, threading, waxing. This serum is a lifesaver. A month in, and I plucked maybe once or twice since I started, instead of every single morning.",
            "rating": 5
          }
        }
      },
      "block_order": ["testimonial-1", "testimonial-2", "testimonial-3"],
      "settings": {
        "heading": "What Women Are Saying",
        "padding-block-start": 80,
        "padding-block-end": 80
      }
    },
    "ks-listicle-cta": {
      "type": "ks-listicle-cta",
      "settings": {
        "heading": "Ready to stop the daily routine?",
        "subheading": "Join 87,000+ women who made the switch.",
        "button_text": "Shop the Serum →",
        "button_url": "/products/viareline-skin-serum-pro",
        "padding-block-start": 80,
        "padding-block-end": 80
      }
    }
  },
  "order": [
    "ks-listicle-hero",
    "ks-listicle-reasons-1",
    "ks-listicle-stats",
    "ks-listicle-reasons-2",
    "ks-listicle-testimonials",
    "ks-listicle-cta"
  ]
}
```

- [ ] **Step 2: Run theme check on template**

```bash
cd /Users/kosbarb/Documents/personal/shopify-claude && shopify theme check templates/page.ks-listicle.json
```

Expected: No errors.

- [ ] **Step 3: Run full theme check**

```bash
cd /Users/kosbarb/Documents/personal/shopify-claude && shopify theme check
```

Expected: No errors on any of the new files.

- [ ] **Step 4: Commit**

```bash
cd /Users/kosbarb/Documents/personal/shopify-claude && git add templates/page.ks-listicle.json && git commit -m "feat: add ks-listicle page template"
```

---

### Task 7: Activate the Page in Shopify Admin

- [ ] **Step 1: Create the page in Shopify admin**

In the Shopify admin (`mp4rb9-0q.myshopify.com`):
1. Go to **Online Store → Pages**
2. Click **Add page**
3. Set title: `7 Reasons Why Women Over 40 Are Switching to This Serum`
4. Set handle (URL): `ks-listicle`
5. Under **Theme template**, select `ks-listicle`
6. Save

- [ ] **Step 2: Preview the page**

Open `https://mp4rb9-0q.myshopify.com/pages/ks-listicle` (or preview via the theme editor) and verify:
- Hero renders with sage green background and cream text
- All 7 reasons display with placeholder images, alternating layout
- Stats bar shows 4 stats on sage green background
- Testimonials display in 3 columns
- Final CTA renders correctly
- Mobile view: all sections stack correctly

- [ ] **Step 3: Generate images (optional next step)**

Once the page looks correct, run the image-generator agent to fill all 7 placeholder images. The `data-image-prompt` attributes on each `<img>` contain the prompts.
