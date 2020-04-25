variable "availibility_zones" {
  type        = list(string)
  description = "Availibility zones which should be used in the AWS region."
}

variable "cluster_name" {
  type        = string
  description = "Name of the AWS cluster to create."
}

variable "vpc_id" {
  type        = string
  description = "The id of the VPC the subnet belongs to"
}

variable "subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for all subnets to create."
}

