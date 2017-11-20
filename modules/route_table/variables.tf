variable "availibility_zones" {
  type = "list"
  description = "Availibility zones which should be used in the AWS region."
}
variable "cluster_name" {
  type = "string"
  description = "Name of the AWS cluster to create."
}

variable "vpc_id" {
  type = "string"
  description = "The id of the VPC the subnet belongs to"
}

variable "public_subnet_ids" {
  type        = "list"
  description = "List of public subnet ids."
}
variable "private_subnet_ids" {
  type        = "list"
  description = "List of private subnet ids."
}

variable "public_subnet_count" {
  type        = "string"
  description = "Size of the public subnet_ids."
}
variable "private_subnet_count" {
  type        = "string"
  description = "Size of the private subnet_ids."
}

variable "internet_gateway_id" {
  type        = "string"
  description = "Id of the Internet Gateway."
}
variable "nat_gateway_ids" {
  type        = "list"
  description = "List of all NAT Gateway Ids."
}