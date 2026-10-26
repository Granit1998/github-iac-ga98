resource "azurerm_virtual_network" "this" {
  name          = "${var.name_prefix}-vnet"
  address_space = var.address_space

  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_subnet" "this" {
  name                 = "${var.name_prefix}-snet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.subnet_address_prefix
}

# -----------------------------------------------------------------------------
#  NYTT I network-v1.1.0
# -----------------------------------------------------------------------------
#  Et subnett til, i neste ledige /24-blokk. Navnet følger mønsteret over
#  ("-data-snet" ved siden av "-snet"), og adressen kommer fra en variabel med
#  standardverdi, akkurat som for det første subnettet.
#
#  Hvorfor MINOR (1.0.0 → 1.1.0) og ikke MAJOR? Fordi ingen konsument må endre
#  en linje for å ta den i bruk. Ingen variabel er fjernet, ingen output har
#  byttet navn, og den nye variabelen har en default. Det er semantisk
#  versjonering i én setning: nytt, men bakoverkompatibelt.
#
#  Men en MINOR-versjon endrer fortsatt infrastrukturen. En konsument som
#  flytter ?ref, får "1 to add". Det er derfor flyttingen er konsumentens valg,
#  og ikke plattformteamets.
resource "azurerm_subnet" "data" {
  name                 = "${var.project}-data-subnet"   # samme mønster som subnettet som står der
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.2.0/24"]# ledig blokk i 10.0.0.0/16
}

module "network" {
  source = "git::https://github.com/DITT-ORG/iac-network.git?ref=v2.1.0"

  project             = var.project
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

module "network" {
  source              = "git::https://github.com/DITT-ORG/iac-network.git?ref=v2.1.0"
  project             = var.project
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

module "storage" {
  source              = "git::https://github.com/Granit1998/github-iac-ga98.git//modules/storage?ref=storage-v1.0.0"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
}