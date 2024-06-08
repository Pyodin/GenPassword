# Provider block 

provider "azurerm" {
  features {}
}

# Resource block

## Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rf-genpassword"
  location = var.region
  tags     = var.common_tags
}


# Azure App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = "asp-genpassword"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
  tags                = var.common_tags
}

# Random String for Secret Key
resource "random_string" "secret_key" {
  length  = 32
  special = true
}

# Azure Web App
resource "azurerm_linux_web_app" "webapp" {
  name                = var.app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id
  https_only          = true
  tags                = var.common_tags

  site_config {
    application_stack {
      python_version = "3.12"
    }
    always_on = false
  }

  app_settings = {
    "SECRET_KEY"       = random_string.secret_key.result
  }
}