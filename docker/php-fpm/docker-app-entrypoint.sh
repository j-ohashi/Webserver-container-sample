#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
        set -- php-fpm "$@"
fi

if [ ! -e '/tmp/checked' ]; then
    touch /tmp/checked
    echo "first boot"
fi

docker-app-healthcheck.sh

exec "$@"