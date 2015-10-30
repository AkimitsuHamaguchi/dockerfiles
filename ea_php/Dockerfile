FROM php:5.5.30-apache

RUN apt-get -y update   --no-install-recommends 
RUN apt-get -y install git  --no-install-recommends 
RUN apt-get -y install vim   --no-install-recommends 
RUN apt-get -y install mysql-client  libfreetype6-dev libjpeg62-turbo-dev libpng12-dev libmcrypt-dev --no-install-recommends 
RUN apt-get -y install less   --no-install-recommends 

# タイムゾーンの設定
RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime


RUN docker-php-ext-install pdo pdo_mysql mysqli mbstring gd iconv mcrypt

RUN apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* 

VOLUME /var/www/html

EXPOSE 80 443
