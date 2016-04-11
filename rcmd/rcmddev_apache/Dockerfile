FROM bahmni/apache:latest

# タイムゾーン/ロケールの設定
RUN yum reinstall -y glibc-common && yum clean all
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Japan /etc/localtime

ADD 001_rcmd.conf /etc/httpd/conf.d/
VOLUME /var/www/html

ENV RAILS_URI localhost
ENV RAILS_PORT 3000

EXPOSE 80 443
CMD ["httpd-foreground"]