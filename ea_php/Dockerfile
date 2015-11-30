FROM php:5.6.15-apache

RUN apt-get -y update   --no-install-recommends 
RUN apt-get -y install git  --no-install-recommends 
RUN apt-get -y install vim   --no-install-recommends 
RUN apt-get -y install mysql-client  libfreetype6-dev libjpeg62-turbo-dev libpng12-dev libmcrypt-dev --no-install-recommends 
RUN apt-get -y install less   --no-install-recommends 
RUN apt-get -y install exim4   --no-install-recommends 
RUN apt-get -y install rsync  --no-install-recommends 
RUN apt-get -y install php5-dev  --no-install-recommends 

# タイムゾーンの設定
RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime


RUN sed -i -r "s/dc_eximconfig_configtype=.*/dc_eximconfig_configtype='internet'/g" /etc/exim4/update-exim4.conf.conf
RUN sed -i -r "s/dc_smarthost=.*/dc_smarthost=''/g" /etc/exim4/update-exim4.conf.conf
RUN sed -i -r "s/dc_hide_mailname=.*/dc_hide_mailname='true'/g" /etc/exim4/update-exim4.conf.conf
RUN rm /etc/exim4/passwd.client
RUN service exim4 restart

RUN docker-php-ext-install pdo pdo_mysql mysqli mbstring gd iconv mcrypt
RUN echo 'sendmail_path = "/usr/sbin/sendmail -t -i"' > /usr/local/etc/php/conf.d/php-sendmail.ini

RUN apt-get -y  install php5-xdebug --no-install-recommends 
ADD php-xdebug.ini /usr/local/etc/php/conf.d/


RUN apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* 

VOLUME /var/www/html

EXPOSE 80 443 9000
