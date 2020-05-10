# Snort 
FROM ubuntu:18.04
# FROM ubuntu:19.10

MAINTAINER Ventsislav Varbanovski <penetrateoffensive@gmail.com>

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y \
        gcc \
        net-tools \
        python-setuptools \
        python-pip \
        python-dev \
        wget \
        build-essential \
        bison \
        flex \
        libpcap-dev \
        libpcre3-dev \
        libdumbnet-dev \
        zlib1g-dev \
        iptables-dev \
        libnetfilter-queue1 \
        tcpdump \
        unzip \
        zlib1g-dev \
        libluajit-5.1-dev \  
        openssl \
        libssl-dev \
        libnghttp2-dev \
        bison \
        flex \
        libdnet \
        vim \
        make \
        cmake
    RUN pip install -U pip dpkt snortunsock

# Define working directory.
WORKDIR /opt

ENV DAQ_VERSION 2.0.7
RUN wget https://www.snort.org/downloads/archive/snort/daq-${DAQ_VERSION}.tar.gz 
RUN tar xvfz daq-${DAQ_VERSION}.tar.gz 
RUN cd daq-${DAQ_VERSION} && \
    ./configure 
RUN make  
RUN make install

ENV SNORT_VERSION 2.9.13
RUN wget https://www.snort.org/downloads/archive/snort/snort-${SNORT_VERSION}.tar.gz 
RUN tar -xvfz snort-${SNORT_VERSION}.tar.gz 
RUN cd snort-${SNORT_VERSION} && \
    ./configure --enable-sourcefire 
RUN make 
RUN make install

RUN ldconfig

# snortunsock
RUN wget --no-check-certificate https://github.com/nu11secur1ty/snort-2.9.12/raw/master/pireplay.zip 
RUN unzip pireplay.zip

# ENV SNORT_RULES_SNAPSHOT 2972
ADD mysnortrules /opt
RUN mkdir -p /var/log/snort 
RUN mkdir -p /usr/local/lib/snort_dynamicrules 
RUN mkdir -p /etc/snort 

    # mysnortrules rules
RUN cp -r /opt/rules /etc/snort/rules 
    
    # Due to empty folder so mkdir
RUN mkdir -p /etc/snort/preproc_rules 
RUN mkdir -p /etc/snort/so_rules 
RUN cp -r /opt/etc /etc/snort/etc 
RUN touch /etc/snort/rules/white_list.rules /etc/snort/rules/black_list.rules

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    /opt/snort-${SNORT_VERSION}.tar.gz /opt/daq-${DAQ_VERSION}.tar.gz


ENV NETWORK_INTERFACE eth0

# Validate an installation
# snort -T -i eth0 -c /etc/snort/etc/snort.conf
CMD ["snort", "-T", "-i", "echo ${NETWORK_INTERFACE}", "-c", "/etc/snort/etc/snort.conf"]
