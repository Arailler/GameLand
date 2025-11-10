variable "instance_count" {
  type        = number
  description = "Number of instances to create"
}

variable "ami" {
  type        = string
  description = "AMI ID for the instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnets for spreading instances"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security groups for instances"
}

variable "key_name" {
  type        = string
  description = "Key pair name for SSH access"
}

variable "iam_instance_profile" {
  type        = string
  description = "Instance profile of the instances"
  default     = null
}

variable "name_prefix" {
  type        = string
  description = "Prefix for the Name tag of each instance"
}

variable "tags" {
  type        = map(string)
  default     = {}
}