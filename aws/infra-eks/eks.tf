locals {
  # create single EKS node group
  eks_node_groups = {
    ondemand_group = {
      name           = "ondemand-group-eks"
      min_size       = var.ondemand_desired_size
      max_size       = var.ondemand_max_size
      desired_size   = var.ondemand_desired_size
      instance_types = var.ondemand_instance_types

      network_interfaces = [{
        delete_on_termination = true
      }]
      bootstrap_extra_args   = "--kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=ondemand'"
      vpc_security_group_ids = [aws_security_group.worker_group_eks.id]
    },
    spot_group = {
      name           = "spot-group-eks"
      min_size       = var.spot_desired_size
      max_size       = var.spot_max_size
      desired_size   = var.spot_desired_size
      instance_types = var.spot_instance_types
      capacity_type  = "SPOT"

      network_interfaces = [{
        delete_on_termination = true
      }]
      bootstrap_extra_args   = "--kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot'"
      vpc_security_group_ids = [aws_security_group.worker_group_eks.id]
    }
  }
}

module "eks" {
  # https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/UPGRADE-18.0.md
  # https://github.com/terraform-aws-modules/terraform-aws-eks
  # https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/11.0.0?tab=inputs
  source  = "terraform-aws-modules/eks/aws"
  version = ">= v18.20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.22"
  # TODO 
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  subnet_ids  = module.vpc.private_subnets
  enable_irsa = true
  vpc_id      = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    # General Purpose SSD
    root_volume_type = "gp2"
  }

  # DECLARING SPOT AND ON DEMAND INSTANCES
  # this lets us schedule the important workloads to the on-demand instances and scalable workloads and temporary pods to spot instances
  # using nodeselector
  eks_managed_node_groups = local.eks_node_groups
}

# add spot fleet Autoscaling policy
resource "aws_autoscaling_policy" "eks_autoscaling_policy" {
  count = length(local.eks_node_groups)

  name                   = "${module.eks.eks_managed_node_groups_autoscaling_group_names[count.index]}-autoscaling-policy"
  autoscaling_group_name = module.eks.eks_managed_node_groups_autoscaling_group_names[count.index]
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.autoscaling_average_cpu
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}