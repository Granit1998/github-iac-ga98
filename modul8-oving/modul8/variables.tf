variable "kortnavn" {
  description = "Ditt unike kortnavn (små bokstaver og tall, 3-8 tegn)."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,8}$", var.kortnavn))
    error_message = "kortnavn må være 3-8 tegn, kun små bokstaver og tall."
  }
}

variable "project" {
  description = "Ditt unike project-navn (små bokstaver og tall, 3-8 tegn)."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,8}$", var.project))
    error_message = "project-navn må være 3-8 tegn, kun små bokstaver og tall."
  }
}


variable "location" {
  description = "Azure-region"
  type        = string
  default     = "norwayeast"
}