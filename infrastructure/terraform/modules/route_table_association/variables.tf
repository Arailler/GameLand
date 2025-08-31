variable "subnet_id" {
  type        = string
  description = "ID of the subnet to associate"
}

variable "route_table_id" {
  type        = string
  description = "ID of the route table to associate the subnet with"
}