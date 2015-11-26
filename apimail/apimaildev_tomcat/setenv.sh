#! /bin/sh

###export JAVA_HOME=/usr
export JRE_HOME=/usr
export JAVA_OPTS="-Dfile.encoding=UTF-8 \
  -Dnet.sf.ehcache.skipUpdateCheck=true \
  -XX:+UseConcMarkSweepGC \
  -XX:+CMSClassUnloadingEnabled \
  -XX:+UseParNewGC \
  -Xms512m -Xmx512m"
export CATALINA_OPTS=""
export PATH=$JAVA_HOME/bin:$PATH
TOMCAT_HOME=/usr/share/tomcat8
TOMCAT_USER=tomcat
