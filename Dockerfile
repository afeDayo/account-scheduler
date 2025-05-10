# Dockerfile
FROM php:8.1-fpm

# Install system extensions
RUN apt-get update && apt-get install -y \
    git zip unzip libpng-dev libonig-dev libxml2-dev libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working dir
WORKDIR /var/www/html

# Copy source
COPY . .

# Install PHP deps, build assets
RUN composer install --no-dev --optimize-autoloader \
    && apt-get install -y nodejs npm \
    && npm install \
    && npm run build

# Expose port and start PHP’s built-in server
EXPOSE 10000
CMD php artisan migrate --force && php artisan config:cache && php artisan serve --host=0.0.0.0 --port=10000
