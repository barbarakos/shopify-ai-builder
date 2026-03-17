#!/bin/bash
# Shopify AI Builder — Installer
# Installs all dependencies: Claude plugins, MCPs, Shopify CLI, GitHub CLI
# Run from the project root: ./scripts/install.sh

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ok()   { echo -e "${GREEN}✅ $1${NC}"; }
warn() { echo -e "${YELLOW}⚠️  $1${NC}"; }
err()  { echo -e "${RED}❌ $1${NC}"; }
step() { echo -e "\n${YELLOW}→ $1${NC}"; }

# ── Check prerequisites ──────────────────────────────────────────

step "Checking prerequisites..."

if ! command -v claude &>/dev/null; then
  err "Claude Code CLI not found. Install it from https://claude.ai/code then re-run this script."
  exit 1
fi
ok "Claude Code CLI: $(claude --version 2>/dev/null | head -1)"

if ! command -v brew &>/dev/null; then
  warn "Homebrew not found. Some installs may fall back to npm. Install from https://brew.sh"
fi

# ── Claude Code Plugins ──────────────────────────────────────────

step "Installing Claude Code plugins..."

claude plugins install superpowers@claude-plugins-official 2>/dev/null \
  && ok "superpowers plugin installed" \
  || warn "superpowers already installed or failed — verify with: claude plugins list"

claude plugins install frontend-design@claude-plugins-official 2>/dev/null \
  && ok "frontend-design plugin installed" \
  || warn "frontend-design already installed or failed — verify with: claude plugins list"

# ── MCP Servers ──────────────────────────────────────────────────

step "Installing MCP servers..."

# Shopify Dev MCP — queries Shopify Admin API schema, Polaris docs, theme APIs
if claude mcp list 2>/dev/null | grep -q "shopify-dev"; then
  ok "shopify-dev MCP already configured"
else
  claude mcp add shopify-dev -- npx -y @shopify/dev-mcp \
    && ok "shopify-dev MCP added" \
    || warn "shopify-dev MCP failed — add manually: claude mcp add shopify-dev -- npx -y @shopify/dev-mcp"
fi

# Playwright MCP — browser automation for scraping JS-heavy brand sites
if claude mcp list 2>/dev/null | grep -q "playwright"; then
  ok "playwright MCP already configured"
else
  claude mcp add playwright -- npx -y @playwright/mcp@latest \
    && ok "playwright MCP added" \
    || warn "playwright MCP failed — add manually: claude mcp add playwright -- npx -y @playwright/mcp@latest"
fi

# ── Shopify CLI ───────────────────────────────────────────────────

step "Checking Shopify CLI..."

if command -v shopify &>/dev/null; then
  ok "Shopify CLI: $(shopify version 2>/dev/null)"
else
  if command -v brew &>/dev/null; then
    step "Installing Shopify CLI via Homebrew..."
    brew tap shopify/shopify && brew install shopify-cli
    ok "Shopify CLI installed: $(shopify version 2>/dev/null)"
  elif command -v npm &>/dev/null; then
    step "Installing Shopify CLI via npm..."
    npm install -g @shopify/cli @shopify/theme
    ok "Shopify CLI installed"
  else
    err "Cannot install Shopify CLI — neither Homebrew nor npm found."
    warn "Install manually: https://shopify.dev/docs/themes/tools/cli"
  fi
fi

# ── GitHub CLI ────────────────────────────────────────────────────

step "Checking GitHub CLI..."

if command -v gh &>/dev/null; then
  ok "GitHub CLI: $(gh --version | head -1)"
else
  if command -v brew &>/dev/null; then
    step "Installing GitHub CLI via Homebrew..."
    brew install gh
    ok "GitHub CLI installed"
  else
    warn "GitHub CLI not found and Homebrew unavailable."
    warn "Install manually: https://cli.github.com"
  fi
fi

# ── .env setup ────────────────────────────────────────────────────

step "Checking .env..."

if [ -f .env ]; then
  ok ".env already exists"
else
  cp .env.example .env
  ok "Created .env from .env.example"
  warn "Open .env and fill in REPLICATE_API_TOKEN and SHOPIFY_STORE_NAME"
fi

# ── Done ──────────────────────────────────────────────────────────

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Shopify AI Builder setup complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Next steps:"
echo "  1. Edit .env → add REPLICATE_API_TOKEN and SHOPIFY_STORE_NAME"
echo "  2. Open Claude Code in this directory"
echo "  3. Say: 'Use the setup-wizard agent to get started'"
echo ""
