# Shopify AI Builder

## Critical Rules
- NEVER modify existing theme files (templates, sections, blocks, snippets, assets, config, layout, locales) unless the user EXPLICITLY asks you to change a specific named file.
- All new files use the prefix from `brand-knowledge/brand-info.json → project.theme_prefix`. Always read this value first before creating any file. Example: if prefix is `nk`, new sections are `sections/nk-hero.liquid`.
- If `brand-knowledge/brand-info.json` exists, read it before designing anything. It is created by the `brand-knowledge` agent and may not exist on a fresh setup.
- Always run `shopify theme check` before committing.
- Image placeholders: use `{{ 'placeholder.svg' | asset_url }}` with `data-image-prompt="<prompt>"` and `data-image-filename="<prefix>-<name>.jpg"` on every `<img>` that needs AI generation.

## Getting the Theme Prefix
```bash
python3 -c "import json; d=json.load(open('brand-knowledge/brand-info.json')); print(d['project']['theme_prefix'])" 2>/dev/null || echo "PREFIX NOT SET — run setup-wizard first"
```

## Shopify Theme Structure
- `templates/` — page-type routing (JSON or Liquid)
- `sections/` — reusable, schema-driven page components
- `blocks/` — section sub-components
- `snippets/` — partials (no schema)
- `assets/` — CSS, JS, images
- `config/` — theme settings (do not touch)

## Running the Dev Server
```bash
# Replace <storename> with your Shopify store slug (e.g., my-store for my-store.myshopify.com)
shopify theme dev --store <storename>.myshopify.com
```

## Naming Convention (all use configurable prefix)
- New templates: `templates/product.<prefix>-<feature>.json` or `templates/page.<prefix>-<feature>.json`
- New sections: `sections/<prefix>-<feature>.liquid`
- New blocks: `blocks/<prefix>-<feature>.liquid`
- New assets: `assets/<prefix>-<name>.css` or `assets/<prefix>-<name>.js`

## Available Agents
Agent definitions live in `.claude/agents/` (project-level).
- `orchestrator` — start here for user requests
- `brand-knowledge` — extracts brand info from URLs
- `shopify-designer` — creates pages from spec
- `image-generator` — fills image placeholders
- `setup-wizard` — initial Shopify + GitHub + MCP setup

## Cart Event
Check `assets/events.js` for the cart update event name in your specific theme.
