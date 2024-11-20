FROM ubuntu:20.04

USER root

# install nc, netstat, etc
RUN apt update && apt install netcat-traditional net-tools vim curl libcap2-bin -y

# install gcc
RUN apt install gcc python3 -y

# install ping
RUN apt install iputils-ping

# copy script for technique simulation
COPY ./src/* /opt/attack_simulation/