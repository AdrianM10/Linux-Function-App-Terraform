terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.5.0"
    }
  }

}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.rglocation
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "appserviceplan" {
  name                = var.appserviceplan
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "function" {
  name                = var.function
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id      = azurerm_service_plan.appserviceplan.id  
  
  storage_account_name = azurerm_storage_account.storage.name
  
  site_config {}
}

resource "azurerm_linux_function_app_slot" "appslot" {
  name                 = var.appslot
  function_app_id      = azurerm_linux_function_app.function.id
  storage_account_name = azurerm_storage_account.storage.name

  site_config {}
}
