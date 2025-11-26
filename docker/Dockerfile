FROM ubuntu:jammy

# Declare build argument for multi-platform support
ARG TARGETPLATFORM

# install common tools
RUN apt update && apt install -y --no-install-recommends \
    vim unzip sudo libcap2-bin cron

# install networking/cloud tools
RUN apt update && apt install -y --no-install-recommends \
    netcat-traditional net-tools iperf3 dnsutils curl wget

# install gcc python
RUN apt update && apt install gcc gdb build-essential libc6-dev python3 -y --no-install-recommends

# install aws cli (architecture-aware using Docker Buildx TARGETPLATFORM)
RUN ARCH=$(echo ${TARGETPLATFORM} | cut -d'/' -f2) && \
    if [ "$ARCH" = "amd64" ]; then \
        AWS_CLI_ARCH="x86_64"; \
    elif [ "$ARCH" = "arm64" ]; then \
        AWS_CLI_ARCH="aarch64"; \
    else \
        echo "Unsupported architecture: $ARCH" && exit 1; \
    fi && \
    apt update && apt install -y --no-install-recommends \
    curl ca-certificates unzip && \
    curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_CLI_ARCH}.zip" -o "/tmp/awscliv2.zip" && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli && \
    rm -rf /tmp/awscliv2.zip /tmp/aws && \
    aws --version

# Disable AWS CLI pager (prevents "less" not found errors)
ENV AWS_PAGER=""

# install kubectl (architecture-aware using Docker Buildx TARGETPLATFORM)
RUN ARCH=$(echo ${TARGETPLATFORM} | cut -d'/' -f2) && \
    if [ "$ARCH" = "amd64" ]; then \
        KUBECTL_ARCH="amd64"; \
    elif [ "$ARCH" = "arm64" ]; then \
        KUBECTL_ARCH="arm64"; \
    else \
        echo "Unsupported architecture: $ARCH" && exit 1; \
    fi && \
    curl -fsSLo /usr/local/bin/kubectl "https://dl.k8s.io/release/v1.29.6/bin/linux/${KUBECTL_ARCH}/kubectl" && \
    chmod +x /usr/local/bin/kubectl && \
    kubectl version --client

# copy scripts to the image
COPY ./src/ /opt/mitre/ 

# compile malicious library
RUN gcc -shared -o "/opt/mitre/07 Defense Evasion/malicious.so" -fPIC "/opt/mitre/07 Defense Evasion/malicious.c"

# make script executable
RUN chmod +x /opt/mitre/simulate.sh

# clear apt cache
RUN rm -rf /var/lib/apt/lists/*