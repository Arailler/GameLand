variable "allocation_id" {
  description = "The EIP allocation ID to attach to the NAT gateways"
  type        = string
}

variable "subnet_id" {
  description = "The public subnet ID where the NAT gateways will be created"
  type        = string
}

variable "name" {
  description = "The NAT Gateway name"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to the NAT gateways"
  type        = map(string)
  default     = {}
}
