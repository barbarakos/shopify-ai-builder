# Shopify Annotation Spec

This spec defines the `data-shopify-*` HTML attribute system used to annotate local design files so the `shopify-designer` translator can convert them to Shopify Liquid sections and templates.

## Core Concept

The local designer builds a plain HTML/CSS page using **mock data**. Every element that maps to a Shopify concept is annotated with `data-shopify-*` attributes. The translator reads these annotations and generates the correct Liquid output.

---

## Attribute Reference

### `data-shopify-section="<name>"`
**On:** section wrapper element (`<section>`, `<div>`)
**Means:** This element becomes a Liquid section file named `<prefix>-<name>.liquid`.
**Required:** Yes — every distinct section must have this.

```html
<section data-shopify-section="hero-split">
  ...
</section>
```

---

### `data-shopify-setting="<key>"` + `data-shopify-type="<type>"`
**On:** any element inside a section
**Means:** This element's content/src is a merchant-editable setting in the section schema.
**Types:** `text`, `richtext`, `image_picker`, `color`, `range`, `select`, `checkbox`, `url`
**Required type:** always pair with `data-shopify-type`

```html
<h1 data-shopify-setting="heading" data-shopify-type="text">Your Best Skin Starts Here</h1>
<p data-shopify-setting="subheading" data-shopify-type="richtext">Clinically proven formula</p>
<img data-shopify-setting="hero_image" data-shopify-type="image_picker"
     data-image-prompt="Woman 40s glowing skin morning light"
     data-image-filename="ks-hero-main.jpg" src="mock-hero.jpg">
```

Translator output:
```liquid
<h1>{{ section.settings.heading }}</h1>
{{ section.settings.subheading }}
```
Schema entry:
```json
{"type": "text", "id": "heading", "label": "Heading", "default": "Your Best Skin Starts Here"}
```

---

### `data-shopify-block="<type>"`
**On:** a repeatable item container inside a section
**Means:** This element is a Shopify block. All `data-shopify-setting` children become block settings. The local design should show 2–4 instances to illustrate the layout.

```html
<div data-shopify-block="reason">
  <h3 data-shopify-setting="title" data-shopify-type="text">Reduces dark spots</h3>
  <p data-shopify-setting="body" data-shopify-type="richtext">In as little as 14 days</p>
  <img data-shopify-setting="image" data-shopify-type="image_picker"
       data-image-prompt="Close up of clear skin texture"
       data-image-filename="ks-reason-1.jpg" src="mock-reason.jpg">
</div>
```

Translator output: block definition in schema, `{% for block in section.blocks %}` loop in Liquid.

---

### `data-shopify-var="<liquid.variable>"`
**On:** any element whose content comes from a Liquid context variable (not merchant-editable)
**Means:** Replace mock content with this Liquid variable directly.

```html
<span data-shopify-var="product.price | money">$49.99</span>
<span data-shopify-var="product.title">Cyperus Serum</span>
<span data-shopify-var="customer.first_name">Jane</span>
```

Translator output: `{{ product.price | money }}`, `{{ product.title }}`, etc.

---

### `data-shopify-if="<condition>"`
**On:** any element that is conditionally shown
**Means:** Wrap the element in `{% if <condition> %}...{% endif %}`

```html
<s data-shopify-if="product.compare_at_price > product.price"
   data-shopify-var="product.compare_at_price | money">$69.99</s>
```

Translator output:
```liquid
{% if product.compare_at_price > product.price %}
  <s>{{ product.compare_at_price | money }}</s>
{% endif %}
```

---

### `data-shopify-action="<action>"`
**On:** buttons, forms, links that trigger Shopify functionality
**Means:** Wire this element to the corresponding Shopify action.

| Value | Translator generates |
|---|---|
| `add-to-cart` | `<button type="submit" name="add">` inside `{% form 'product', product %}` |
| `product-form` | `{% form 'product', product %}...{% endform %}` wrapper |
| `variant-select` | `<select name="id">{% for variant in product.variants %}...{% endfor %}</select>` |
| `cart-link` | `<a href="{{ routes.cart_url }}">` |
| `checkout-link` | `<a href="/checkout">` |

```html
<form data-shopify-action="product-form">
  <select data-shopify-action="variant-select">
    <option value="1">1 Bottle — $49</option>
    <option value="2">3 Bottles — $129</option>
  </select>
  <button data-shopify-action="add-to-cart">Add to Cart</button>
</form>
```

---

### `data-shopify-include="<snippet>"`
**On:** any element whose output comes from a Liquid snippet
**Means:** Replace with `{% render '<snippet>' %}`

```html
<div data-shopify-include="product-rating">★★★★★ (214 reviews)</div>
```

Translator output: `{% render 'product-rating' %}`

Note: The shopify-designer translator must warn the user if a referenced snippet does not exist in the theme's `snippets/` directory.

---

## Full Example

```html
<section data-shopify-section="hero-split" style="background: #FAF8F5;">
  <div class="hero-grid">
    <div class="hero-copy">
      <p data-shopify-setting="eyebrow" data-shopify-type="text">#1 Dermatologist Pick</p>
      <h1 data-shopify-setting="heading" data-shopify-type="text">Finally. Skin That Looks Its Age — In Reverse.</h1>
      <p data-shopify-setting="subheading" data-shopify-type="richtext">Backed by 3 clinical studies. 94% saw results in 30 days.</p>
      <form data-shopify-action="product-form">
        <select data-shopify-action="variant-select">
          <option>1 Bottle — $49</option>
          <option>3 Bottles — $129 (Best Value)</option>
        </select>
        <button data-shopify-action="add-to-cart" style="min-height:44px;">Try It Risk-Free</button>
      </form>
      <p style="font-size:13px;">Free shipping · 30-day money-back guarantee</p>
    </div>
    <div class="hero-image">
      <img data-shopify-setting="hero_image" data-shopify-type="image_picker"
           data-image-prompt="Woman in her 40s touching her face, glowing skin, morning light, natural, not posed"
           data-image-filename="ks-hero-main.jpg"
           src="mock-hero.jpg" style="width:100%; border-radius:12px;">
    </div>
  </div>
</section>
```

---

## Rules for local-designer

1. Every visible section wrapper must have `data-shopify-section`.
2. Every text/image the merchant should be able to edit must have `data-shopify-setting` + `data-shopify-type`.
3. Repeatable items (listicle reasons, benefit cards, testimonials) must use `data-shopify-block`.
4. Product price, title, and other live Shopify variables must use `data-shopify-var`.
5. All images that need AI generation must have `data-image-prompt` and `data-image-filename`.
6. Mock data must be realistic (real prices, real-sounding copy, real dimensions).
7. Do NOT nest `data-shopify-section` inside another `data-shopify-section` — sections are flat.

## Rules for shopify-designer (translator)

1. Read annotations top-to-bottom, one `data-shopify-section` at a time.
2. For each section: create one `.liquid` file, one schema `settings` array entry per `data-shopify-setting`, one `blocks` array entry per unique `data-shopify-block` type.
3. Preserve all CSS classes and structure exactly — only swap mock content for Liquid variables.
4. `data-shopify-var` values are used verbatim inside `{{ }}`.
5. `data-shopify-if` values are used verbatim inside `{% if %}`.
6. `data-shopify-action` values are expanded per the action table above.
7. Remove all `data-shopify-*` attributes from final Liquid output (they are build-time only).
8. Keep `data-image-prompt` and `data-image-filename` on `<img>` tags — the image-generator agent needs them.
