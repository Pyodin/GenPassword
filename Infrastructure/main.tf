# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-genpassword"
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
    "SECRET_KEY"                     = random_string.secret_key.result
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
  }
}

# ovh domain verification
resource "ovh_domain_zone_record" "verification" {
  zone = var.domain
  subdomain = "asuid.www"
  target = azurerm_linux_web_app.webapp.custom_domain_verification_id
  fieldtype  = "TXT"
  ttl = 3600
}

# CNAME record 
resource "ovh_domain_zone_record" "cname" {
  zone = var.domain
  target = azurerm_linux_web_app.webapp.default_hostname
  subdomain = "www"
  fieldtype  = "CNAME"
  ttl = 3600
}

# Hostname binding
resource "azurerm_app_service_custom_hostname_binding" "hostname-binding" {
  hostname            = "www.${var.domain}"
  app_service_name    = azurerm_linux_web_app.webapp.name
  resource_group_name = azurerm_resource_group.rg.name

  depends_on = [ 
    azurerm_linux_web_app.webapp,
    ovh_domain_zone_record.cname
  ]
}