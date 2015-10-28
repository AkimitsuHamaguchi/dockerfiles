FROM php:5.5.30-apache

RUN apt-get -y update   --no-install-recommends 
RUN apt-get -y install git  --no-install-recommends 
RUN apt-get -y install vim   --no-install-recommends 
RUN apt-get -y install mysql-client  --no-install-recommends 

RUN docker-php-ext-install pdo pdo_mysql

RUN apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* 

VOLUME /var/www/html

EXPOSE 80 443
