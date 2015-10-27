FROM bahmni/apache:latest

ADD 001_submitmail.conf /etc/httpd/conf.d/

RUN yum -y install epel-release
RUN  yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum  -y install \
	vim-enhanced \
	gcc \
	gcc-c++ \
	autoconf \
	automake \
	libXpm \
	libzip \
	t1lib \
	libc-client \
	libc-client-devel \
	libmcrypt \
	libxslt-devel \
	libcurl-devel \
	libtool-ltdl \
	recode \
	libtidy \
	pcre-devel \
	dejavu-sans-fonts \
	httpd-devel \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all

RUN yum --enablerepo=remi -y install gd-last php-pear
RUN yum --enablerepo=remi-php56 --disablerepo=base,updates -y install \
	php php-devel \
	php-bcmath \
	php-cli \
	php-common \
	php-gd \
	php-imap \
	php-mbstring \
	php-mcrypt \
	php-mysql \
	php-pdo \
	php-pear \
	php-pecl-xdebug \
	php-php-gettext \
	php-process \
	php-recode \
	php-soap \
	php-tcpdf \
	php-tcpdf-dejavu-sans-fonts \
	php-tidy \
	php-xml \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all
		


EXPOSE 80 443
CMD ["httpd-foreground"]