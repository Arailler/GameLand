variable "name_prefix" {
  type        = string
  description = "Prefix for the launch template name"
}

variable "image_id" {
  type        = string
  description = "AMI ID for the instances"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  description = "Key pair name for the instances"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
}

variable "instance_profile" {
  description = "Nom de l'instance profile IAM à attacher"
  type        = string
  default     = ""
}

variable "tags" {
  type        = map(string)
  default     = {}
}