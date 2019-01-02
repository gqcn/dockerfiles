# 这是PHP运行环境基础镜像，所以不需要设置CMD镜像入口指令。
# 应用镜像以此为基础创建，涉及到的配置如下：
# PHP-FPM:
#    /etc/php/5.6/fpm/
#    /etc/php/5.6/fpm/pool.d/www.conf
# Nginx:
#    /usr/local/openresty/nginx/conf
# loads/php:5.6
FROM loads/ubuntu:16.04

LABEL maintainer="john@johng.cn"

###############################################################################
#                                INSTALLATION
###############################################################################

# 临时删除，防止中途询问造成编译卡死
RUN rm /etc/apt/apt.conf.d/20auto-upgrades

# 安装PHP、PHP-FPM、PHP扩展、Nginx
RUN apt-get update && apt-get install -y vim wget curl gnupg2 libnet-ifconfig-wrapper-perl \
    && wget -qO - https://openresty.org/package/pubkey.gpg | apt-key add -

RUN apt-get update && apt-get -y install software-properties-common \
    && add-apt-repository -y "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main" \
    && add-apt-repository ppa:ondrej/php  \
    && apt-get update \
    && apt-get install -y openresty --no-install-recommends \
    && apt-get install -y libgearman-dev \
    && apt-get install -y php-pear php-mongo php-mongodb php5.6 php5.6-cli php5.6-common php5.6-fpm php5.6-dev \
       php5.6-bcmath php5.6-xml php5.6-mbstring php5.6-soap php5.6-zip php5.6-curl php5.6-gd php5.6-mcrypt php5.6-mysql php5.6-redis \
       php5.6-xmlrpc php5.6-sqlite3 libpcre3 libpcre3-dev zlib1g-dev \
       php-imagick 

RUN rm /usr/bin/php && ln -s /usr/bin/php5.6 /usr/bin/php && pecl install gRPC gearman

# swoole编译安装
RUN cd /root && wget http://pecl.php.net/get/swoole-1.10.4.tgz && tar -xvf swoole-1.10.4.tgz
RUN cd /root/swoole-1.10.4 && phpize5.6 && ./configure --enable-openssl && make && make install

RUN rm /root/swoole-1.10.4.tgz /root/swoole-1.10.4 -fr
RUN mkdir /run/php && apt-get clean

ADD ./dockerfiles/php5.6.36-cli.ini /etc/php/5.6/cli/php.ini
ADD ./dockerfiles/php5.6.36-fpm.ini /etc/php/5.6/fpm/php.ini

# APT配置文件覆盖，防止软件自动更新
ADD ./dockerfiles/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades

###############################################################################
#                                   START
###############################################################################

# CMD service php5.6-fpm start && service nginx start
