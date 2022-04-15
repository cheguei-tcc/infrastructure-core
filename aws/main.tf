# terraform block, configuration, contains terraform specific settings
# that will be used to provision infrastructure
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

# configuration of specifics provider, in this case "aws"
# they need aws credentials which will be loading accordling to your profile
# its possible to use differents providers declaring more than one provider
provider "aws" {
  profile = "default"
  region  = "sa-east-1"
}

# defining the components of infrastructure
# two string before the block: resource_type resource_name
# disk size, disk image, VPC ids and so on
resource "aws_instance" "app_server" {
  ami           = "ami-090006f29ecb2d79a" # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type - free tier
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}