variable "name" {
  description = "The name of the key pair"
  type        = string
}

variable "public_key" {
  description = "Path to the public key file or public key content"
  type        = string
}

variable "tags" {
  description = "Additional tags to attach to the key pair"
  type        = map(string)
  default     = {}
}
