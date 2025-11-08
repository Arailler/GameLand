variable "name" {
  description = "Name of the application"
  type        = string
}

variable "bastion_ami" {
  description = "AMI of the bastion instances"
  type        = string
}

variable "bastion_size" {
  description = "Size of the bastion instances"
  type        = string
}

variable "bastion_count" {
  description = "Count of bastion instances"
  type        = number
}

variable "cp_ami" {
  description = "AMI of the control plane instances"
  type        = string
}

variable "cp_size" {
  description = "Size of the control plane instances"
  type        = string
}

variable "cp_count" {
  description = "Count of control plane instances"
  type        = number
}

variable "workers_ami" {
  description = "AMI of the workers"
  type        = string
}

variable "workers_size" {
  description = "Size of the worker instances"
  type        = string
}

variable "workers_count" {
  description = "Count of worker instances"
  type        = number
}

variable "db_ami" {
  description = "AMI of the database instances"
  type        = string
}

variable "db_size" {
  description = "Size of the database instances"
  type        = string
}

variable "db_count" {
  description = "Count of database instances"
  type        = number
}
