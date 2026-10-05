locals {
  # Ett felles navnemønster som alle ressursnavn bygges fra
  name_prefix = "${var.student_id}-${var.project}"

  common_tags = {
    student = var.student_id
    course  = "iac"
  }
}