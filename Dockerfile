# snort
FROM ubuntu:20.04
MAINTAINER V.Varbanovski <penetrateoffensive@gmail.com>

RUN apt update -y
RUN apt upgrade -y
RUN apt install snort -y
