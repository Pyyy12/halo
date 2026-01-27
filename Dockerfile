# Gunakan PHP 7.4-cli agar kompatibel dengan library lama (dompdf/phpexcel)
FROM php:7.4-cli

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

# Copy composer dari image official
COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer

WORKDIR /app

# Copy source code
COPY . .

# Jalankan composer install dengan ignore platform reqs 
# Ini gunanya untuk memaksa install meskipun ada sedikit ketidakcocokan versi
RUN composer install --no-dev --optimize-autoloader --no-interaction --ignore-platform-reqs

# Set permissions
RUN chmod -R 775 storage bootstrap/cache

EXPOSE 8080

CMD php -S 0.0.0.0:8080 -t public