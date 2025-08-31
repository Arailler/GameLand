variable "allocation_ids" {
  description = "List of EIP allocation IDs to attach to the NAT gateways"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of public subnet IDs where the NAT gateways will be created"
  type        = list(string)
}

variable "name_prefix" {
  description = "Prefix for NAT Gateway names"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to the NAT gateways"
  type        = map(string)
  default     = {}
}
