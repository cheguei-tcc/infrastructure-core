## Starting Kubernetes Cluster

This project automates all resources used by the cheguei project at cloud providers to provision and created a kubernetes cluster.

### AWS

#### Running :scroll:

To provision initial resources, such as firewall settings, virtual machines and kubernetes worker nodes and control plane:
-   `make eks-create-infra`
-   `aws eks update-kubeconfig --name cheguei-eks`

To create DNS records, configure nginx-ingress controller, k8s authentication, aws load balancer and eks subdomains, run:
-   `make eks-create-config`

#### Prerequisites :scroll:

- an AWS account with the IAM permissions listed on the EKS module documentation
- a configured AWS CLI
- AWS IAM Authenticator
- kubectl
- wget (required for the eks module)

#### Resources :money_with_wings:

-   VPC
    -   Region => sa-east-1 with `availability zones`
    -   Single NAT Gateway
-   EKS WORKER GROUPS
    -   Security Group => worker_group_eks
    -   EC2
        -   On Demand => `t3a.small`
        -   Spot => `t3.small` `t3a.small
-   ACM certificate for eks.cheguei.app and *.eks.cheguei.app
-   ALB Load Balancer
-   Route53 DNS name servers to cheguei.app and eks subdomains

### GCP

>todo
### AZURE

>todo
### OCI

>todo