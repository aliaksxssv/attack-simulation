## Attack Simulation

### Add Helm repo
``` bash
$ helm repo add aliaksxssv https://aliaksxssv.github.io/attack-simulation/
$ helm repo update aliaksxssv
``` 

### Customize values for chart
``` bash
$ wget https://github.com/aliaksxssv/attack-simulation/blob/main/helm/values.yaml
``` 

### Install Helm chart
``` bash
$ helm install attack-simulation aliaksxssv/attack-simulation -f values.yaml
``` 
