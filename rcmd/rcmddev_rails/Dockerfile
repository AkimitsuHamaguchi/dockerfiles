FROM centos:centos7

RUN yum -y update

# OpenSSH サーバをインストールする
RUN yum -y install openssh-server \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all


# root でログインできるようにする
RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

# root のパスワードを 'root' にする
RUN echo 'root:root' | chpasswd

# 使わないにしてもここに公開鍵を登録しておかないとログインできない
RUN ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key


RUN yum -y install gcc gcc-c++ git rsync tar openssl openssl-devel readline-devel  bzip2 bzip2-devel  zlib-devel curl-devel yaml-devel libyaml-devel libxml2 libxml2-devel libxslt libxslt-devel libffi-devel gdbm-devel tk tk-devel tcl tcl-devel patch which sqlite-devel wget openssh-server mysql mysql-devel \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all


# rbenv
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN chmod +x /etc/profile.d/rbenv.sh

# Ruby
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
RUN bash -lc 'CONFIGURE_OPTS="--disable-install-rdoc" MAKE_OPTS="-j4" rbenv install -v 2.3.0'
RUN bash -lc 'rbenv rehash'
RUN bash -lc 'rbenv global 2.3.0'
RUN bash -lc 'ruby -v'


# Rails
RUN bash -lc 'gem update --system'
RUN bash -lc 'gem install bundler --no-ri --no-rdoc'
RUN bash -lc 'rbenv rehash'

# PhantomJS
RUN yum install -y fontconfig freetype freetype-devel fontconfig-devel libstdc++ \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all

RUN mkdir -p /opt/phantomjs/
RUN curl -fsSL https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 -o phantomjs.tar.bz2
RUN tar -xvf phantomjs.tar.bz2 -C /opt/phantomjs
RUN rm phantomjs.tar.bz2
ENV PATH $PATH:/opt/phantomjs/phantomjs-2.1.1-linux-x86_64/bin/
RUN ln -s /opt/phantomjs/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

# Postfix
RUN yum install -y postfix cyrus-sasl-plain cyrus-sasl-md5 \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all
	
	
RUN useradd -m -s /bin/bash recommend
RUN echo 'recommend:password' | chpasswd
RUN usermod -G recommend,wheel recommend
#RUN echo 'recommend ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/recommend
USER recommend
ENV HOME /home/recommend

RUN mkdir ~/workspace

USER root
VOLUME /home/recommend/workspace


RUN bash -lc 'chown -R  recommend:root /usr/local/rbenv/'

# タイムゾーン/ロケールの設定
RUN yum reinstall -y glibc-common && yum clean all
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Japan /etc/localtime

EXPOSE 22 3000 9000 25
CMD ["/usr/sbin/sshd", "-D"]