provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "niti1998"
  location = "westeurope"
}

resource "azurerm_storage_account" "example" {
  name                     = "niti98"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "test"
  }
}