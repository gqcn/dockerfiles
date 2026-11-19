# loads/aitrain:all-26.04
FROM ubuntu:26.04

LABEL maintainer="john@johng.cn"

ARG NODE_MAJOR=22
ARG KUBECTL_VERSION=v1.37.2
ARG CRICTL_VERSION=v1.37.0
ARG BUILDARCH
ARG TARGETARCH

# INSTALLATION
# No NVIDIA driver, CUDA, or PyTorch packages. The host toolkit mounts
# nvidia-smi and libcuda. CUDA waits until the oldest cluster driver is known.
# The packages below are the driver-independent training dev userspace.
# coreutils-from-gnu replaces uutils env, which rejects "#!/usr/bin/env node"
# when buildx emulates arm64 and QEMU rewrites /proc/self/exe.
# Do not install build-essential: it depends on coreutils-from-uutils and
# would switch env back.
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
        python3 python3-pip python3-venv python3-dev python3-setuptools python3-wheel \
        gcc g++ make libc6-dev libcrypt-dev cmake ninja-build pkg-config \
        openssh-server \
        rdma-core libibverbs1 ibverbs-providers librdmacm1 \
        infiniband-diags perftest numactl libnuma1 libaio1t64 pciutils pdsh \
    && install -d -m 0755 /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y nodejs \
    && npm cache clean --force \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/sshd \
    && rm -f /etc/ssh/ssh_host_*

# kubectl v1.37.2 is the current stable client. Official binaries cover amd64 and arm64.
RUN curl -fsSL -o /tmp/kubectl "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl" \
    && install -o root -g root -m 0755 /tmp/kubectl /usr/local/bin/kubectl \
    && rm -f /tmp/kubectl

# crictl v1.37.0 is the current cri-tools release. Official binaries cover amd64 and arm64.
RUN curl -fsSL -o /tmp/crictl.tar.gz "https://github.com/kubernetes-sigs/cri-tools/releases/download/${CRICTL_VERSION}/crictl-${CRICTL_VERSION}-linux-${TARGETARCH}.tar.gz" \
    && tar -xzf /tmp/crictl.tar.gz -C /tmp crictl \
    && install -o root -g root -m 0755 /tmp/crictl /usr/local/bin/crictl \
    && rm -f /tmp/crictl /tmp/crictl.tar.gz

# CONFIGURATION
# utility mounts the node-local nvidia-smi. Ubuntu 26.04 Python is externally managed.
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV PIP_BREAK_SYSTEM_PACKAGES=1

# 预置安装一些常用AI助手工具
RUN export HOME=/root \
    && npm install -g @anthropic-ai/claude-code@latest \
    && npm install -g "@openai/codex@latest" \
    && npm install -g "@opencode/cli@latest" \
    && npm install -g @fission-ai/openspec@latest \
    && npm cache clean --force



