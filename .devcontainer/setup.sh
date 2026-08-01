#!/bin/bash
set -e
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable --profile minimal
source "$HOME/.cargo/env"
rustup target add x86_64-unknown-linux-gnu
npm install -g pnpm@11.4.0
export PATH="$HOME/.cargo/bin:$HOME/.local/share/pnpm:\$PATH"
cd /workspaces/firecrawl/apps/api
pnpm install --frozen-lockfile --ignore-scripts 2>&1 | tail -20
source "$HOME/.cargo/env" && cd /workspaces/firecrawl/apps/api/native && pnpm build 2>&1 | tail -30
cd /workspaces/firecrawl/apps/api && pnpm build 2>&1 | tail -10
echo "Firecrawl codespace setup complete. Run: pnpm start:dev"