# loads/ubuntu:24.04-npm
# docker buildx build --platform linux/amd64,linux/arm64 -t loads/ubuntu:24.04-npm -f Dockerfile . --push
FROM loads/ubuntu:24.04-with-ca

LABEL maintainer="john@johng.cn"

###############################################################################
#                                INSTALLATION
###############################################################################

# 设置安装源
ADD ./dockerfiles/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources

# 安装基础软件
RUN apt-get update && apt-get install -y npm

# APT配置文件覆盖，防止软件自动更新
ADD ./dockerfiles/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades


###############################################################################
#                                   START
###############################################################################

# CMD xxx
