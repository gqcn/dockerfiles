# loads/claude:latest
# docker buildx build --platform linux/amd64,linux/arm64 -t loads/claude:latest -f Dockerfile . --push
ARG BASE_IMAGE=loads/aicoding:base-26.04
FROM ${BASE_IMAGE}

LABEL maintainer="john@johng.cn"

ARG CLAUDE_CODE_VERSION=latest

# INSTALLATION
USER root

RUN export HOME=/root \
    && npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION} \
    && npm install -g @fission-ai/openspec@latest \
    && npm cache clean --force

# CONFIGURATION
ENV DISABLE_AUTOUPDATER=1 NPM_CONFIG_UPDATE_NOTIFIER=false
USER agent

RUN sudo -n true

# START
CMD ["claude"]
