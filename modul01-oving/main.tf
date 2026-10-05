terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "7a3c6854-0fe1-42eb-b5b9-800af1e53d70"
  features {

  }
}

resource "azurerm_resource_group" "rg-sa-niti98" {
  name     = "rg-demo-we-ga98"
  location = "westeurope"
}


resource "azurerm_storage_account" "rg-sa-niti98" {
  name                     = "lade1998"
  resource_group_name      = azurerm_resource_group.rg-sa-niti98.name
  location                 = azurerm_resource_group.rg-sa-niti98.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "test"
  }
}
