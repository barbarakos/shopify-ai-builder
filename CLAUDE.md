# Shopify AI Builder

## Critical Rules
- NEVER modify existing theme files (templates, sections, blocks, snippets, assets, config, layout, locales) unless the user EXPLICITLY asks you to change a specific named file.
- All new files use the prefix from `brand-knowledge/brand-info.json → project.theme_prefix`. Always read this value first before creating any file. Example: if prefix is `nk`, new sections are `sections/nk-hero.liquid`.
- If `brand-knowledge/brand-info.json` exists, read it before designing anything. It is created by the `brand-knowledge` agent and may not exist on a fresh setup.
- Always run `shopify theme check` before committing.
- Image placeholders: use `{{ 'placeholder.svg' | asset_url }}` with `data-image-prompt="<prompt>"` and `data-image-filename="<prefix>-<name>.jpg"` on every `<img>` that needs AI generation.

## Getting the Theme Prefix and Directory
```bash
python3 -c "import json; d=json.load(open('brand-knowledge/brand-info.json')); print('Prefix:', d['project']['theme_prefix'], '| Theme dir:', d['project'].get('theme_dir', '.'))" 2>/dev/null || echo "brand-info.json missing — run setup-wizard first"
```

Theme files live under `<theme_dir>/` (e.g. `theme_dir=.` means root, `theme_dir=theme` means `theme/sections/`, `theme/templates/`, etc.).

## Shopify Theme Structure
All paths below are relative to `theme_dir`:
- `templates/` — page-type routing (JSON or Liquid)
- `sections/` — reusable, schema-driven page components
- `blocks/` — section sub-components
- `snippets/` — partials (no schema)
- `assets/` — CSS, JS, images
- `config/` — theme settings (do not touch)

## Running the Dev Server
```bash
# Replace <storename> and <theme_dir> from brand-info.json
shopify theme dev --store <storename>.myshopify.com --path <theme_dir>
# If theme_dir is ".", omit --path
```

## Naming Convention (all use configurable prefix)
- New templates: `<theme_dir>/templates/product.<prefix>-<feature>.json` or `<theme_dir>/templates/page.<prefix>-<feature>.json`
- New sections: `<theme_dir>/sections/<prefix>-<feature>.liquid`
- New blocks: `<theme_dir>/blocks/<prefix>-<feature>.liquid`
- New assets: `<theme_dir>/assets/<prefix>-<name>.css` or `<theme_dir>/assets/<prefix>-<name>.js`

## Available Agents
Agent definitions live in `.claude/agents/` (project-level).
- `orchestrator` — start here for user requests
- `brand-knowledge` — extracts brand info from URLs
- `shopify-designer` — creates pages from spec
- `image-generator` — fills image placeholders
- `setup-wizard` — initial Shopify + GitHub + MCP setup

## Cart Event
Check `assets/events.js` for the cart update event name in your specific theme.
