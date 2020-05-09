# snort
FROM ubuntu:20.04
MAINTAINER V.Varbanovski <penetrateoffensive@gmail.com>

RUN apt update -y
RUN apr upgrade -y
RUN apt install snort -y
