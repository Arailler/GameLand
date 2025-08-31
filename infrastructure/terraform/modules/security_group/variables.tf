variable "name" {
  type        = string
  description = "Name of the security group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the security group will be created"
}

variable "ingress_rules" {
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string), [])
    sg_ids      = optional(list(string), [])
  }))
}

variable "egress_rules" {
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string), [])
    sg_ids      = optional(list(string), [])
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
