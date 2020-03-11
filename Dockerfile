FROM nextgensolution/php-fpm-nginx:latest

COPY config/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
