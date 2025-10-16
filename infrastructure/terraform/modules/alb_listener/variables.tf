variable "load_balancer_arn" {
  type = string
}

variable "port" {
  type = number
}

variable "protocol" {
  type = string
}

variable "default_action" {
  type = object({
    type             = string
    target_group_arn = string
  })
}