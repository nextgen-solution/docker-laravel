FROM nextgensolution/php-fpm-nginx:1.16

COPY config/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY config/supervisor/supervisor.d/horizon.stub /etc/supervisor.d/horizon.stub
COPY bin/docker-laravel-schedule-enable /usr/local/bin/docker-laravel-schedule-enable

RUN chmod +x /usr/local/bin/docker-laravel-schedule-enable
