// main.tf

// Configure the Azure provider
provider "azurerm" {
  features {}
  subscription_id = "2224565f-a725-4e9d-8de0-6ab4d548f8f4"
}

// Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_linux_web_app" "app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      node_version = "18-lts"
    }
    always_on = false
  }

  depends_on = [azurerm_app_configuration.appconfig]

  lifecycle {
    prevent_destroy = true
    ignore_changes = [identity, site_config]
  }
}

// Create an Azure App Configuration store
resource "azurerm_app_configuration" "appconfig" {
  name                = "arqiva-dynamic-string-${random_string.unique_suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "random_string" "unique_suffix" {
  length  = 6
  upper   = false
  special = false
}

// Create an Azure App Service Plan
resource "azurerm_service_plan" "plan" {
  name                = "${var.app_service_name}-plan"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "F1"
}

// Assign App Configuration Data Reader role to App Service identity
resource "azurerm_role_assignment" "appconfig_reader" {
  scope                = azurerm_app_configuration.appconfig.id
  role_definition_name = "App Configuration Data Reader"
  principal_id         = azurerm_linux_web_app.app.identity[0].principal_id
}
