
terraform {
  required_version = ">= 1.16.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }


  backend "azurerm" {}
}

provider "azurerm" {
  features {}

}


locals {


  common_tags = {
    owner  = "Granit98"
    course = "iac"
    module = "modul7"



    managed_by = "pipeline"
  }

}


