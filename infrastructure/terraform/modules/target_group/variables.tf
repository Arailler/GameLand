variable "name" {
  type = string
}

variable "port" {
  type = number
}

variable "protocol" {
  type    = string
  default = "HTTP"
}

variable "target_type" {
  type    = string
  default = "instance"
}

variable "vpc_id" {
  type = string
}

variable "targets" {
  type    = list(string)
  default = []
}

variable "health_check" {
  type = object({
    path                = optional(string)
    port                = string
    protocol            = string
    healthy_threshold   = number
    unhealthy_threshold = number
    interval            = number
    timeout             = number
  })
}