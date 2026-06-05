# loads/aicoding:base-26.04
FROM ubuntu:26.04

LABEL maintainer="john@johng.cn"

ARG NODE_MAJOR=22

# INSTALLATION
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
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
        htop \
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

RUN groupadd --gid 1000 agent \
    && useradd --uid 1000 --gid 1000 --create-home --home-dir /home/agent --shell /bin/bash agent \
    && echo "agent ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/agent \
    && chmod 0440 /etc/sudoers.d/agent \
    && mkdir -p /workspace \
    && chown agent:agent /workspace

# CONFIGURATION
ENV HOME=/home/agent

WORKDIR /workspace
USER agent

RUN sudo -n true

# START
# CMD ["bash"]
