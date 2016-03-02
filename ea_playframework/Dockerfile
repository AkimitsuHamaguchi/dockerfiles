FROM centos:centos7

RUN yum -y update
RUN yum install -y tar wget unzip \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all
	
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

RUN useradd -m -s /bin/bash play
RUN echo 'play:password' | chpasswd
RUN usermod -G play,wheel play
#RUN echo 'play ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/play
USER play
ENV HOME /home/play
RUN mkdir ~/workspace

USER root
VOLUME /home/play/workspace
	
RUN cd /tmp     && \
    wget -qO jdk8.tar.gz --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u73-b02/jdk-8u73-linux-x64.tar.gz && \
    tar xzf jdk8.tar.gz   -C /opt && \
    mv /opt/jdk* /opt/java  && \
    rm /tmp/jdk8.tar.gz  && \
    update-alternatives --install /usr/bin/java java /opt/java/bin/java 100  && \
    update-alternatives --install /usr/bin/javac javac /opt/java/bin/javac 100

# Install Play Framework
ENV ACTIVATOR_VERSION 2.4
RUN cd /tmp     && \
        wget https://downloads.typesafe.com/typesafe-activator/1.3.7/typesafe-activator-1.3.7.zip  && \
        unzip typesafe-activator-1.3.7.zip -d /usr/local && \
        rm /tmp/typesafe-activator-1.3.7.zip  && \
        chmod a+x /usr/local/activator-dist-1.3.7/activator 
ENV PATH $PATH:/usr/local/activator-dist-1.3.7     

#  Install scala
ENV SCALA_VERSION 2.11.7
ENV SBT_VERSION 0.13.8

RUN cd /tmp     && \
       wget http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.tgz && \
      tar xzvf scala-$SCALA_VERSION.tgz && \
      mv scala-$SCALA_VERSION /usr/local/ && \
      wget "http://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/$SBT_VERSION/sbt-launch.jar" -P /usr/local/bin/&& \
      echo '#!/bin/bash' > /usr/local/bin/sbt && \
      echo 'SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled"' >> /usr/local/bin/sbt && \
      echo 'java $SBT_OPTS -jar `dirname $0`/sbt-launch.jar "$@"' >> /usr/local/bin/sbt && \
      chmod u+x /usr/local/bin/sbt && \
      echo 'Fetching all sbt related dependencies...' && \
      mkdir -p /tmp/sbt-dummy && \
      echo 'name := "DummyProject"' > /tmp/sbt-dummy/build.sbt && \
      echo 'version := "1.0"' >> /tmp/sbt-dummy/build.sbt && \
      echo "scalaVersion := \"$SCALA_VERSION\"" >> /tmp/sbt-dummy/build.sbt && \
      mkdir -p /tmp/sbt-dummy/src/main/scala && \
      echo 'object Main { def main(args: Array[String]) = println("Dummy") }' > /tmp/sbt-dummy/src/main/scala/Main.scala && \
      cd /tmp/sbt-dummy && sbt run && \
      rm -rf /tmp/*

RUN echo "PATH=$PATH:/usr/local/activator-dist-1.3.7:/usr/local//scala-$SCALA_VERSION/bin" >> /home/play/.bashrc && \
      source /home/play/.bashrc && \
      chown play.play /home/play/.bashrc

# タイムゾーン/ロケールの設定
RUN yum reinstall -y glibc-common && yum clean all
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Japan /etc/localtime


EXPOSE 22 9000 9999
CMD ["/usr/sbin/sshd", "-D"]