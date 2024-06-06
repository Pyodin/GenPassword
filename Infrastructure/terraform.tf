
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform"
    storage_account_name = "tfstoragebhs"
    container_name       = "tfstate-genpassword"
    key                  = "genpassword.tfstate"
  }
}