FROM php:7.4-fpm-alpine

RUN apk add \
 libzip-dev \
 zip \
 libpng-dev \
 $PHPIZE_DEPS \
 freetype-dev \
 libjpeg-turbo-dev \
 rabbitmq-c-dev \
 mariadb-client \
 openssl \
 acl \
 && pecl install xdebug apcu

# Install the PHP pdo_mysql extention
RUN docker-php-ext-install pdo_mysql

# Install the PHP gd library
RUN docker-php-ext-configure gd && docker-php-ext-install gd

RUN NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
 && docker-php-ext-install -j${NPROC} pdo_mysql gd zip bcmath sockets \
 && docker-php-ext-enable xdebug opcache apcu  \
 && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
COPY php.ini $PHP_INI_DIR/conf.d/custom.ini
WORKDIR /var/www/html
CMD ["php-fpm"]
