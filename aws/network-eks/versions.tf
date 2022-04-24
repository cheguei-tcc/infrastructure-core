terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.72"
    }

    helm = {
      version = "~> 2.5.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "cheguei"

    workspaces {
      name = "infrastructure-core"
    }
  }

  required_version = ">= 0.14"
}