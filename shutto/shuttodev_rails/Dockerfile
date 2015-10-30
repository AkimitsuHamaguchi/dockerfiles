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


RUN yum -y install gcc gcc-c++ git rsync tar openssl openssl-devel readline-devel  bzip2-devel  zlib-devel curl-devel yaml-devel libyaml-devel libxml2 libxml2-devel libxslt libxslt-devel libffi-devel gdbm-devel tk tk-devel tcl tcl-devel patch which sqlite-devel wget openssh-server mysql mysql-devel \
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
##RUN bash -lc 'CONFIGURE_OPTS="--disable-install-rdoc" MAKE_OPTS="-j4" rbenv install -v 2.2.0'
RUN bash -lc 'CONFIGURE_OPTS="--disable-install-rdoc" MAKE_OPTS="-j4" rbenv install -v 1.9.3-p551'
RUN bash -lc 'rbenv rehash'
RUN bash -lc 'rbenv global 1.9.3-p551'
RUN bash -lc 'ruby -v'


# Rails
RUN bash -lc 'gem update --system'
RUN bash -lc 'gem uninstall rake'
RUN bash -lc 'gem install rake -v '10.3.2' --no-ri --no-rdoc'
###RUN bash -lc 'gem install libv8 -v '3.16.14.3'  --no-ri --no-rdoc'
RUN bash -lc 'gem install bundler --no-ri --no-rdoc'
RUN bash -lc 'rbenv rehash'

# KyotoCabinet install
RUN cd /tmp     && \
    wget http://fallabs.com/kyotocabinet/pkg/kyotocabinet-1.2.76.tar.gz && \
    tar zxvf kyotocabinet-1.2.76.tar.gz  && \
    cd /tmp/kyotocabinet-1.2.76 && \
    ./configure && \
    make && \
     make install && \
     sh -c "echo /usr/local/lib > /etc/ld.so.conf.d/local.conf"  && \
    /sbin/ldconfig && \
    rm -rf /tmp/kyotocabinet-1.2.76*
    

# Kyoto Tycoon install
RUN yum -y install lua-devel make \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all

ADD ktdbext.h /tmp/
RUN cd /tmp     && \
    wget http://fallabs.com/kyototycoon/pkg/kyototycoon-0.9.56.tar.gz && \
    tar zxvf kyototycoon-0.9.56.tar.gz  && \
    cd /tmp/kyototycoon-0.9.56 && \
    ./configure && \
    cp -rf /tmp/ktdbext.h ./ && \
    make && \
    make install && \
    /sbin/ldconfig && \
    rm -rf /tmp/kyototycoon-0.9.56*
    
ADD ktservctl /usr/local/sbin/ 
RUN chmod 755 /usr/local/sbin/ktservctl

RUN useradd -m -s /bin/bash shutto
RUN echo 'shutto:password' | chpasswd
RUN usermod -G shutto,wheel shutto
#RUN echo 'shutto ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/shutto
USER shutto
ENV HOME /home/shutto

RUN mkdir ~/workspace

USER root
VOLUME /home/shutto/workspace


RUN bash -lc 'chown -R  shutto:root /usr/local/rbenv/'

# タイムゾーン/ロケールの設定
RUN yum reinstall -y glibc-common && yum clean all
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Japan /etc/localtime

EXPOSE 22 3000
CMD ["/usr/sbin/sshd", "-D"]