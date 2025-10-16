variable "role_name" {
  description = "Name of the IAM role to attach policies to"
  type        = string
}

variable "attached_policy_arns" {
  description = "List of IAM policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}