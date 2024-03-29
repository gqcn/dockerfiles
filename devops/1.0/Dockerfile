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

# 安装redis
RUN apt-get install -y redis

# 安装ssh sshpass
RUN apt-get install -y sshpass openssh-client

# 安装常用工具
RUN apt-get install -y vim curl wget telnet iputils-ping lsof strace

# 端口转发工具
RUN apt-get install -y ncat socat portmap

# grpc请求工具grpcurl
RUN cd /root && wget https://github.com/fullstorydev/grpcurl/releases/download/v1.8.7/grpcurl_1.8.7_linux_x86_64.tar.gz
RUN cd /root && tar -xvf grpcurl_1.8.7_linux_x86_64.tar.gz
RUN cd /root && mv grpcurl /usr/bin/
RUN cd /root && rm grpcurl_1.8.7_linux_x86_64.tar.gz

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
