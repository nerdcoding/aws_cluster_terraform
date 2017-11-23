variable "cluster_name" {
  type = "string"
  description = "Name of the AWS cluster to create."
}

variable "private_subnet_ids" {
  type = "list"
  description = "The ids af all private subnets."
}

variable "sec_group_id" {
  type        = "string"
  description = "The security group this EC2 belongs to."
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