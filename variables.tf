variable "aws-region" {
  type = "string"
  description = "Desired AWS region."
}

variable "cluster_name" {
  type = "string"
  description = "Name of the AWS cluster to create."
}
variable "ssh_key_name" {
  type        = "string"
  description = "The name of the SSH key pair that you must use to log in to the instance securely."
}

variable "vpc_cidr" {
  type = "string"
  description = "The cidr block of the desired VPC."
}
variable "public_subnet_cidrs" {
  type = "list"
  description = "List of all all public subnet cidr blocks. The count of elements must match with the 'private_subnet_cidrs' and 'availibility_zones'."
}
variable "private_subnet_cidrs" {
  type = "list"
  description = "List of all all private subnet cidr blocks. The count of elements must match with the 'public_subnet_cidrs' and 'availibility_zones'."
}
variable "availibility_zones" {
  type = "list"
  description = "Availibility zones which should be used in the AWS region. The count of elements must match with the 'public_subnet_cidrs' and 'private_subnet_cidrs'."
}

variable "ec2_ami" {
  type        = "string"
  description = "The AMI of the operating system which should be used for each EC2 instance."
}

variable "database_name" {
  type        = "string"
  description = "The name of the database to create."
}
variable "database_user" {
  type        = "string"
  description = "Username for database access."
}
variable "database_password" {
  type        = "string"
  description = "Password for database access."
}

