variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "name" {
  description = "Name of the VPC"
  type        = string
}

variable "tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}
