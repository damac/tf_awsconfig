variable "aws_region" {
  type = "string"
  description = "aws region"
  default = "us-east-1"
}

variable "account_alias" {
  description = "The account_alias is used for a resource identification prefix."
  default = "test"
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
  default     = 14
}

variable "password_reuse_prevention" {
  description = "Number of passwords before allowing reuse."
  default     = 24
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
