# loads/devops:1.0
FROM ubuntu:22.04

LABEL maintainer="john@johng.cn"

###############################################################################
#                                INSTALLATION
###############################################################################

ADD ./dockerfiles/sources.list /etc/apt/sources.list

RUN apt-get update

# 设置系统时区 - +8时区
RUN apt-get install -y tzdata ca-certificates bash
RUN rm -rf /etc/localtime && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone

# 安装mysql, mysqldump
RUN apt-get install -y mysql-client

# 安装ssh sshpass
RUN apt-get install -y sshpass openssh-client

# 安装常用工具
RUN apt-get install -y vim curl wget telnet iputils-ping lsof strace

# 解决vim乱码问题
RUN echo "set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936" >> /root/.vimrc
RUN echo "set termencoding=utf-8" >> /root/.vimrc
RUN echo "set encoding=utf-8" >> /root/.vimrc

# 设置SSH不验证HostKey，防止出现错误：Host key verification failed.
RUN mkdir /root/.ssh/
RUN echo "StrictHostKeyChecking no"        >> /root/.ssh/config
RUN echo "UserKnownHostsFile    /dev/null" >> /root/.ssh/config

# APT配置文件覆盖，防止软件自动更新
ADD ./dockerfiles/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades

###############################################################################
#                                   START
###############################################################################
