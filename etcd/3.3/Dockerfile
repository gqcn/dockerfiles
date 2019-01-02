# loads/etcd:3.3
FROM loads/alpine:3.8

LABEL maintainer="john@johng.cn"

###############################################################################
#                                INSTALLATION
###############################################################################

# 设置etcdctl默认环境变量
ENV ETCDCTL_API 3

# 添加执行文件
RUN cd /tmp && wget https://github.com/etcd-io/etcd/releases/download/v3.3.10/etcd-v3.3.10-linux-arm64.tar.gz \
    && tar -xvf etcd-v3.3.10-linux-arm64.tar.gz \
    && cp etcd-v3.3.10-linux-arm64/etcd* /bin/ && chmod 777 /bin/etcd* \
    && rm /tmp/etcd* -fr

###############################################################################
#                                   START
###############################################################################

CMD etcd
