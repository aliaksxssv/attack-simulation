## Attack Simulation

![Screenshot](./images/screenshot.png)

### Docker Images

Multi-platform Docker images are automatically built and pushed to Docker Hub:

- **ARM64**: `aliaksxssv/attack-simulation:arm64` (for M1/M2 Macs, ARM servers)
- **AMD64**: `aliaksxssv/attack-simulation:amd64` (for Intel/AMD systems)  
- **Latest**: `aliaksxssv/attack-simulation:latest` (multi-platform)

#### Quick Start with Docker

```bash
# Pull and run the latest image
docker pull aliaksxssv/attack-simulation:latest
docker run -it aliaksxssv/attack-simulation:latest

# Or run specific architecture
docker run -it aliaksxssv/attack-simulation:arm64   # ARM64
docker run -it aliaksxssv/attack-simulation:amd64   # AMD64
```

#### Building Locally

```bash
# Build for ARM64 (M1 Mac)
docker build --platform linux/arm64 -t aliaksxssv/attack-simulation:arm64 ./docker

# Build for AMD64 (Intel/AMD)
docker build --platform linux/amd64 -t aliaksxssv/attack-simulation:amd64 ./docker
```

### Helm Chart

The Helm chart automatically uses the latest multi-platform Docker image (`aliaksxssv/attack-simulation:latest`) which supports both AMD64 and ARM64 architectures.

#### Add Helm repo
```bash
helm repo add aliaksxssv https://aliaksxssv.github.io/attack-simulation/
helm repo update aliaksxssv
```

#### Customize values for chart

> **Heads up!** Pay attention to the "Secrets" sections. Don't use any credentials with sensitive permissions.

```bash
wget https://raw.githubusercontent.com/aliaksxssv/attack-simulation/refs/heads/main/helm/values.yaml
```

#### Install Helm chart
```bash
helm install attack-simulation aliaksxssv/attack-simulation -f values.yaml --namespace attack-simulation --create-namespace
```

#### Report submission

After all simulation scripts run, a single **plain-text report** (one file aggregating every script’s output, without ANSI codes) is generated. If the environment variable `ATTACK_SIM_API_TOKEN` is set, the report is also submitted to:

`POST https://dev.think-cnap.pages.dev/attack-simulation-report`

Set the token in your Helm values under `secrets.ATTACK_SIM_API_TOKEN` (or pass it as an env var when running the container). See [REPORT_FORMAT.md](./REPORT_FORMAT.md) for the report format.

#### Chart Features
- **Multi-platform support**: Automatically pulls the correct architecture for your nodes
- **CronJob scheduling**: Runs attack simulations on a configurable schedule
- **Security context**: Supports privileged mode for advanced attack techniques
- **Resource management**: Configurable CPU and memory limits 
