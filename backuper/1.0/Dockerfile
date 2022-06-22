# loads/backuper:1.0
FROM ubuntu:22.04

LABEL maintainer="john@johng.cn"

###############################################################################
#                                INSTALLATION
###############################################################################

RUN apt-get update

# 设置系统时区 - +8时区
RUN apt-get install -y tzdata ca-certificates bash
RUN rm -rf /etc/localtime && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone

# 安装mysql, mysqldump
RUN apt-get install -y mysql-client

# 安装rsync
RUN apt-get install -y rsync

# 安装ssh sshpass
RUN apt-get install -y sshpass openssh-client

# 安装定时任务
RUN apt-get install -y cron

# 设置SSH不验证HostKey，防止出现错误：Host key verification failed.
RUN mkdir /root/.ssh/
RUN echo "StrictHostKeyChecking no"        >> /root/.ssh/config
RUN echo "UserKnownHostsFile    /dev/null" >> /root/.ssh/config

###############################################################################
#                                   START
###############################################################################
