# loads/php:7.2
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
    && apt-get install -y php-pear php-mongo php-mongodb php7.2 php7.2-cli php7.2-common php7.2-fpm php7.2-dev \
       php7.2-bcmath php7.2-xml php7.2-mbstring php7.2-soap php7.2-zip php7.2-curl php7.2-gd php7.2-mysql php7.2-redis \
       php7.2-xmlrpc php7.2-sqlite3 libpcre3 libpcre3-dev zlib1g-dev \
       php-imagick 

RUN rm /usr/bin/php && ln -s /usr/bin/php7.2 /usr/bin/php && pecl install gRPC gearman

# mcrypt安装
RUN apt-get install -y libmcrypt-dev && pecl install channel://pecl.php.net/mcrypt-1.0.1

# swoole编译安装
RUN cd /root && wget http://pecl.php.net/get/swoole-1.10.4.tgz && tar -xvf swoole-1.10.4.tgz
RUN cd /root/swoole-1.10.4 && phpize7.2 && ./configure --enable-openssl && make && make install

RUN rm /root/swoole-1.10.4.tgz /root/swoole-1.10.4 -fr
RUN mkdir /run/php && apt-get clean

ADD ./dockerfiles/php7.2-cli.ini /etc/php/7.2/cli/php.ini
ADD ./dockerfiles/php7.2-fpm.ini /etc/php/7.2/fpm/php.ini

# APT配置文件覆盖，防止软件自动更新
ADD ./dockerfiles/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades

###############################################################################
#                                   START
###############################################################################

# CMD service php7.2-fpm start && service nginx start
