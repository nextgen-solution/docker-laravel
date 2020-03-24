#!/bin/sh
set -e

NGINX_WORKER_PROCESSES=${NGINX_WORKER_PROCESSES:-1}
NGINX_LISTEN_PORT=${NGINX_LISTEN_PORT:-80}

PHP_FPM_MAX_CHILDREN=${PHP_FPM_MAX_CHILDREN:-1}

LARAVEL_HORIZON_ENABLE=${LARAVEL_HORIZON_ENABLE:-false}
LARAVEL_SCHEDULE_ENABLE=${LARAVEL_SCHEDULE_ENABLE:-false}

sed -i "s/worker_processes auto/worker_processes $NGINX_WORKER_PROCESSES/g" /etc/nginx/nginx.conf
sed -i "s/80 default_server/$NGINX_LISTEN_PORT default_server/g" /etc/nginx/conf.d/default.conf

sed -i "s/pm.max_children = 16/pm.max_children = $PHP_FPM_MAX_CHILDREN/g" /usr/local/etc/php-fpm.d/zzz-docker.conf

if [ "$LARAVEL_HORIZON_ENABLE" = "true" ]; then
    cp -f /etc/supervisor.d/horizon.stub /etc/supervisor.d/horizon.ini
fi

if [ "$LARAVEL_SCHEDULE_ENABLE" = "true" ]; then
    count=`crontab -l | grep "php artisan schedule:run" | wc -l`

    if [ "$count" -le 0 ]; then
        (crontab -l; echo "* * * * * cd /var/www/html && php artisan schedule:run >> /dev/null 2>&1") | crontab -
        crond -L /dev/stdout
    fi
fi

exec "$@"
