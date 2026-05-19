FROM php:8.2-cli-alpine

RUN apk add --no-cache \
    curl-dev \
    icu-dev \
    libxml2-dev \
    libzip-dev \
    oniguruma-dev \
    postgresql-dev \
    $PHPIZE_DEPS \
    && docker-php-ext-configure intl \
    && docker-php-ext-install \
        bcmath \
        curl \
        dom \
        intl \
        mbstring \
        opcache \
        pdo \
        pdo_pgsql \
        pgsql \
        xml \
        zip \
    && apk del $PHPIZE_DEPS

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
