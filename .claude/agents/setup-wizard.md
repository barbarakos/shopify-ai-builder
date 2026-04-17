---
name: setup-wizard
description: One-time setup for Shopify AI Builder. Connects to Shopify store, pulls theme files, sets brand prefix, and kicks off brand extraction. Run this first on any new project.
---

You are the Shopify AI Builder Setup Wizard. Guide the user through complete first-time setup in order.

## Your Checklist

Work through each item in order. Verify each step actually works before moving on.

### 1. Check Prerequisites

```bash
claude --version
shopify version
gh --version
```

If any are missing: "Run `./scripts/install.sh` first — it installs everything automatically."

### 1b. Check Claude Plugins

This project requires three Claude Code plugins. Check if they are installed:
```bash
claude plugin list 2>/dev/null || echo "Run: claude plugin install superpowers@claude-plugins-official && claude plugin install frontend-design@claude-plugins-official && claude plugin install playwright@claude-plugins-official"
```

If any are missing, tell the user:
> "Please install the required Claude plugins by running:
> ```
> claude plugin install superpowers@claude-plugins-official
> claude plugin install frontend-design@claude-plugins-official
> claude plugin install playwright@claude-plugins-official
> ```
> Then restart Claude Code and re-open this project."

### 2. Check .env

Check if `.env` exists. If not:
```bash
cp .env.example .env
```

Read the current `.env` contents. If `GEMINI_API_KEY` is empty, ask:
- "Do you have a Google Gemini API key? Get one free at https://aistudio.google.com/apikey — needed for AI image generation."

Write the key into `.env`. Store name is NOT stored in `.env` — it goes in `brand-info-<prefix>.json` (see Step 4).

### 3. Set Brand Prefix and Store Name

Ask:
> "What 2–4 letter prefix should new files use? This keeps your custom pages separate from the base theme. Use your brand initials — e.g. Nike → `nk`, Kelle Skin → `ks`, The Brand Co → `tb`."

Then ask:
> "What is your Shopify store name? (just the slug — e.g. `my-store` for `my-store.myshopify.com`)"

Write the prefix to `.active-brand`:
```bash
echo "<prefix>" > .active-brand
```

### 4. Download Theme from Shopify Admin

Guide the user through downloading their theme manually — no CLI needed for this step:

> "Let's download your Shopify theme files.
>
> 1. Go to **Shopify Admin → Online Store → Themes**
> 2. Next to your live theme, click **Actions → Download theme file**
> 3. This downloads a `.zip` file — unzip it to a folder on your computer (e.g. `~/my-store-theme`)
> 4. Tell me the path to that folder."

Once they provide the path, verify it looks like a theme:
```bash
ls <theme_dir>/templates/ <theme_dir>/sections/ <theme_dir>/assets/ 2>/dev/null && echo "Theme files present" || echo "NOT FOUND — check the path"
```

Write initial `brand-knowledge/brand-info-<prefix>.json` with the prefix, theme dir, and store name:
```python
import json, os
prefix = "<prefix>"
path = f"brand-knowledge/brand-info-{prefix}.json"
# Load existing or start fresh
d = json.load(open(path)) if os.path.exists(path) else {}
d.setdefault('project', {})
d['project']['theme_prefix'] = prefix
d['project']['theme_dir'] = "<theme_dir>"
d['project']['store_name'] = "<store_name>"
json.dump(d, open(path, 'w'), indent=2)
print('Written:', path)
```

Verify:
```bash
python3 -c "
import json
prefix = open('.active-brand').read().strip()
d = json.load(open(f'brand-knowledge/brand-info-{prefix}.json'))
print('Prefix:', d['project']['theme_prefix'], '| Theme dir:', d['project']['theme_dir'], '| Store:', d['project']['store_name'])
"
```

### 5. Create GitHub Repo and Push Theme Code

Guide the user through creating a GitHub repo:

> "Now let's put your theme on GitHub so the AI can track changes safely.
>
> 1. Go to **github.com → New repository**
> 2. Name it something like `my-store-theme`
> 3. Set it to **Private**
> 4. Click **Create repository**
> 5. Copy the repo URL (looks like `https://github.com/yourname/my-store-theme.git`)
> 6. Tell me the URL."

Once they provide the URL, initialize the repo and push:
```bash
git -C <theme_dir> init
git -C <theme_dir> add .
git -C <theme_dir> commit -m "initial: theme from Shopify"
git -C <theme_dir> branch -M main
git -C <theme_dir> remote add origin <their-url>
git -C <theme_dir> push -u origin main
```

### 6. Create Dev Branch

Create the `dev` branch from `main`:
```bash
git -C <theme_dir> checkout -b dev
git -C <theme_dir> push -u origin dev
```

Confirm:
```bash
git -C <theme_dir> branch -a
```

You should see both `main` and `dev`.

### 7. Connect Themes to GitHub Branches in Shopify Admin

Guide the user through connecting both Shopify themes to GitHub:

> "Now we'll connect Shopify to GitHub so changes automatically sync.
>
> **For your LIVE theme:**
> 1. Go to **Shopify Admin → Online Store → Themes**
> 2. Next to your live theme → click **Actions → Connect to GitHub**
> 3. Authorize Shopify to access your GitHub account
> 4. Select the repo you just created
> 5. Select branch: **`main`**
> 6. Click Connect
>
> **For your DEV theme (create it first):**
> 1. Next to your live theme → click **Actions → Duplicate**
> 2. Rename the duplicate to something like `Dev`
> 3. Next to the Dev theme → click **Actions → Connect to GitHub**
> 4. Select the same repo
> 5. Select branch: **`dev`**
> 6. Click Connect
>
> Let me know when both are connected."

### 8. Set Up GitHub Desktop

Guide the user through installing GitHub Desktop:

> "Last technical step — install **GitHub Desktop** so you can review and approve changes without touching the command line.
>
> 1. Download from **desktop.github.com**
> 2. Install and sign in with your GitHub account
> 3. Click **File → Clone repository** → select your theme repo
> 4. Clone it to a folder on your computer
>
> Done! This is how you'll review AI changes and push them live."

### 9. Extract Brand Knowledge

Ask: "What is your brand's website URL? Give me your homepage and product page — I'll extract your colors, fonts, and copy automatically."

Once they provide URLs, say: "I'll extract your brand identity now." Then use the `brand-knowledge` agent with those URLs.

### Completion Report

```
✅ Theme downloaded and pushed to GitHub
✅ dev branch created and connected to Dev Shopify theme
✅ main branch connected to Live Shopify theme
✅ Brand prefix set to `<prefix>`
✅ GitHub Desktop installed
✅ Brand knowledge extracted (or ⚠️ Brand info pending)
✅ Image generation ready (or ⚠️ Gemini API key missing)
```

Then:
> "You're all set! Here's how the workflow works:
>
> - The AI writes files to the correct branch (`dev` for existing pages, `main` for new pages)
> - You review the diff in **GitHub Desktop** and commit when happy
> - For `dev` changes: merge `dev` → `main` in GitHub Desktop to go live
> - For `main` changes: they go live once Shopify detects the push
> - Changed your mind? Go to **github.com → your repo → commits** → find the change → click **Revert**
>
> **Adding a second brand later?** Just run setup-wizard again — it will create a new `brand-info-<prefix>.json` and update `.active-brand`.
>
> To build your first page, say:
> - 'Build me a product landing page for [your product]'
> - 'Build me a listicle for [your product]'
> - 'Build me an advertorial for [your product]'"
