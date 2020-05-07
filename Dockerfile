# Snort 2.9.16
# FROM ubuntu:18.04
FROM ubuntu:20.10

MAINTAINER Ventsislav Varbanovski <penetrateoffensive@gmail.com>

RUN apt update && \
    apt install -y \
    gcc \
    libpcre3-dev \
    zlib1g-dev \
    libluajit-5.1-dev \
    libpcap-dev \
    openssl \
    libssl-dev \
    libnghttp2-dev \
    libdumbnet-dev \
    bison \
    flex \
    libdnet


# Define working directory.
WORKDIR /opt

ENV DAQ_VERSION 2.0.7
RUN wget https://www.snort.org/downloads/archive/snort/daq-${DAQ_VERSION}.tar.gz \
    && tar xvfz daq-${DAQ_VERSION}.tar.gz \
    && cd daq-${DAQ_VERSION} \
    && ./configure; make; make install

# ENV SNORT_VERSION 2.9.12
# ENV SNORT_VERSION 2.9.15
ENV SNORT_VERSION 2.9.16
RUN wget https://www.snort.org/downloads/archive/snort/snort-${SNORT_VERSION}.tar.gz \
    && tar xvfz snort-${SNORT_VERSION}.tar.gz \
    && cd snort-${SNORT_VERSION} \
    && ./configure --enable-sourcefire; make; make install

# Clean up APT when done.
RUN apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    /opt/snort-${SNORT_VERSION}.tar.gz /opt/daq-${DAQ_VERSION}.tar.gz


ENV NETWORK_INTERFACE eth0
# Validate an installation
# snort -T -i eth0 -c /etc/snort/etc/snort.conf
# CMD ["snort", "-T", "-i", "echo ${NETWORK_INTERFACE}", "-c", "/etc/snort/etc/snort.conf"]
CMD ["snort", "-T", "-i", "echo ${NETWORK_INTERFACE}", "-c", "/etc/snort/snort.conf"]
