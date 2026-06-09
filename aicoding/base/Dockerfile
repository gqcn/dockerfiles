# loads/aicoding:base-26.04
FROM ubuntu:26.04

LABEL maintainer="john@johng.cn"

ARG NODE_MAJOR=22
ARG BUILDARCH
ARG TARGETARCH

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

# Ubuntu 26.04 基础镜像可能已预置 UID/GID 1000 的 ubuntu 用户。
# 这里统一复用或创建 UID/GID 1000，并保证最终运行用户名为 agent。
# 同时创建 /workspace 工作目录并授权给 agent，供交互式开发和工具执行使用。
RUN set -eux \
    && if getent group 1000 >/dev/null; then \
        existing_group="$(getent group 1000 | cut -d: -f1)"; \
        if [ "${existing_group}" != "agent" ]; then \
            groupmod --new-name agent "${existing_group}"; \
        fi; \
    else \
        groupadd --gid 1000 agent; \
    fi \
    && if getent passwd 1000 >/dev/null; then \
        existing_user="$(getent passwd 1000 | cut -d: -f1)"; \
        if [ "${existing_user}" != "agent" ]; then \
            usermod --login agent --gid 1000 --home /home/agent --move-home --shell /bin/bash "${existing_user}"; \
        else \
            usermod --gid 1000 --home /home/agent --shell /bin/bash agent; \
        fi; \
    else \
        useradd --uid 1000 --gid 1000 --create-home --home-dir /home/agent --shell /bin/bash agent; \
    fi \
    && echo "agent ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/agent \
    && chmod 0440 /etc/sudoers.d/agent \
    && visudo -cf /etc/sudoers.d/agent \
    && test -u /usr/bin/sudo \
    && mkdir -p /workspace \
    && chown agent:agent /workspace

# CONFIGURATION
ENV HOME=/home/agent

WORKDIR /workspace
USER agent

# QEMU/binfmt cross-builds cannot execute setuid sudo as a non-root user.
RUN if [ "${BUILDARCH}" = "${TARGETARCH}" ]; then \
        sudo -n true; \
    else \
        test "$(id -u)" = "1000"; \
    fi

# START
# CMD ["bash"]
