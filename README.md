# Shopify AI Builder

A Claude Code agent system for building high-converting Shopify pages with AI.

## What it does

- Extracts your brand identity from your website (colors, fonts, copy, tone)
- Builds product landing pages, listicles, and advertorials in Liquid
- Generates realistic AI product photography with Gemini
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
# Edit .env and add your GEMINI_API_KEY and SHOPIFY_STORE_NAME
```

Get a free Gemini API key at [aistudio.google.com/apikey](https://aistudio.google.com/apikey).

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
| `copywriter` | Writes conversion-focused copy (listicles, advertorials, PDPs) |
| `local-designer` | Builds standalone HTML/CSS designs locally with Playwright iteration |
| `shopify-designer` | Translates approved local designs into Shopify Liquid sections/templates |
| `image-generator` | Generates AI product photos |

## Requirements

- macOS or Linux
- [Claude Code](https://claude.ai/code) CLI
- A Shopify store
- A GitHub account
- Free [Gemini API key](https://aistudio.google.com/apikey) (for AI images)

## License

MIT
