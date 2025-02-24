FROM ubuntu:jammy

# install tools
RUN apt update && apt install -y --no-install-recommends \
    dnsutils; \
    rm -rf /var/lib/apt/lists/*

# copy script to the image
COPY ./src/* /opt/scripts/ 

# make script executable
RUN chmod +x /opt/scripts/mitre_attack.sh