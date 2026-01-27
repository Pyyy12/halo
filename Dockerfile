# Gunakan versi PHP yang lebih modern (disarankan 8.1 atau 8.2 untuk Laravel terbaru)
FROM php:8.2-cli

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libpq-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-install gd pdo pdo_pgsql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 1. INSTALL COMPOSER (Penting agar folder 'vendor' bisa dibuat)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

# 2. COPY SOURCE CODE
COPY . .

# 3. JALANKAN COMPOSER INSTALL
# Ini akan membuat folder vendor/autoload.php yang hilang tadi
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Set permissions
RUN chmod -R 775 storage bootstrap/cache

# Gunakan port yang disediakan Railway secara dinamis
EXPOSE 8080

# Jalankan server
CMD php -S 0.0.0.0:8080 -t public