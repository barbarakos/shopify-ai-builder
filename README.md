# Shopify AI Builder

A Claude Code agent system for building high-converting Shopify pages with AI.

## What it does

- Extracts your brand identity from your website (colors, fonts, copy, tone)
- Builds product landing pages, listicles, and advertorials in Liquid
- Generates realistic AI product photography with Replicate
- Never touches your existing theme files — all new pages use your brand prefix
- Mobile-first, schema-driven, editable in Shopify theme editor

## Quick Start

### 1. Clone this repo

```bash
git clone https://github.com/<your-username>/shopify-ai-builder
cd shopify-ai-builder
```

### 2. Run the installer

```bash
./scripts/install.sh
```

This installs: Claude Code plugins (Superpowers, Frontend Design), MCPs (Shopify Dev, Playwright), Shopify CLI, GitHub CLI.

### 3. Configure credentials

```bash
cp .env.example .env
# Edit .env and add your REPLICATE_API_TOKEN and SHOPIFY_STORE_NAME
```

Get a free Replicate API token at [replicate.com/account/api-tokens](https://replicate.com/account/api-tokens).

### 4. Open Claude Code and run setup

```
Use the setup-wizard agent to get started.
```

The wizard will:
- Connect to your Shopify store
- Pull your theme files into this directory
- Ask for your file prefix (e.g. `nk` for brand initials)
- Ask for your brand website URLs
- Extract your brand identity

### 5. Start building

```
Build me a product landing page for [your product name].
```

## Agents

| Agent | Purpose |
|---|---|
| `orchestrator` | Main entry point — routes all requests |
| `setup-wizard` | One-time setup: Shopify, GitHub, brand |
| `brand-knowledge` | Extracts brand info from your website |
| `shopify-designer` | Creates Liquid pages (PDP, listicle, advertorial) |
| `image-generator` | Generates AI product photos |

## Requirements

- macOS or Linux
- [Claude Code](https://claude.ai/code) CLI
- A Shopify store
- A GitHub account
- Free [Replicate](https://replicate.com) account (for AI images)

## License

MIT
