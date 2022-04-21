module "eks" {
  # https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/UPGRADE-18.0.md
  # https://github.com/terraform-aws-modules/terraform-aws-eks
  # https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/11.0.0?tab=inputs
  source          = "terraform-aws-modules/eks/aws"
  version         = ">= v18.20.0"
  cluster_name    = var.clustername
  cluster_version = "1.22"
  subnet_ids      = module.vpc.private_subnets
  enable_irsa     = true
  vpc_id          = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    # General Purpose SSD
    root_volume_type = "gp2"
  }

  # DECLARING SPOT AND ON DEMAND INSTANCES
  # this lets us schedule the important workloads to the on-demand instances and scalable workloads and temporary pods to spot instances
  # using nodeselector
  eks_managed_node_groups = {
    node_group = {
      min_size       = 1
      max_size       = 2
      desired_size   = var.ondemand_desired_size
      instance_types = var.ondemand_instance_types
    },
    worker_group = {
      name           = "worker-group-spot-1"
      min_size       = 1
      max_size       = var.spot_max_size
      desired_size   = var.spot_desired_size
      instance_types = var.spot_instance_types

      bootstrap_extra_args   = "--kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot'"
      vpc_security_group_ids = [aws_security_group.worker_group_eks.id]
    }
  }

  # More details here:
  # https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}