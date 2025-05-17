// variables.tf

variable "resource_group_name" {
  description = "The name of the resource group."
  default     = "rg-arqiva-demo"
}

variable "location" {
  description = "The Azure location where the resources will be created."
  default     = "West Europe"
}

variable "app_service_name" {
  description = "The name of the Azure App Service."
  default     = "arqiva-node-app"
}