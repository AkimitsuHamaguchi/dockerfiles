FROM php:5.5.30-apache

RUN apt-get update -y
RUN apt-get install git -y
RUN apt-get install vim -y
RUN docker-php-ext-install pdo pdo_mysql

VOLUME /var/www/html

EXPOSE 80 443
