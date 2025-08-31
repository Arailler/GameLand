variable "elastic_ip_count" {
  description = "Number of Elastic IPs to create"
  type        = number
  default     = 1
}

variable "name_prefix" {
  description = "Prefix for Elastic IP names"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to the Elastic IPs"
  type        = map(string)
  default     = {}
}
