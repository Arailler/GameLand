variable "name" {
  type        = string
  description = "Name of the ALB"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets where ALB will be deployed"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups for the ALB"
}

variable "tags" {
  type        = map(string)
  default     = {}
}