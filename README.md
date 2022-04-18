## Starting Kubernetes Cluster

This project automates all resources used by the cheguei project at cloud providers to provision and created a kubernetes cluster.

### AWS

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
        -   Spot => `t3.small` `t3a.small`

### GCP

>todo
### AZURE

>todo
### OCI

>todo