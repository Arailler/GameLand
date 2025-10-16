variable "name" {
  description = "Name of the IAM role"
  type        = string
}

variable "description" {
  description = "Description of the IAM role"
  type        = string
  default     = ""
}

variable "assume_role_policy_json" {
  description = "JSON document defining the trust policy (who can assume this role)"
  type        = string
}

variable "attached_policy_arns" {
  description = "List of IAM policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}