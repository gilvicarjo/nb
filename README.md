# nb

## The Project

This repo has been created to host a business case and its resolution for a DevOps engineer position at Neobrain.

## The Tech Stack

Basically the technical stack for this project is based on the following ones:
- Kubernetes
- Azure (GCP/OVH)
- Helm
- Git
- Terraform

## Create Azure Account 

The very first step is to create an Azure account after this you will have a Subscription ID.

## Create a Git Repository

When creating the Git repository, you will need to create a SSH Key Pair

```markdown
 ssh-keygen -b 4096 -t rsa
```

After creating it, it's supposed to set the right permissions to this key
```markdown
 chmod 0400 /path/.ssh/key.pub
```

Then, add it as a default identifier
```markdown
 ssh-add /path/.ssh/key.pub
```

Next, you can validate the git SSH connection
```markdown
 ssh -T git@github.com
```

## Install Azure CLI
```markdown
brew update
brew install azure-cli
az --version
```

## Install Terraform
```markdown
brew update
brew install terraform
```

## Install kubectl
```markdown
brew update
brew install kubectl
```
## Setup kubeconfig
```markdown
echo "" > ~/.kube/config
az aks get-credentials --resource-group $(terraform output -raw resource_group_name) --name $(terraform output -raw kubernetes_cluster_name)
```

## Setup Helm
```markdown
brew update
brew install helm
```

## Create Observability Namespace
```markdown
kubectl create ns observability
```

## Setup Loki
Get inside Loki Helm Chart folder
```markdown
helm dependency build
helm upgrade --install loki . -n observability
```
Loki can now be added as a datasource in Grafana.

Get inside Tempo Helm Chart folder
```markdown
helm upgrade --install tempo . -n observability
```

## Setup Prometheus and Grafana
Get inside kube-prometheus-stack Helm Chart folder
Modify the Values.yaml to add Loki as a datasource
```markdown
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install my-grafana-stack prometheus-community/kube-prometheus-stack -n observability --values values.yaml
kubectl --namespace observability get pods -l "release=my-grafana-stack"
helm list -A
kubectl get pods -n observability
```
Grafana and Prometheus are deployed :)

## Logging into Prometheus
```markdown
kubectl get svc -n observability
kubectl port-forward svc/my-grafana-stack-kube-prom-prometheus 9090:9090 -n observability
```

## Logging into Grafana
```markdown
kubectl get svc -n observability
kubectl port-forward svc/my-grafana-stack 3000:80 -n observability
```
The default login is: admin : prom-operator

If you click on Dashboard, you will see that the Helm chart has installed pre-configured dashboards.

## Access to Loki
If you now go to Data Sources, you will find the data sources for Loki
