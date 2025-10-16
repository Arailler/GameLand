variable "autoscaling_group_names" {
  type        = list(string)
  description = "List of Auto Scaling Group names to attach to the target group"
}

variable "lb_target_group_arn" {
  type        = string
  description = "ARN of the target group"
}
