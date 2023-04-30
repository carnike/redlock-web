# Base image
FROM php:8.1-apache

# Copy web content
COPY src/ /var/www/html/

# Copy SQL backup
COPY redlock-db.sql /docker-entrypoint-initdb.d/

# Set ownership and permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R o-rwx /var/www/html

# Install MySQL client
RUN apt-get update && \
    apt-get install -y default-mysql-client

# Configure PHP
RUN docker-php-ext-install mysqli && \
    docker-php-ext-enable mysqli

# Expose ports
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
