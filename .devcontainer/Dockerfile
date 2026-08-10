FROM mcr.microsoft.com/devcontainers/typescript-node:1-22-bookworm

USER root

# Install pnpm globally
RUN npm install -g pnpm@10.32.1

# Install Rust system-wide
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable --profile minimal \
    && . /root/.cargo/env \
    && rustup target add x86_64-unknown-linux-gnu \
    && cp -r /root/.cargo/bin/* /usr/local/bin/

# Install sshd
RUN apt-get update && apt-get install -y openssh-server \
    && mkdir -p /var/run/sshd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/ssh/sshd_config.d \
    && echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config \
    && echo "UsePAM yes" >> /etc/ssh/sshd_config

# Remove any .devcontainer directory from base image to prevent merge conflicts
RUN rm -rf /usr/local/share/devcontainer 2>/dev/null || true

# Set devcontainer metadata label to match repo's devcontainer.json
LABEL devcontainer.metadata='[{"name": "Firecrawl Codespace", "build": {"dockerfile": "Dockerfile"}, "dockerComposeFile": ["docker-compose.codespaces.yml"], "service": "api", "runServices": ["api", "redis", "rabbitmq", "nuq-postgres", "playwright-service"], "workspaceFolder": "/workspaces/firecrawl", "forwardPorts": [3002], "portsAttributes": {"3002": {"label": "Firecrawl API", "onAutoForward": "notify"}}, "postCreateCommand": "echo \"Firecrawl Codespace created. Services will start via docker compose.\"", "remoteUser": "node", "features": {"ghcr.io/devcontainers/features/docker-in-docker:2": {}, "ghcr.io/devcontainers/features/github-cli:1": {}}, "customizations": {"vscode": {"extensions": ["dbaeumer.vscode-eslint", "esbenp.prettier-vscode", "ms-playwright.playwright", "rust-lang.rust-analyzer"], "settings": {"terminal.integrated.defaultProfile.linux": "bash"}}}}]'

CMD ["sleep", "infinity"]