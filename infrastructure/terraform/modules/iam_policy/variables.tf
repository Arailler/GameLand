variable "name" {
  description = "Name of the IAM policy"
  type        = string
}

variable "description" {
  description = "Description of the IAM policy"
  type        = string
}

variable "policy_json" {
  description = "The JSON document of the IAM policy"
  type        = string
}