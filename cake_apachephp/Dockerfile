FROM gonzalomarcote/docker-apache-centos7:latest


ADD 001_default.conf /etc/httpd/conf.d/

RUN yum -y install epel-release
RUN  yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum  -y install \
	vim-enhanced \
	gcc \
	gcc-c++ \
	libaio \
	libaio-devel \
	passwd \
	wget \
	ntp \
	openssl \
	mod_ssl \
	openssh-server \
	openssl-devel \
	libssl-dev \
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
	&& rm -rf /var/cache/yum/* \
	&& yum clean all
	
RUN yum  -y install \
	mysql \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all

RUN yum --enablerepo=remi -y install gd-last php-pear
RUN yum --enablerepo=remi-php70 --disablerepo=base,updates -y install \
	php php-devel \
	php-bcmath \
	php-cli \
	php-common \
	php-gd \
	php-gmp \
	php-imap \
	php-mbstring \
	php-mcrypt \
	php-mysql \
	php-opcache \
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
		

# タイムゾーン/ロケールの設定
RUN yum reinstall -y glibc-common && yum clean all
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Japan /etc/localtime

EXPOSE 80 443
#CMD ["httpd-foreground"]
ENTRYPOINT [ "/usr/sbin/httpd","-k","start", "-D", "FOREGROUND" ]