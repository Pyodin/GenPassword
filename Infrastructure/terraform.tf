
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    ovh = {
      source  = "ovh/ovh"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform"
    storage_account_name = "tfstoragebhs"
    container_name       = "tfstate-genpassword"
    key                  = "genpassword.tfstate"
  }
}

# Provider block 

provider "azurerm" {
  features {}
}

provider "random" {}

provider "ovh" {}