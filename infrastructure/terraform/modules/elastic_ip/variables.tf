variable "name" {
  description = "The name for Elastic IP"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to the Elastic IPs"
  type        = map(string)
  default     = {}
}
