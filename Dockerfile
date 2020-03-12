FROM nextgensolution/php-fpm-nginx:1.16

COPY config/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
