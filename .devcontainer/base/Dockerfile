FROM mcr.microsoft.com/devcontainers/typescript-node:1-22-bookworm

# Clear the devcontainer.metadata LABEL from Microsoft base to prevent merge conflicts
LABEL devcontainer.metadata='{}'

USER root

# Install pnpm globally
RUN npm install -g pnpm@10.32.1

# Install system dependencies
RUN apt-get update && apt-get install -y openssh-server \
    && mkdir -p /var/run/sshd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configure SSH for Codespaces
RUN mkdir -p /etc/ssh/sshd_config.d \
    && echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config \
    && echo "UsePAM yes" >> /etc/ssh/sshd_config

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable --profile minimal --no-modify-path \
    && . "$HOME/.cargo/env" \
    && rustup target add x86_64-unknown-linux-gnu \
    && chmod -R a+rw /usr/local/rustup /usr/local/cargo

# Install Playwright dependencies
RUN apt-get update && apt-get install -y \
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Remove any devcontainer.json from base image to prevent merge conflicts
RUN rm -rf /usr/local/share/devcontainer 2>/dev/null || true