# loads/aitrain:base-26.04
FROM ubuntu:26.04

LABEL maintainer="john@johng.cn"

ARG NODE_MAJOR=22
ARG BUILDARCH
ARG TARGETARCH

# INSTALLATION
# Ubuntu 26.04 defaults to uutils coreutils. Its env binary rejects
# "#!/usr/bin/env node" when buildx emulates arm64: QEMU makes /proc/self/exe
# the script path, so npm exits with "Requested utility env does not match".
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y --no-install-recommends --allow-remove-essential \
        ca-certificates sudo \
        procps psmisc iproute2 iputils-ping dnsutils netcat-openbsd \
        libnet-ifconfig-wrapper-perl lsof strace \
        vim wget curl telnet \
        file tree rsync \
        git git-lfs gh \
        less \
        openssh-client \
        sed ripgrep \
        jq yq \
        zip unzip \
        tmux screen htop \
        shellcheck shfmt \
        fd-find bat fzf gnupg \
        coreutils-from-gnu \
    && install -d -m 0755 /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y nodejs \
    && npm cache clean --force \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


