# loads/ubuntu:24.04-npm
# docker buildx build --platform linux/amd64,linux/arm64 -t loads/ubuntu:24.04-npm -f Dockerfile . --push
FROM ubuntu:24.04

LABEL maintainer="john@johng.cn"

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get update && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt-get install -y locales

RUN localedef -c -f UTF-8 -i en_US en_US.utf8
ENV LC_ALL en_US.utf8

# 安装基础软件
RUN apt-get install -y vim wget curl telnet inetutils-ping libnet-ifconfig-wrapper-perl lsof

# 安装 Node.js 和 npm
RUN apt-get install -y npm


RUN apt-get clean && rm -rf /var/lib/apt/lists/*