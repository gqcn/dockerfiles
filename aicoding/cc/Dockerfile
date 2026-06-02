# loads/cc:latest
# docker buildx build --platform linux/amd64,linux/arm64 -t loads/cc:latest -f Dockerfile . --push
FROM ubuntu:26.04

LABEL maintainer="john@johng.cn"

ARG CLAUDE_CODE_VERSION=latest

# INSTALLATION

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

RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION} \
    && npm install -g @fission-ai/openspec@latest \
    && npm cache clean --force 

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# CONFIGURATION
ENV DISABLE_AUTOUPDATER=1
WORKDIR /workspace

# START
CMD ["claude"]
