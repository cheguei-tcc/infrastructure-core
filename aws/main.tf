# TODO adding nginx ingress deployment
module "eks" {
  # https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/UPGRADE-18.0.md
  # https://github.com/terraform-aws-modules/terraform-aws-eks
  # https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/11.0.0?tab=inputs
  source          = "terraform-aws-modules/eks/aws"
  version         = "<18"
  cluster_name    = var.clustername
  cluster_version = "1.22"
  subnets         = module.vpc.private_subnets
  enable_irsa     = true
  vpc_id          = module.vpc.vpc_id

  workers_group_defaults = {
    # General Purpose SSD
    root_volume_type = "gp2"
  }

  # DECLARING SPOT AND ON DEMAND INSTANCES
  # this lets us schedule the important workloads to the on-demand instances and scalable workloads and temporary pods to spot instances
  # using nodeselector
  worker_groups_launch_template = [
    {
      name                     = "worker-group-spot-1"
      override_instance_types  = var.spot_instance_types
      spot_allocation_strategy = "lowest-price"
      asg_max_size             = var.spot_max_size
      asg_desired_capacity     = var.spot_desired_size
      kubelet_extra_args       = "--node-labels=node.kubernetes.io/lifecycle=spot"
    },
  ]
  worker_groups = [
    {
      name          = "worker-group-1"
      instance_type = var.ondemand_instance_type
      # Extra lines of userdata (bash) which are appended to the default userdata code.
      #additional_userdata           = "echo foo bar"
      asg_desired_capacity = var.ondemand_desired_size
      kubelet_extra_args   = "--node-labels=node.kubernetes.io/lifecycle=ondemand"
      # Additional list of security groups that will be attached to the autoscaling group.
      additional_security_group_ids = [aws_security_group.worker_group_eks.id]
    }
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}