FROM ubuntu:22.04

LABEL maintainer="David M. Ramos <DavidMRGaona@gmail.com>"

ARG PHP_UPSTREAM_CONTAINER=php-fpm
ARG PHP_UPSTREAM_PORT=9000
ARG PHP_UPSTREAM_TIMEOUT=60
ARG DOCUMENT_ROOT=/var/www/

ENV WEB_PHP_SOCKET=${PHP_UPSTREAM_CONTAINER}:${PHP_UPSTREAM_PORT}

ENV WEB_DOCUMENT_ROOT=${DOCUMENT_ROOT}

ENV WEB_PHP_TIMEOUT=${PHP_UPSTREAM_TIMEOUT}

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 \
    && rm -rf /var/lib/apt/lists/* \
    && rm /etc/apache2/sites-enabled/000-default.conf \
    && a2enmod rewrite proxy proxy_fcgi \
    && printf '<FilesMatch \\.php$>\n\tSetHandler "proxy:fcgi://%s"\n</FilesMatch>\n' "$WEB_PHP_SOCKET" > /etc/apache2/conf-available/php-fpm.conf \
    && a2enconf php-fpm

EXPOSE 80 443

WORKDIR /var/www/

COPY vhost.conf /etc/apache2/sites-enabled/vhost.conf
COPY sites/ /etc/apache2/sites-available/

CMD ["apachectl", "-D", "FOREGROUND"]
