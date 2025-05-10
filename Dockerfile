# ───── STAGE 1: PHP dependencies ─────
FROM php:8.1-fpm-alpine AS php

WORKDIR /srv/app

# system deps + php extensions
RUN apk add --no-cache \
        bash \
        oniguruma-dev \
        libxml2-dev \
        zip \
        unzip \
    && docker-php-ext-install pdo_mysql mbstring xml

COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader --no-interaction

# ───── STAGE 2: Node / Build frontend ─────
FROM node:18-alpine AS node

WORKDIR /srv/app

# copy only what’s needed to install / build
COPY package.json package-lock.json vite.config.js tailwind.config.js postcss.config.js ./
RUN npm ci

COPY resources/js resources/css resources/views ./
RUN npm run build

# ───── STAGE 3: Final image ─────
FROM php:8.1-fpm-alpine

WORKDIR /srv/app

# copy vendor and built frontend from previous stages
COPY --from=php /srv/app/vendor vendor
COPY --from=node /srv/app/public public

# copy the rest of the Laravel app
COPY . .

# expose port (if you serve via artisan serve, otherwise omit)
EXPOSE 8000

# your production startup: serve the app
CMD [ "php", "artisan", "serve", "--host=0.0.0.0", "--port=8000" ]
