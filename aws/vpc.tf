# get all available AZs in our region
data "aws_availability_zones" "available" {}

# reserve Elastic IP to be used in our NAT gateway
resource "aws_eip" "nat_gw_elastic_ip" {
  vpc = true

  tags = {
    Name            = "${var.cluster_name}-nat-eip"
    iac_environment = var.iac_environment_tag
  }
}

module "vpc" {
  # DOCS - https://github.com/terraform-aws-modules/terraform-aws-vpc
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.2.0"

  name = "${var.cluster_name}-vpc"
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
  # TODO What is this ?
  reuse_nat_ips       = true
  external_nat_ip_ids = [aws_eip.nat_gw_elastic_ip.id]


  # We might need internet gateway to expose some pods to the internet ?
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    iac_environment                             = var.iac_environment_tag
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
    iac_environment                             = var.iac_environment_tag
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
    iac_environment                             = var.iac_environment_tag
  }
}