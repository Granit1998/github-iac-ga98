terraform {
  required_version = ">= 1.16.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }

  # Tom med vilje, som i modul 6 og 7. Verdiene kommer fra kommandolinja:
  #
  #   terraform init -backend-config=backend.hcl \
  #                  -backend-config="key=modul8/dev/network.tfstate"
  #
  # Den samme kommandoen står i deploy-dev. Lokalt i steg 4–6 og i
  # pipelinen i steg 7 er det altså den samme bloben – ikke to kopier.
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

locals {
  name_prefix = "${var.kortnavn}-${var.project}"

  common_tags = {
    owner      = var.kortnavn
    course     = "iac"
    module     = "modul8"
    managed_by = "pipeline"
  }
}

resource "azurerm_resource_group" "main" {
  name     = "${local.name_prefix}-rg"
  location = var.location
  tags     = local.common_tags
}

module "network" {
  # ---------------------------------------------------------------------------
  #  ENDRINGEN: fra disken til en tag
  # ---------------------------------------------------------------------------
  #  I modul7/ sto det source = "./modules/network". Nå leses adressen i tre
  #  deler:
  #
  #    git::https://github.com/<org>/<repo>.git   repoet som klones
  #    //modules/network                          mappa i repoet
  #    ?ref=network-v1.1.0                        taggen
  #
  #  <org>/<repo> er ditt eget repo – det samme som står i subject-strengen fra
  #  modul 6. Bytt ut LearnIAC-TIM/iac-terraform under med ditt.
  #
  #  Modulen ligger to mapper unna på disken, men Terraform henter den ikke
  #  derfra. init kloner repoet inn i .terraform/modules/network/ og bruker
  #  undermappa på taggen. Det er derfor plan sa No changes i steg 5, mens
  #  data-subnettet allerede lå i ../modules/network/main.tf: konsumenten får
  #  det som er TAGGET, ikke det som tilfeldigvis ligger i arbeidskopien.
  #
  #  Linja sto på network-v1.0.0 til steg 6. Da ble den flyttet hit, og vanlig
  #  terraform init hentet den nye taggen – init ser selv at kilden er endret.
  #  -upgrade trengtes ikke, og ville i tillegg skrevet om låsefila.
  source = "git::https://github.com/LearnIAC-TIM/iac-terraform.git//modules/network?ref=network-v1.1.0"

  # Kontrakten er den samme som før. data_subnet_address_prefix sendes ikke
  # inn – den har en default i modulen, og det er hele grunnen til at
  # oppgraderingen bare var én linje.
  name_prefix         = local.name_prefix
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.common_tags
}
 