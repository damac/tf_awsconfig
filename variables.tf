variable "cloudtrail_snstopicarn" {
  type = "string"
  default = ""
}

variable "cloudtrail_cwloggroup" {
  type = "string"
  default = ""
}

variable "aws_region" {
  type = "string"
  description = "aws region"
  default = "us-east-1"
}

variable "account_alias" {
  type        = "string"
  description = ""
}

variable "terraform-role" {
  type    = "string"
  description = ""
  default = ""
}

variable "required-tags" {
  type = "map"
  default = {
    Name = ""
    Owner = ""
    BudgetCode = ""
  }
}
