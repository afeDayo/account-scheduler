# Start from official PHP image
FROM php:8.1-fpm

# Install system packages needed
RUN apt-get update && apt-get install -y \
    git zip unzip libpng-dev libonig-dev libxml2-dev libzip-dev \
    nodejs npm \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set the working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

# Install backend and frontend dependencies, build frontend
RUN composer install --no-dev --optimize-autoloader \
    && npm install \
    && npm run build

# Expose port
EXPOSE 10000

# Start Laravel server
CMD php artisan migrate --force && php artisan config:cache && php artisan serve --host=0.0.0.0 --port=10000
