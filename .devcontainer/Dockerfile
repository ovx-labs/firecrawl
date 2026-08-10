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

# Copy updated devcontainer.json into the image for prebuilds
COPY .devcontainer/devcontainer.json /usr/local/share/devcontainer/devcontainer.json

CMD ["sleep", "infinity"]