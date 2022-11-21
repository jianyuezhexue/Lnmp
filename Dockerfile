FROM php:7.3.33-fpm-alpine3.14
RUN set -eux \ 
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk add --no-cache --virtual .build-deps autoconf gcc g++ make\
    && apk add --no-cache libzip-dev libpng-dev \
    && pecl install igbinary \
    && pecl install redis \
    && docker-php-ext-enable redis igbinary \
    && docker-php-ext-install gd bcmath zip mysqli pdo_mysql \
    && rm -rf /tmp/pear \
    && apk del .build-deps