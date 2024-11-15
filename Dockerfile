FROM php:8.2.12-apache

# Actualizar y instalar paquetes necesarios
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libsodium-dev \
    zip \
    unzip

# Limpiar caché de apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar extensiones PHP necesarias
RUN docker-php-ext-install pdo_mysql mysqli mbstring exif pcntl bcmath gd zip sodium

# Copiar el contenido de la aplicación al directorio web de Apache
COPY . /var/www/html

# Configurar permisos
RUN chown -R www-data:www-data /var/www/html

# Habilitar el módulo rewrite de Apache
RUN a2enmod rewrite

# Reiniciar Apache para aplicar cambios
CMD ["apache2-foreground"]