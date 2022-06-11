FROM jenkins/jenkins:2.354-alpine

ARG jenkins_admin_user
ARG jenkins_admin_password

ENV JENKINS_USER=admin
ENV JENKINS_PASS=admin

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
ENV JENKINS_HOME /var/jenkins_home

USER root
RUN apk add \
  shadow \
  maven \
  openjdk8-jre \
  git \
  docker \
  sudo \
  make \
  jq

COPY jenkins-plugins.txt /usr/share/jenkins/plugins.txt
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt
