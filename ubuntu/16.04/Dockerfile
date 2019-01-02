# loads/ubuntu:16.04
FROM ubuntu:16.04

LABEL maintainer="john@johng.cn"

###############################################################################
#                                INSTALLATION
###############################################################################

ADD ./dockerfiles/sources.list /etc/apt/sources.list

# 设置系统时区及字符编码
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get update && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt-get install -y locales
RUN localedef -c -f UTF-8 -i en_US en_US.utf8
ENV LC_ALL en_US.utf8

# 安装基础软件
RUN apt-get update && apt-get install -y vim wget curl telnet inetutils-ping libnet-ifconfig-wrapper-perl \
    lsof

# APT配置文件覆盖，防止软件自动更新
ADD ./dockerfiles/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades


###############################################################################
#                                   START
###############################################################################

# CMD xxx
