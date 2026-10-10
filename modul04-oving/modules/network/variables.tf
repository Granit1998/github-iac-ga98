variable "name_prefix" {
  description = "Kort prosjektnavn brukt i ressursnavn"
  type        = string
}
variable "location" {
  description = "Azure-region for ressursene"
  type        = string
}
variable "resource_group_name" {
  description = "Navnet på ressursgruppen som skal opprettes"
  type        = string
}
variable "subnet_address_prefix" {
  description = "Adresseområdet som skal brukes for subnettet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}
variable "tags" {
  description = "Tagger som skal brukes på ressursene"
  type        = map(string)
  default     = {}
}

variable "address_space" {
  description = "Adresseområdet som skal brukes for det virtuelle nettverket"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}