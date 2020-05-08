# Snort 
FROM ubuntu:18.04

MAINTAINER Ventsislav Varbanovski <penetrateoffensive@gmail.com>

RUN apt update && apt upgrade \
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

RUN ldconfig

ENV DAQ_VERSION 2.0.6
RUN wget https://www.snort.org/downloads/archive/snort/daq-${DAQ_VERSION}.tar.gz \
    && tar xvfz daq-${DAQ_VERSION}.tar.gz \
    && cd daq-${DAQ_VERSION} \
    && ./configure; make; make install

ENV SNORT_VERSION 2.9.12
RUN wget https://www.snort.org/downloads/archive/snort/snort-${SNORT_VERSION}.tar.gz \
    && tar xvfz snort-${SNORT_VERSION}.tar.gz \
    && cd snort-${SNORT_VERSION} \
    && ./configure --enable-sourcefire; make; make install

# Configuring Snort to run in NIDS mode
RUN ldconfig
RUN ln -s /usr/local/bin/snort /usr/sbin/snort
RUN groupadd snort
RUN useradd snort -r -s /sbin/nologin -c SNORT_IDS -g snort

# Rules
RUN mkdir -p /etc/snort/rules
RUN mkdir /var/log/snort
RUN mkdir /usr/local/lib/snort_dynamicrules

# Permit
RUN chmod -R 5775 /etc/snort
RUN chmod -R 5775 /var/log/snort
RUN chmod -R 5775 /usr/local/lib/snort_dynamicrules
RUN chown -R snort:snort /etc/snort
RUN chown -R snort:snort /var/log/snort
RUN chown -R snort:snort /usr/local/lib/snort_dynamicrules

# Create rules
RUN touch /etc/snort/rules/white_list.rules
RUN touch /etc/snort/rules/black_list.rules
RUN touch /etc/snort/rules/local.rules

RUN cp ~/snort_src/snort-2.9.12/etc/*.conf* /etc/snort
RUN cp ~/snort_src/snort-2.9.12/etc/*.map /etc/snort

# community rules
RUN


 
# Clean up APT when done.
RUN apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    /opt/snort-${SNORT_VERSION}.tar.gz /opt/daq-${DAQ_VERSION}.tar.gz


ENV NETWORK_INTERFACE eth0
# Validate an installation
# snort -T -i eth0 -c /etc/snort/etc/snort.conf
CMD ["snort", "-T", "-i", "echo ${NETWORK_INTERFACE}", "-c", "/etc/snort/snort.conf"]
