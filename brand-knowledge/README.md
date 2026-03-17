# Brand Knowledge

Populated by the `brand-knowledge` Claude agent during setup.

To update: "Update brand knowledge from <url>" or edit `brand-info.json` directly.

## Fields

- `project.theme_prefix` — prefix for all new Shopify files (e.g. `nk`, `ks`, `brand`)
- `project.shopify_store` — store slug (e.g. `my-store` for `my-store.myshopify.com`)
- `visual` — colors and fonts used by all design agents
- `product` — product info used for copy and image generation
- `content` — testimonials, FAQs, stats extracted from brand sites
- `source_urls` — URLs that were analyzed to build this file

## Privacy Note

`brand-info.json` is gitignored by default. If your brand info is not sensitive,
remove it from `.gitignore` to track it in version control.
