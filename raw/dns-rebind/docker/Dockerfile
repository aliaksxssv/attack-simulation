FROM ubuntu:20.04

USER root

# install nc, netstat
RUN apt update && apt install netcat-traditional net-tools vim curl -y

COPY ./src/* /opt/attack_simulation/