variable "subnet_ids" {
  type        = "list"
  description = "List of subnets in which to place the NAT Gateway."
}

variable "subnet_count" {
  type        = "string"
  description = "Size of the subnet_ids."
}