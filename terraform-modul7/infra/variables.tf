variable "rg_name" {
  type = string
}


variable "project" {
  description = <<-EOT
    Prosjektnavn, andre ledd i navnekonvensjonen. Det er HER miljøet ligger:
    "iac-dev" i dev.tfvars, "iac-prod" i prod.tfvars.
    Uten et ulikt project-navn per miljø ville de to instansene forsøkt å
    opprette den samme ressursgruppa – og da hjelper det ikke at de har hver
    sin state. To adskilte regnskap over den samme ressursen er fortsatt en
    kollisjon.
  EOT
  type        = string
}

variable "location" {
  description = "Azure-region. Bruk samme region som backenden."
  type        = string
  default     = "norwayeast"

  validation {
    condition     = contains(["norwayeast", "westeurope", "northeurope", "uksouth"], var.location)
    error_message = "Regionen må være én av: norwayeast, westeurope, northeurope, uksouth (Azure Policy i fagets tenant)."
  }
}