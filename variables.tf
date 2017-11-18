variable "aws-region" {
  type = "string"
  description = "Desired AWS region."
}

variable "cluster_name" {
  type = "string"
  description = "Name of the AWS cluster to create."
}

variable "vpc_cidr" {
  type = "string"
  description = "The cidr block of the desired VPC."
}



