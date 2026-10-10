variable "name_prefix" {
  description = "Prefiks alle ressursnavn i modulen bygges fra, f.eks. \"tim84-iac-dev\"."
  type        = string
}
 
variable "location" {
  description = "Azure-region ressursene opprettes i. Settes av den som kaller modulen."
  type        = string
}
 
variable "resource_group_name" {
  description = "Navnet på en EKSISTERENDE ressursgruppe. Modulen oppretter den ikke selv."
  type        = string
}
 
variable "address_space" {
  description = "Adresserommet til det virtuelle nettverket (CIDR)."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
 
variable "subnet_address_prefix" {
  description = "Adresseområdet til subnettet. Må ligge innenfor address_space."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}
 
# NY I network-v1.1.0.
#
# Uten default hadde dette vært en MAJOR-endring: hver konsument som flyttet
# ?ref, ville fått "No value for required variable" og måtte endret sin egen
# kode. Med default er det konsumentens valg om den vil overstyre – ikke et
# krav.
variable "data_subnet_address_prefix" {
  description = "Adresseområdet til data-subnettet. Må ligge innenfor address_space og ikke overlappe subnettet over."
  type        = list(string)
  default     = ["10.0.2.0/24"]
}
 
variable "tags" {
  description = "Tagger som settes på ressursene modulen oppretter."
  type        = map(string)
  default     = {}
}
 