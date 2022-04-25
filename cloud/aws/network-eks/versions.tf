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

    tls = {
      source  = "hashicorp/tls"
      version = ">= 2.2"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "cheguei"

    workspaces {
      name = "network-core"
    }
  }

  required_version = ">= 0.14"
}