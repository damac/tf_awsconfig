variable "aws_region" {
  description = "aws region"
  type = "string"
}

variable "account_alias" {
  description = "The account_alias is used for a resource identification prefix."
  type = "string"
}

variable "config_logs_prefix" {
  description = "The S3 prefix for AWS Config logs."
  default     = "config"
  type        = "string"
}

variable "password_require_uppercase" {
  description = "Require at least one uppercase character in password."
  default     = true
}

variable "password_require_lowercase" {
  description = "Require at least one lowercase character in password."
  default     = true
}

variable "password_require_symbols" {
  description = "Require at least one symbol in password."
  default     = true
}

variable "password_require_numbers" {
  description = "Require at least one number in password."
  default     = true
}

variable "password_min_length" {
  description = "Password minimum length."
  default     = 20
}

variable "password_reuse_prevention" {
  description = "Number of passwords before allowing reuse."
  default     = 12
}

variable "password_max_age" {
  description = "Number of days before password expiration."
  default     = 90
}

variable "tag_value_1" {
  default = "Name"
}

variable "tag_value_2" {
  default = "BudgeCode"
}

variable "tag_value_3" {
  default = "Application"
}
