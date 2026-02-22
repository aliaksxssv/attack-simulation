## Attack Simulation

A Docker image that executes scripts simulating MITRE ATT&CK techniques and their impact within a Kubernetes cluster to test and validate security controls and detection mechanisms. 

![Screenshot](./images/screenshot.png)

### Helm chart installation

```bash
helm repo add aliaksxssv https://aliaksxssv.github.io/attack-simulation/
helm repo update aliaksxssv
```

Optional: download and edit [values.yaml](https://raw.githubusercontent.com/aliaksxssv/attack-simulation/refs/heads/main/helm/values.yaml) (e.g. secrets, resources).

```bash
helm install attack-simulation aliaksxssv/attack-simulation -f values.yaml --namespace attack-simulation --create-namespace
```
