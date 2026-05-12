# loads/cc:latest
# docker buildx build --platform linux/amd64,linux/arm64 -t loads/cc:latest -f Dockerfile . --push
FROM loads/ubuntu:24.04-npm

LABEL maintainer="john@johng.cn"

# INSTALLATION
ARG CLAUDE_CODE_VERSION=latest
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        less \
        openssh-client \
        ripgrep \
    && npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION} \
    && npm cache clean --force \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# CONFIGURATION
ENV DISABLE_AUTOUPDATER=1
WORKDIR /workspace

# START
CMD ["claude"]
