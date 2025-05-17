// outputs.tf

output "app_service_url" {
  description = "The public URL of the Azure App Service."
  value       = azurerm_linux_web_app.app.default_hostname
}

output "app_config_endpoint" {
  description = "The endpoint URL for Azure App Configuration."
  value       = azurerm_app_configuration.appconfig.endpoint
}
