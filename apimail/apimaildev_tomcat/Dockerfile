FROM nimmis/java-centos:oracle-8-jdk

RUN useradd -m -s /bin/sh tomcat

RUN yum -y update
RUN yum install -y tar wget  \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all
	
RUN cd /tmp     && \
    wget http://ftp.riken.jp/net/apache/tomcat/tomcat-8/v8.0.28/bin/apache-tomcat-8.0.28.tar.gz && \
    tar zxvf apache-tomcat-8.0.28.tar.gz  && \
    rm -rf apache-tomcat-8.0.28.tar.gz  && \
    mv apache-tomcat-8.0.28 tomcat8  && \
    mv tomcat8 /usr/share/  && \
    yum clean all

ADD server.xml /usr/share/tomcat8/conf/server.xml
ADD tomcat-users.xml /usr/share/tomcat8/conf/tomcat-users.xml
ADD context.xml /usr/share/tomcat8/conf/context.xml

RUN useradd -m -s /bin/bash yoyogi
RUN echo 'yoyogi:password' | chpasswd
RUN usermod -G yoyogi,wheel yoyogi
#RUN echo 'yoyogi ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/yoyogi
USER yoyogi
ENV HOME /home/yoyogi

RUN mkdir ~/batch

USER root
VOLUME /home/yoyogi/batch

RUN mkdir /usr/share/tomcat8/webapps/v1
RUN mkdir /usr/share/tomcat8/webapps/v2
RUN mkdir /usr/share/tomcat8/webapps/members
RUN mkdir /usr/share/tomcat8/webapps/gt
VOLUME /usr/share/tomcat8/webapps/v1
VOLUME /usr/share/tomcat8/webapps/v2
VOLUME /usr/share/tomcat8/webapps/members
VOLUME /usr/share/tomcat8/webapps/gt

# タイムゾーン/ロケールの設定
RUN yum reinstall -y glibc-common && yum clean all
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Japan /etc/localtime

EXPOSE 22 8009
ENV CATALINA_HOME /usr/share/tomcat8
CMD exec ${CATALINA_HOME}/bin/catalina.sh run