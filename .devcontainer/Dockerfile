FROM ghcr.io/firecrawl/firecrawl:latest

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

# Remove any devcontainer.json from base image to prevent merge conflicts
RUN rm -rf /usr/local/share/devcontainer 2>/dev/null || true

# Clear the devcontainer.metadata LABEL from base image to prevent merge
LABEL devcontainer.metadata=''