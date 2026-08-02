FROM mcr.microsoft.com/devcontainers/typescript-node:1-22-bookworm

USER root

# Install pnpm globally
RUN npm install -g pnpm@10.32.1

# Install Rust for all users via rustup
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable --profile minimal --no-modify-path \
    && rustup target add x86_64-unknown-linux-gnu \
    && chmod -R a+rw $RUSTUP_HOME $CARGO_HOME

# Install sshd
RUN apt-get update && apt-get install -y openssh-server \
    && mkdir -p /var/run/sshd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/ssh/sshd_config.d \
    && echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config \
    && echo "UsePAM yes" >> /etc/ssh/sshd_config

CMD ["sleep", "infinity"]