# loads/nginx-ingress:1.4.5-alpine3.9
FROM nginx/nginx-ingress:1.4.5-alpine

LABEL maintainer="john@johng.cn"

###############################################################################
#                                INSTALLATION
###############################################################################

# 使用国内alpine源
RUN echo http://mirrors.ustc.edu.cn/alpine/v3.9/main/ > /etc/apk/repositories

# 设置系统时区 - +8时区
RUN apk update && apk add tzdata ca-certificates bash
RUN rm -rf /etc/localtime && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone


###############################################################################
#                                   START
###############################################################################


