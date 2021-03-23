FROM php:7.1-apache

ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOG_DIR /var/log/apache2

# Install updates and dependencies
RUN apt update && \
    apt -y upgrade && \
    apt install -y libmcrypt-dev libssl-dev libxml2-dev libmemcached-dev zlib1g-dev libcurl4-openssl-dev libpcre3-dev

# Update pear/pecl
RUN pear upgrade --force --alldeps http://pear.php.net/get/PEAR-1.10.1
RUN pear upgrade --force --alldeps http://pear.php.net/get/PEAR-1.10.12

# Install php extensions
RUN /usr/local/bin/docker-php-ext-install opcache mysqli mbstring ftp sockets soap && \
    /usr/local/bin/docker-php-ext-enable opcache mysqli mbstring ftp sockets soap

# Install PECL extensions
RUN pecl install igbinary-2.0.8 && \
    /usr/local/bin/docker-php-ext-enable igbinary && \
    pecl install --configureoptions 'enable-redis-igbinary="yes"' redis-5.1.1 && \
    /usr/local/bin/docker-php-ext-enable redis;

# Configure Apache modules
RUN ln -s /etc/apache2/mods-available/speling.* /etc/apache2/mods-enabled/ && \
    ln -s /etc/apache2/mods-available/proxy.* /etc/apache2/mods-enabled/ && \
    ln -s /etc/apache2/mods-available/proxy_http.* /etc/apache2/mods-enabled/ && \
    ln -s /etc/apache2/mods-available/proxy_ftp.* /etc/apache2/mods-enabled/ && \
    ln -s /etc/apache2/mods-available/rewrite.* /etc/apache2/mods-enabled/ && \
    ln -s /etc/apache2/mods-available/ssl.* /etc/apache2/mods-enabled/ && \
    ln -s /etc/apache2/mods-available/socache_shmcb.* /etc/apache2/mods-enabled/ && \
    ln -s /etc/apache2/mods-available/expires.* /etc/apache2/mods-enabled/;

RUN sed -ri -e 's!80!8080!g' /etc/apache2/ports.conf

# Copy code
COPY . /var/www/html

# Move php.ini file to where it needs to go
RUN mv php.ini /usr/local/etc/php/php.ini

# Configure apache with configurations for sub projects
RUN mv /var/www/html/sites-available/* /etc/apache2/sites-available && \
    ln -s /etc/apache2/sites-available/default.conf /etc/apache2/sites-enabled/
