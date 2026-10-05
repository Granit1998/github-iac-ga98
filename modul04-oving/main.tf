# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
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
  name     = "${local.name_prefix}-rg"
  location = var.location

  # Tagger gjør det enkelt å finne igjen egne ressurser i et delt abonnement
  tags = local.common_tags
}

module "network" {
  source                = "./modules/network"
  name_prefix           = local.name_prefix
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  address_space         = ["10.0.0.0/16"]
  subnet_address_prefix = ["10.0.1.0/24"]
  tags                  = local.common_tags
}