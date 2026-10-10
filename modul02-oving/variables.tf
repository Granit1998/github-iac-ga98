variable "location" {
  type        = string
  description = "Azure region to deploy resources"
  default     = "westeurope"
}

variable "rgname" {
  type        = string
  description = "Name of the resource group"
  default     = "rg-demo-we-ga98"
}

variable "saname" {
  type        = string
  description = "Name of the storage account"

}

variable "kortnavn" {
  description = "Din unike student-ID. Brukes som prefiks i alle ressursnavn."
  type        = string


  validation {
    condition     = can(regex("^[a-z0-9]{3,8}$", var.kortnavn))
    error_message = "kortnavn må være 3-8 tegn og kun inneholde små bokstaver og tall."
  }
}

variable "project" {
  description = "Kort prosjektnavn brukt i ressursnavn"
  type        = string
  default     = "iac"

  validation {
    condition     = length(var.project) <= 10
    error_message = "Prosjektnavnet kan ikke være lengre enn 10 tegn."
  }
}

variable "student_id" {
  description = "Din unike student-ID. Brukes som prefiks i alle ressursnavn."
  type        = string
  default     = "tim84"

  validation {
    condition     = can(regex("^[a-z0-9]{3,8}$", var.student_id))
    error_message = "student_id må være 3-8 tegn og kun inneholde små bokstaver og tall."
  }
}