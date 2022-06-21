# loads/backuper:1.0
FROM ubuntu:22.04

LABEL maintainer="john@johng.cn"

###############################################################################
#                                INSTALLATION
###############################################################################

RUN apt-get update

# 安装mysql, mysqldump
RUN apt-get install -y mysql-client

# 安装rsync
RUN apt-get install -y rsync

# 安装ssh sshpass
RUN apt-get install -y sshpass openssh-client

###############################################################################
#                                   START
###############################################################################
