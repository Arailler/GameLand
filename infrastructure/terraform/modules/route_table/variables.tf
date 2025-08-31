variable "vpc_id" {
  description = "VPC ID where the route table will be created"
  type        = string
}

variable "name" {
  description = "Name tag for the route table"
  type        = string
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
