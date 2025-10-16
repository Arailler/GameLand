variable "name" {
  type        = string
  description = "Name of the Auto Scaling Group"
}

variable "min_size" {
  type        = number
  description = "Minimum number of instances"
}

variable "max_size" {
  type        = number
  description = "Maximum number of instances"
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of instances"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the ASG"
}

variable "launch_template_id" {
  type        = string
  description = "ID of the Launch Template to use"
}

variable "target_group_arns" {
  description = "List of target group ARNs to attach to the ASG"
  type        = list(string)
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}