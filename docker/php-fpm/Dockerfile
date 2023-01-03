FROM php:7.4-fpm
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
	&& docker-php-ext-install -j$(nproc) gd iconv pdo_mysql mysqli bcmath gettext zip intl \
	&& pecl install memcached \
	&& pecl install mongodb \
	&& echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini
COPY docker-app-entrypoint.sh /usr/local/bin
COPY docker-app-healthcheck.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-app-entrypoint.sh && chmod +x /usr/local/bin/docker-app-healthcheck.sh \
	&& sed -i -e "s/# \(.*ja_JP.UTF-8 UTF-8\)/\1/g" /etc/locale.gen && locale-gen
ENTRYPOINT ["docker-app-entrypoint.sh"]
CMD [ "php-fpm" ]