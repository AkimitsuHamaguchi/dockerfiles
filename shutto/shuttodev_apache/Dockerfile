FROM bahmni/apache:latest

ADD 001_shutto.conf /etc/httpd/conf.d/
ENV RAILS_URI localhost
ENV RAILS_PORT 3000

EXPOSE 80 443
CMD ["httpd-foreground"]