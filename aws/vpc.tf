data "aws_availability_zones" "available" {}

locals {
  cluster_name = var.clustername
}

module "vpc" {
  # DOCS - https://github.com/terraform-aws-modules/terraform-aws-vpc
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name = "cheguei-vpc"
  cidr = "10.0.0.0/16"
  # data.aws_availability_zones.available.names - A list of the Availability Zone names available to the account.
  azs             = data.aws_availability_zones.available.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  # A NAT gateway is a Network Address Translation (NAT) service.
  enable_nat_gateway = true
  # The same nat gateway will be used to all az to reduce costs 
  single_nat_gateway   = true
  enable_dns_hostnames = true

  # We might need internet gateway to expose some pods to the internet ?
  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}