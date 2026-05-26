#!/usr/bin/env bash
# SessionStart hook: install CLIs that aren't in the base web container image.
# Runs at the start of every Claude Code session for this repo.
# Idempotent — skips anything already installed.

set -uo pipefail

need() { ! command -v "$1" >/dev/null 2>&1; }

# --- vercel -------------------------------------------------------------
if need vercel; then
  echo "[install-clis] installing vercel"
  npm install -g vercel --silent 2>&1 | tail -1
fi

# Add more CLIs below as you need them. Examples (uncomment to enable):
#
# need netlify   && npm install -g netlify-cli --silent
# need supabase  && npm install -g supabase --silent
# need wrangler  && npm install -g wrangler --silent
# need pnpm      && npm install -g pnpm --silent
# need turbo     && npm install -g turbo --silent
# need stripe    && curl -fsSL https://packages.stripe.dev/api/security/keypair/stripe-cli-gpg/public | sudo gpg --dearmor -o /usr/share/keyrings/stripe.gpg && echo "deb [signed-by=/usr/share/keyrings/stripe.gpg] https://packages.stripe.dev/stripe-cli-debian-local stable main" | sudo tee /etc/apt/sources.list.d/stripe.list >/dev/null && sudo apt-get update -qq && sudo apt-get install -y -qq stripe

echo "[install-clis] ready"
