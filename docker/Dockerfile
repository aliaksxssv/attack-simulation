FROM ubuntu:jammy

# install common tools
RUN apt update && apt install -y --no-install-recommends \
    vim unzip sudo libcap2-bin cron

# install networking/cloud tools
RUN apt update && apt install -y --no-install-recommends \
    netcat-traditional net-tools iperf3 dnsutils curl wget

# install gcc python
RUN apt update && apt install gcc gdb build-essential libc6-dev python3 -y --no-install-recommends

# install aws cli
RUN apt update && apt install -y --no-install-recommends \
    curl ca-certificates && \
    curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws/

# copy scripts to the image
COPY ./src/ /opt/mitre/ 

# compile malicious library
RUN gcc -shared -o "/opt/mitre/07 Defense Evasion/malicious.so" -fPIC "/opt/mitre/07 Defense Evasion/malicious.c"

# make script executable
RUN chmod +x /opt/mitre/simulate.sh

# clear apt cache
RUN rm -rf /var/lib/apt/lists/*