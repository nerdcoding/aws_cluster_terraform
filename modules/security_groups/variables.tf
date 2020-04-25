variable "cluster_name" {
  type        = string
  description = "Name of the AWS cluster to create."
}

variable "vpc_id" {
  type        = string
  description = "The id of the VPC the subnet belongs to"
}

