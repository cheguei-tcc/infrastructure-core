# Kubernetes Only Once Manual Deployments

## AWS IAM

> We might need to override ROLES every apply/destroy of EKS infrastructure, retrieving from: `kubectl describe configmap aws-auth -n kube-system` or `terraform eks aws-auth output`

- kubectl apply -f aws-auth.yaml

## Nginx Ingress Controler

> TODO

## Metrics Server

- kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

This project automates all resources used by the cheguei project at cloud providers to provision and created a kubernetes cluster.

## Dashboard

- kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.1/aio/deploy/recommended.yaml

#### Authentication

- kubectl config set-context --current --namespace default
- kubectl create serviceaccount dashboard-admin-sa 
- kubectl create clusterrolebinding dashboard-admin-sa --clusterrole=cluster-admin --serviceaccount=default:dashboard-admin-sa
- kubectl describe secrets/dashboard-admin-sa-token-ztl5j

#### Local Access

- kubectl config set-context --current --namespace kubernetes-dashboard
- kubectl get pods
- kubectl port-forward kubernetes-dashboard-79b5779bf4-sx8bn 8443:8443
- chrome://flags/#allow-insecure-localhost
- access `https://localhost:8443`
