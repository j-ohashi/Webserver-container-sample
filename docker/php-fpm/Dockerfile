FROM php:8.3-fpm
RUN apt-get update && \
	apt-get install -y \
	git \
	unzip \
	libz-dev \
	aptitude \
	libpng-dev \
	mariadb-client \
	libmcrypt-dev \
	libmemcached-dev \
	libssl-dev \
	zlib1g-dev \
	libzip-dev \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libonig-dev \
	libicu-dev \
	openssl \
	procps \
	locales \

	&& docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd iconv pdo_mysql mysqli bcmath gettext zip \
	&& pecl install mongodb \
	&& echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini
RUN yes '' | pecl install -f memcached-3.2.0 \
	&& docker-php-ext-enable memcached
COPY docker-app-entrypoint.sh /usr/local/bin
COPY docker-app-healthcheck.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-app-entrypoint.sh && chmod +x /usr/local/bin/docker-app-healthcheck.sh \
	&& sed -i -e "s/# \(.*ja_JP.UTF-8 UTF-8\)/\1/g" /etc/locale.gen && locale-gen \
	&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php composer-setup.php \
	&& php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer
ENTRYPOINT ["docker-app-entrypoint.sh"]
CMD [ "php-fpm" ]