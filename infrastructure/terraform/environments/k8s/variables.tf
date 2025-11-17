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

variable "workers_app_ami" {
  description = "AMI of the worker-app instances"
  type        = string
}

variable "workers_app_size" {
  description = "Size of the worker-app instances"
  type        = string
}

variable "workers_app_count" {
  description = "Count of worker-app instances"
  type        = number
}

variable "workers_db_ami" {
  description = "AMI of the worker-db instances"
  type        = string
}

variable "workers_db_size" {
  description = "Size of the worker-db instances"
  type        = string
}

variable "workers_db_count" {
  description = "Count of worker-db instances"
  type        = number
}
