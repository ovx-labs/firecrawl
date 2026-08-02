#!/bin/bash
set -e

# Ensure /usr/local/bin is in PATH for global npm/pnpm
export PATH="/usr/local/bin:$PATH"

# Install Rust toolchain for native module (as node user)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable --profile minimal
source "$HOME/.cargo/env"
rustup target add x86_64-unknown-linux-gnu

# Install pnpm globally (as node user)
npm install -g pnpm@11.4.0

# Set up environment
export PATH="$HOME/.cargo/bin:$HOME/.local/share/pnpm:$PATH"

# Install all dependencies
cd /workspaces/firecrawl/apps/api
pnpm install --frozen-lockfile --ignore-scripts 2>&1 | tail -20

# Build native module
source "$HOME/.cargo/env" && cd /workspaces/firecrawl/apps/api/native && pnpm build 2>&1 | tail -30

# Build TypeScript
cd /workspaces/firecrawl/apps/api && pnpm build 2>&1 | tail -10

echo "Firecrawl codespace setup complete. Run: pnpm start:dev"