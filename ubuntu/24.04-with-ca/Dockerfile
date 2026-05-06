# loads/ubuntu:24.04-with-ca
# docker build -t loads/ubuntu:24.04-with-ca -f Dockerfile .
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
