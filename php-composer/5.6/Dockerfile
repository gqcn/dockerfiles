# loads/php-composer:5.6
FROM loads/php:5.6

LABEL maintainer="john@johng.cn"

###############################################################################
#                                INSTALLATION
###############################################################################

# composer
RUN wget -O /bin/composer https://github.com/composer/composer/releases/download/1.6.3/composer.phar \
    && chmod +x /bin/composer

# git
RUN apt-get update && apt-get install -y git && apt-get clean


###############################################################################
#                                   START
###############################################################################


