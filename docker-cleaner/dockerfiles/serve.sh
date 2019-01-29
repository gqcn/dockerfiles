#!/bin/bash
if [ ! -e /usr/bin/docker ]; then
	echo "cannot find docker binary: /usr/bin/docker"
    exit 1
fi

if [ ! -e /var/run/docker.sock ]; then
	echo "cannot find docker service: /var/run/docker.sock"
    exit 1
fi

# 启动rsyslog记录系统日志，主要是crontab的日志
service rsyslog start

# 更新crontab脚本
if [ "$CRONTAB" != "" ]; then
    echo -e "$CRONTAB\n" > /etc/cron.d/crontab
fi

# 前台运行crontab，定时任务统一配置到 /etc/crontab 文件下，便于管理
cron -f >> /var/cron-stdout.log
