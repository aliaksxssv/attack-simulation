## Attack Simulation

![Screenshot](./images/screenshot.png)

### Add Helm repo
``` bash
helm repo add aliaksxssv https://aliaksxssv.github.io/attack-simulation/
helm repo update aliaksxssv
``` 

### Customize values for chart

#### 🚨 Notice

> **Heads up!** Put you attention at least to the "Schedule" and "Secrets" sections. Don't use any credentials with sensitive permissions.


``` bash
wget https://github.com/aliaksxssv/attack-simulation/blob/main/helm/values.yaml
``` 

### Install Helm chart
``` bash
helm install attack-simulation aliaksxssv/attack-simulation -f values.yaml --namespace attack-simulation --create-namespace

``` 
