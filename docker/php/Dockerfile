###############################################
# 1) build stage  (php + composer)
###############################################
FROM php:8.4-fpm-alpine AS build

# 拡張 & ツール
RUN apk add --no-cache icu-dev git bash mysql-client nginx supervisor \
 && docker-php-ext-install intl pdo_mysql opcache

# Composer
COPY --from=composer:2.8 /usr/bin/composer /usr/bin/composer

# 作業ディレクトリ
WORKDIR /var/www/html

# アプリ一式コピー (artisan 含む)
COPY backend .

# 依存インストール
RUN composer install --no-dev --prefer-dist --optimize-autoloader

###############################################
# 2) runtime stage (php-fpm + nginx + supervisor)
###############################################
FROM build AS runtime

# Nginx 設定
COPY docker/php/nginx.conf /etc/nginx/http.d/default.conf

# Supervisor 設定
RUN printf "[supervisord]\nnodaemon=true\n\
[program:php-fpm]\ncommand=docker-php-entrypoint php-fpm\n\
[program:nginx]\ncommand=nginx -g 'daemon off;'\n" \
> /etc/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]