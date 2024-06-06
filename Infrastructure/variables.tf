# Variables for the infrastructure

# Azure region 
variable "region" {
  type        = string
  description = "Azure region"
  default     = "westeurope"

  validation {
    condition     = contains(["westus2", "centralus", "eastus2", "westeurope", "eastasia", "eastasiastage"], var.region)
    error_message = "You must specify a supported region. Currently supported regions are westus2, centralus, eastus2, westeurope, eastasia, eastasiastage."
  }
}

# Common tags for all resources
variable "common_tags" {
  type        = map(string)
  description = "(Optional) Map of tags to apply to the resources in the deployment. Defaults to none."
  default     = {}
}