## Attack Simulation

### Add Helm repo
$ helm repo add aliaksxssv https://aliaksxssv.github.io/attack-simulation/

### Customize values for chart
$ wget https://github.com/aliaksxssv/attack-simulation/blob/main/helm/values.yaml

### Install Helm chart
$ helm install attack-simulation aliaksxssv/attack-simulation -f values.yaml
