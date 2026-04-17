# Shopify AI Builder

## Critical Rules
- NEVER modify existing theme files (templates, sections, blocks, snippets, assets, config, layout, locales) unless the user EXPLICITLY asks you to change a specific named file.
- All new files use the prefix from `brand-knowledge/brand-info.json → project.theme_prefix`. Always read this value first before creating any file. Example: if prefix is `nk`, new sections are `sections/nk-hero.liquid`.
- If `brand-knowledge/brand-info.json` exists, read it before designing anything. It is created by the `brand-knowledge` agent and may not exist on a fresh setup.
- Always run `shopify theme check` after writing files.
- Image placeholders: use `{{ 'placeholder.svg' | asset_url }}` with `data-image-prompt="<prompt>"` and `data-image-filename="<prefix>-<name>.jpg"` on every `<img>` that needs AI generation.
- **Agents NEVER commit or push.** Agents only checkout branches and write files. The user always commits via GitHub Desktop.
- **NEVER run `shopify theme push`, `git commit`, or `git push`.**
- **Branch strategy — check before touching any files:**
  - **Modifying an existing template/section** that is already live → checkout `dev` branch: `git -C <theme_dir> checkout dev && git -C <theme_dir> pull origin main`
  - **Creating a brand-new template + sections** that do not exist yet → work on `main` branch: `git -C <theme_dir> checkout main && git -C <theme_dir> pull origin main` (new templates can only be assigned to pages on the live theme — dev theme can't use templates that don't exist on main)
- After writing files, always tell the user: "Files are ready. Open **GitHub Desktop**, review the diff, and commit when you're happy."

## Getting the Theme Prefix and Directory

Each brand has its own `brand-knowledge/brand-info-<prefix>.json`. The active brand is tracked in `.active-brand`.

```bash
python3 -c "
import json,os,glob
# Migration guard
if os.path.exists('brand-knowledge/brand-info.json') and not glob.glob('brand-knowledge/brand-info-*.json'):
    print('ERROR: Old brand-info.json found. Rename it to brand-info-<prefix>.json and create .active-brand containing your prefix, or re-run setup-wizard.'); exit(1)
a=open('.active-brand').read().strip() if os.path.exists('.active-brand') else None
if not a:
    files=glob.glob('brand-knowledge/brand-info-*.json')
    if len(files)==1: a=files[0].replace('brand-knowledge/brand-info-','').replace('.json','')
    elif len(files)==0: print('No brand-info files found — run setup-wizard first'); exit(1)
    else:
        names=[f.replace('brand-knowledge/brand-info-','').replace('.json','') for f in files]
        print(f'Multiple brands: {names}. Say \"switch to [brand]\" first.'); exit(1)
d=json.load(open(f'brand-knowledge/brand-info-{a}.json'))
print('Prefix:',d['project']['theme_prefix'],'| Theme dir:',d['project'].get('theme_dir','.'),'| Store:',d['project'].get('store_name',''))
" 2>/dev/null || echo "brand-info missing — run setup-wizard first"
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
