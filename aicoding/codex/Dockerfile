# loads/codex:latest
FROM loads/ubuntu:24.04-npm

LABEL maintainer="john@johng.cn"

ARG NODE_MAJOR=22
ARG CODEX_VERSION=latest

# INSTALLATION
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y ca-certificates curl git gnupg jq less openssh-client ripgrep \
    && install -d -m 0755 /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y nodejs \
    && npm install -g "@openai/codex@${CODEX_VERSION}" \
    && npm cache clean --force \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# CONFIGURATION
ENV CODEX_HOME=/root/.codex \
    NPM_CONFIG_UPDATE_NOTIFIER=false

WORKDIR /workspace

# START
CMD ["codex"]
