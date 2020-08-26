FROM centos/nodejs-8-centos7:latest
MAINTAINER <04neha.singh@gmail.com>

USER root

#Install all needed packages and python modules
RUN yum install epel-release -y && \
    yum -y update && \
    yum -y install supervisor && \
    yum install -y net-tools \
    wget \
    curl \
    unzip && \
    yum -y install awscli --skip-broken && \
    yum -y autoremove && \
    yum -y clean all && \
    yum clean metadata

#Upgrade NPM to latest
RUN npm install -g npm

#Install java and Latest Firefox, Google Chrome, XVFB and JRE installs
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
    yum -y install google-chrome-stable_current_x86_64.rpm &&\
    yum -y install java-1.8.0-openjdk \
    firefox \
    xorg-x11-server-Xvfb \
    yum -y clean all &&\
    yum clean metadata

# Install Protractor
RUN npm install -g protractor 

ENV JAVA_HOME="/usr/lib/jvm/jre-1.8.0"
RUN export JAVA_HOME

RUN yum -y clean all && \
    yum clean metadata

#Update webdriver-manager
RUN webdriver-manager clean && webdriver-manager update

#check framework and modules version
RUN node -v 
RUN npm -v 
RUN protractor --version 
RUN webdriver-manager version
RUN java -version



