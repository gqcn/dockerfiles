# loads/codex:latest
ARG BASE_IMAGE=loads/aicoding:base-26.04
FROM ${BASE_IMAGE}

LABEL maintainer="john@johng.cn"

ARG CODEX_VERSION=latest

# INSTALLATION
USER root

RUN export HOME=/root \
    && npm install -g "@openai/codex@${CODEX_VERSION}" \
    && npm install -g @fission-ai/openspec@latest \
    && npm cache clean --force

# CONFIGURATION
ENV CODEX_HOME=/home/agent/.codex NPM_CONFIG_UPDATE_NOTIFIER=false
USER agent

RUN sudo -n true

# START
CMD ["codex"]
