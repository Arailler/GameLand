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

variable "bastion_min" {
  description = "Minimum number of bastion instances"
  type        = number
}

variable "bastion_max" {
  description = "Maximum number of bastion instances"
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

variable "cp_min" {
  description = "Minimum number of control plane instances"
  type        = number
}

variable "cp_max" {
  description = "Maximum number of the control plane instances"
  type        = number
}

variable "worker_ami" {
  description = "AMI of the workers"
  type        = string
}

variable "worker_size" {
  description = "Size of the worker instances"
  type        = string
}

variable "worker_min" {
  description = "Minimum number of worker instances"
  type        = number
}

variable "worker_max" {
  description = "Maximum number of worker instances"
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

variable "db_min" {
  description = "Minimum number of database instances"
  type        = number
}

variable "db_max" {
  description = "Maximum number of database instances"
  type        = number
}

variable "ingress_nodeport" {
  description = "Ingress NodePort of the cluster"
  type        = number
}