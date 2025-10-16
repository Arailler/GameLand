variable "description" {
  type        = string
  default     = null
  description = "Description of the security group rule"
}

variable "type" {
  type        = string
  description = "Rule type (ingress or egress)"
}

variable "from_port" {
  type        = number
  description = "Starting port"
}

variable "to_port" {
  type        = number
  description = "Ending port"
}

variable "protocol" {
  type        = string
  description = "Protocol (tcp, udp, icmp, -1 for all)"
}

variable "security_group_id" {
  type        = string
  description = "Target security group ID"
}

variable "source_security_group_id" {
  type        = string
  default     = null
  description = "Source security group ID for inter-SG rules"
}

variable "cidr_blocks" {
  type        = list(string)
  default     = []
  description = "List of allowed CIDRs (e.g., [\"0.0.0.0/0\"])"
}