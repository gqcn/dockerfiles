# loads/ubuntu:24.04-with-ca
# docker buildx build --platform linux/amd64,linux/arm64 -t loads/ubuntu:24.04-with-ca -f Dockerfile . --push
FROM ubuntu:24.04

LABEL maintainer="john@johng.cn"

###############################################################################
#                                INSTALLATION
###############################################################################

# 安装基础软件
RUN apt-get update && apt-get install -y vim wget curl ca-certificates


###############################################################################
#                                   START
###############################################################################

# CMD xxx
