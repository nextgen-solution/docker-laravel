FROM nextgensolution/php-fpm-nginx:1.16

COPY config/supervisor/supervisor.d/horizon.stub /etc/supervisor.d/horizon.stub
COPY config/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
