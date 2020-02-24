FROM php:7.3.6-fpm-alpine3.9

WORKDIR /var/www

RUN apk add bash mysql-client openssl && \
    docker-php-ext-install pdo pdo_mysql && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Incluir vendor, .env e outros na imagem
# (descomentar e rodar "docker build -t dhoialmeida/laravel-app .")
# COPY . /var/www
# RUN composer install && \
#    cp .env.example .env && \
#    php artisan key:generate && \
#    php artisan config:cache

EXPOSE 9000
ENTRYPOINT ["php-fpm"]
