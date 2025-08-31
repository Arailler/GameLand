variable "name" {
  description = "Name of the application"
  type        = string
}

variable "control_plane_count" {
  description = "Number of control plane instances"
  type        = number
}

variable "database_count" {
  description = "Number of database instances"
  type        = number
}

variable "worker_min" {
  description = "Minimum number of worker instances"
  type        = number
}

variable "worker_max" {
  description = "Maximum number of worker instances"
  type        = number
}