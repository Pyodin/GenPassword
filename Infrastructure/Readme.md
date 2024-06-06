# Terraform configuration for deploying a django application on Azure App Service

This folder contains the Terraform configuration for deploying a Django application on Azure App Service.

## Pre-requisites
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- A custom domain name. Here i bought [genpassword.fr](https://genpassword.fr)

## Create the backend storage for Terraform state file
To store the Terraform state file, you need to create a storage account and a container in Azure Blob Storage.
I suggest you store all your Terraform state files in a single storage account and one container per application. This way, you can easily manage them and avoid creating multiple storage accounts. If you already have this configuration, skip to step 3.

Don't forget to log in to Azure using the Azure CLI before running the following commands (`az login`).


1. Create a resource group
    ```powershell
    az group create --name <resource-group-name> --location <location>
    ```
2. Create a storage account
    ```powershell
    az storage account create --name <storage-account-name> --resource-group <resource-group-name> --location <location> --sku Standard_LRS
    ```
3. Create a storage account container
    ```powershell
    az storage container create --name <container-name> --account-name <storage-account-name>
    ```
4. Create the `terraform.tf` file.
    The `terraform.tf` file contains the configuration for the Terraform backend. Replace the placeholders with your values.
    ```hcl
    terraform {
        required_providers {
            azurerm = {
                source  = "hashicorp/azurerm"
                version = "~>3.0"
            }
        }

        backend "azurerm" {
            resource_group_name   = "<resource-group-name>"
            storage_account_name  = "<storage-account-name>"
            container_name        = "<container-name>"
            key                   = "terraform.tfstate"
        }
    }
    ```

## Initialize Terraform
1. Initialize Terraform
    ```powershell
    terraform init 
    ```
2. Apply the configuration
    ```powershell
    terraform apply 
    ```
