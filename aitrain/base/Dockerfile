# loads/aitrain:base-26.04
FROM ubuntu:26.04

LABEL maintainer="john@johng.cn"

ARG NODE_MAJOR=22
ARG CRICTL_VERSION=v1.37.0
ARG BUILDARCH
ARG TARGETARCH

# INSTALLATION
# Ubuntu 26.04 defaults to uutils coreutils. Its env binary rejects
# "#!/usr/bin/env node" when buildx emulates arm64: QEMU makes /proc/self/exe
# the script path, so npm exits with "Requested utility env does not match".
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y --allow-remove-essential coreutils-from-gnu coreutils-from-uutils- \
    && apt-get install -y --no-install-recommends \
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
    && install -d -m 0755 /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y nodejs \
    && npm cache clean --force \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# crictl v1.37.0 is the current cri-tools release. Official binaries cover amd64 and arm64.
RUN curl -fsSL -o /tmp/crictl.tar.gz "https://github.com/kubernetes-sigs/cri-tools/releases/download/${CRICTL_VERSION}/crictl-${CRICTL_VERSION}-linux-${TARGETARCH}.tar.gz" \
    && tar -xzf /tmp/crictl.tar.gz -C /tmp crictl \
    && install -o root -g root -m 0755 /tmp/crictl /usr/local/bin/crictl \
    && rm -f /tmp/crictl /tmp/crictl.tar.gz


