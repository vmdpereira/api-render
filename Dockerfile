FROM php:8.3-cli

WORKDIR /var/www

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    && docker-php-ext-install \
        bcmath \
        intl \
        mbstring \
        pcntl \
        pdo \
        pdo_mysql \
        zip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY . .

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_MEMORY_LIMIT=-1

RUN php -r "file_exists('.env') || copy('.env.example', '.env');" \
    && composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist --no-progress \
    && php artisan key:generate --force --no-interaction \
    && touch database/database.sqlite \
    && php artisan migrate --force --no-interaction

CMD sh -c "php artisan serve --host 0.0.0.0 --port ${PORT:-8000}"