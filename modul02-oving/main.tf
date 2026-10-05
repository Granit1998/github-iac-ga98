terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "7a3c6854-0fe1-42eb-b5b9-800af1e53d70"
}



resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.location
  # Tagger gjør det enkelt å finne igjen egne ressurser i et delt abonnement
  tags = {
    student = var.kortnavn
    course  = "iac"
  }
}


resource "azurerm_storage_account" "rg-sa-niti98" {
  name                     = var.saname
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "test"
  }
}