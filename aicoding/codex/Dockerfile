# loads/codex:latest
FROM ubuntu:26.04

LABEL maintainer="john@johng.cn"

ARG NODE_MAJOR=22
ARG CODEX_VERSION=latest

# 安装基础软件
RUN apt update && apt install -y --no-install-recommends \
    ca-certificates sudo \
    procps psmisc iproute2 iputils-ping dnsutils netcat-openbsd \
    libnet-ifconfig-wrapper-perl lsof strace

# 安装常用软件
RUN apt install -y --no-install-recommends \
    vim wget curl telnet \
    file tree rsync \
    git git-lfs gh \
    less \
    openssh-client \
    sed ripgrep \
    jq yq \
    zip unzip \
    htop \
    shellcheck shfmt \
    fd-find bat fzf gnupg

# 安装 Node.js 和 npm
RUN apt-get install -y npm

# INSTALLATION
RUN export DEBIAN_FRONTEND=noninteractive \
    && install -d -m 0755 /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y nodejs \
    && npm install -g "@openai/codex@${CODEX_VERSION}" \
    && npm install -g @fission-ai/openspec@latest \
    && npm cache clean --force 

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# CONFIGURATION
ENV CODEX_HOME=/root/.codex NPM_CONFIG_UPDATE_NOTIFIER=false

WORKDIR /workspace

# START
CMD ["codex"]
