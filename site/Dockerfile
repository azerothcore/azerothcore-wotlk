FROM php:8.2-apache

# Needed to compile GMP and connect to MySQL
RUN apt-get update \
 && apt-get install -y --no-install-recommends libgmp-dev \
 && docker-php-ext-install gmp pdo pdo_mysql \
 && rm -rf /var/lib/apt/lists/*

# Optional small hardening
RUN a2enmod headers && \
    printf "ServerTokens Prod\nServerSignature Off\n" > /etc/apache2/conf-available/hardening.conf && \
    a2enconf hardening

COPY . /var/www/html/
