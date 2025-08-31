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

variable "target_group_name" {
  type        = string
  description = "Name of the target group"
}

variable "target_port" {
  type        = number
}

variable "target_protocol" {
  type        = string
  default     = "HTTP"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the target group"
}

variable "tags" {
  type        = map(string)
  default     = {}
}