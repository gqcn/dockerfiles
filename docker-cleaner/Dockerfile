# loads/docker-cleaner
FROM loads/ubuntu:16.04

LABEL maintainer="john@johng.cn"

###############################################################################
#                                INSTALLATION
###############################################################################

# 安装必要的软件
RUN apt-get install -y libnet-ifconfig-wrapper-perl rsyslog libltdl7

# 添加默认的定时任务配置
ADD ./dockerfiles/crontab /etc/cron.d/crontab

# 记录crontab的运行日志
ADD ./dockerfiles/rsyslog.conf /etc/rsyslog.d/50-default.conf

# 配置管理中心更新脚本、入口Shell添加
ADD ./dockerfiles/*.sh /bin/
RUN chmod +x /bin/*.sh

###############################################################################
#                                   START
###############################################################################

CMD serve.sh
