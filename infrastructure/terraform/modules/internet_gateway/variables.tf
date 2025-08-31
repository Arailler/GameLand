variable "vpc_id" {
  description = "The ID of the VPC to attach the IGW"
  type        = string
}

variable "name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "tags" {
  description = "Additional tags for the Internet Gateway"
  type        = map(string)
  default     = {}
}
