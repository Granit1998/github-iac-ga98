
terraform {
  required_version = ">= 1.16.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }

  # ---------------------------------------------------------------------------
  #  PARTIAL CONFIGURATION – uendret fra øving 6, og nå brukt av to
  # ---------------------------------------------------------------------------
  #  Blokka er tom med vilje. Verdiene kommer fra kommandolinja:
  #
  #    terraform init -backend-config=backend.hcl \
  #                   -backend-config="key=modul7/dev/network.tfstate"
  #
  #  Den kommandoen står nå to steder: i terminalen din, og i tre jobber i
  #  .github/workflows/terraform-modul7.yml. Nøyaktig den samme
  #  kommandoen, kjørt i denne mappa av working-directory. Det er
  #  derfor pipelinen ikke krevde en eneste endring her.
  #
  #  Hadde key stått hardkodet i denne blokka, ville fila vært låst til ETT
  #  miljø – og apply-prod-jobben måtte hatt sin egen kopi av hele
  #  prosjektet. Det er øving 5-problemet, ett lag lenger ned.
  backend "azurerm" {}
}

provider "azurerm" {
  features {}

  # subscription_id kommer fra ARM_SUBSCRIPTION_ID. Lokalt setter du den selv;
  # i pipelinen står den i env-blokka øverst i workflowen. Provideren ser
  # ingen forskjell på de to – og det er nettopp derfor koden kan kjøre begge
  # steder uten en if-setning.
}

# -----------------------------------------------------------------------------
#  Navnekonvensjonen – uendret fra øving 2
# -----------------------------------------------------------------------------
locals {
  # Med kortnavn = "tim84" og project = "iac-dev" blir prefikset "tim84-iac-dev",
  # og ressursgruppa "tim84-iac-dev-rg".
  #
  # Miljøet ligger fortsatt i project-variabelen, altså i .tfvars-fila – ikke
  # i koden, og ikke i workflowen. Workflowen velger hvilken .tfvars som
  # brukes; den vet ingenting om hva som står i den.

  common_tags = {
    owner  = "Granit98"
    course = "iac"
    module = "modul7"

    # ENDRINGEN FRA PULL REQUESTEN.
    #
    # I øving 6 sto det managed_by = "terraform". Nå står det "pipeline", og
    # det er en liten sannhet med stor verdi: den som finner denne
    # ressursgruppa om tre måneder, ser at den ikke ble laget for hånd, og at
    # den derfor kan bygges opp igjen fra repoet.
    managed_by = "pipeline"
  }
  # MERK: fortsatt ingen keep-tag. Dette er ressurser som SKAL ryddes opp.
  # keep = "true" står bare på backenden fra øving 6.
}




# -----------------------------------------------------------------------------
#  Nettverksmodulen – uendret fra øving 4
# -----------------------------------------------------------------------------
#  Modulen har nå overlevd tre øvinger uten en eneste endring: den flyttet
#  ikke da staten flyttet (øving 6), og den merket ikke at den fra i dag
#  bygges av en maskin i stedet for av deg.
#
#  Det er CUPID-prinsippene fra modul 4 som virker. Modulen har én oppgave,
#  og kontrakten er den samme uansett hvem som kaller den.
module "network" {
  source = "./modules/network"

  name_prefix         = local.name_prefix
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.common_tags
}