terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

    backend "remote" {
    hostname = "app.terraform.io"
    organization = "cheguei"

    workspaces {
      name = "infrastructure-core"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "cheguei-tf"
  location = "Brazil South"

  tags = {
    Environment = "Development"
    Team = "DevOps"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "cheguei-net"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}