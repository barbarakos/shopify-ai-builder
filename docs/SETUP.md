# Setup Guide

## Prerequisites

- **Claude Code** — [install](https://claude.ai/code)
- **Node.js 18+** — for Shopify CLI and MCP servers
- **A Shopify store** with a live theme

---

## Step 1: Clone the repo

```bash
git clone https://github.com/<your-username>/shopify-ai-builder.git my-store-theme
cd my-store-theme
```

## Step 2: Run the installer

```bash
bash scripts/install.sh
```

This installs:
- Claude superpowers + frontend-design plugins
- `@shopify/dev-mcp` and `@playwright/mcp` MCP servers
- Shopify CLI
- GitHub CLI

## Step 3: Open in Claude Code

```bash
claude .
```

Then say: **"set me up"**

The setup wizard will:
1. Guide you through `.env` credentials
2. Log you into your Shopify store
3. Ask for your brand prefix (2–4 letters, e.g. `nk` for Nike)
4. Pull your theme files
5. Extract your brand identity from your website

---

## Building Pages

After setup:

```
"Build me a product landing page for [product name]"
"Build me a listicle for [product name]"
"Build me an advertorial for [product name]"
```

## Generating Images

After a page is built:

```
"Generate images for the [page name] page"
```

## Previewing

```bash
shopify theme dev --store <your-store>.myshopify.com
```

## Publishing

```
"push" or "deploy"
```

---

## Environment Variables

| Variable | Description |
|---|---|
| `REPLICATE_API_TOKEN` | Replicate API token — [get one free](https://replicate.com/account/api-tokens) |
| `SHOPIFY_STORE_NAME` | Your store slug (e.g. `my-store` for `my-store.myshopify.com`) |

These are stored in `.env` (gitignored — never committed).

---

## File Naming Convention

All generated files use your brand prefix to stay separate from the base theme:

| Type | Pattern |
|---|---|
| Sections | `sections/<prefix>-*.liquid` |
| Product templates | `templates/product.<prefix>-*.json` |
| Page templates | `templates/page.<prefix>-*.json` |
| Assets | `assets/<prefix>-*.css`, `assets/<prefix>-*.js` |

The base theme files are never modified.

---

## Agents

| Agent | Purpose |
|---|---|
| `orchestrator` | Routes all requests |
| `setup-wizard` | First-time setup |
| `brand-knowledge` | Extracts brand identity from your website |
| `shopify-designer` | Builds Liquid sections and JSON templates |
| `image-generator` | Generates AI product/lifestyle photos |
