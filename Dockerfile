# Snort 
FROM centos:8

MAINTAINER Ventsislav Varbanovski <penetrateoffensive@gmail.com>

RUN yum -y install https://www.snort.org/downloads/snort/
RUN yum -y install https://www.snort.org/downloads/snort/snort-2.9.16-1.centos7.x86_64.rpm

