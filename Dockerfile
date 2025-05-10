# ───── STAGE 1: Install PHP dependencies ─────
FROM php:8.1-fpm-alpine AS php

# system deps for PHP extensions
RUN apk add --no-cache \
        git \
        unzip \
        oniguruma-dev \
        libxml2-dev \
        bash \
    && docker-php-ext-install pdo pdo_mysql mbstring xml

WORKDIR /srv/app

# copy only composer metadata, install prod deps
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-progress --no-scripts

# ───── STAGE 2: Build your Vue (Vite) frontend ─────
FROM node:18-alpine AS node

WORKDIR /srv/app
# copy package definition & lockfile
COPY package.json package-lock.json vite.config.js tailwind.config.js ./
# install JS deps
RUN npm ci
# copy just the assets we need to build
COPY resources/js resources/css resources/views .vitepress ./
# build to public/build
RUN npm run build

# ───── STAGE 3: Final image ─────
FROM php:8.1-fpm-alpine

# bring in PHP extensions again
RUN apk add --no-cache oniguruma-dev libxml2-dev bash \
    && docker-php-ext-install pdo pdo_mysql mbstring xml

WORKDIR /srv/app

# copy vendor from php stage
COPY --from=php /srv/app/vendor vendor
# copy built frontend
COPY --from=node /srv/app/public public
# copy the rest of your app
COPY . .

# Ensure storage/logs is writable
RUN chown -R www-data:www-data storage bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]
