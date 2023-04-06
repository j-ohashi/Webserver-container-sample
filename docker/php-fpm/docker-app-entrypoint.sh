#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
        set -- php-fpm "$@"
fi

if [ ! -e '/tmp/checked' ]; then
    touch /tmp/checked
    # cd /var/www/apps/ && composer install
fi

docker-app-healthcheck.sh

exec "$@"