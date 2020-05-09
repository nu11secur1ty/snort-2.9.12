# Snort 
FROM centos:7

MAINTAINER Ventsislav Varbanovski <penetrateoffensive@gmail.com>

RUN yum update -y 
RUN yum upgrade -y

RUN yum install -y gcc \
    flex \
    bison \
    zlib \
    libpcap \
    pcre \
    libdnet \
    tcpdump

# Packages
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y libnghttp2

# Install
RUN yum install https://www.snort.org/downloads/snort/daq-2.0.6-1.centos7.x86_64.rpm
RUN yum install https://www.snort.org/downloads/snort/snort-2.9.12-1.centos7.x86_64.rpm
