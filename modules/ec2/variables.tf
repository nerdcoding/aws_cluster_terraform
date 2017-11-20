variable "ssh_key_name" {
  type        = "string"
  description = "The name of the SSH key pair that you must use to log in to the instance securely."
}

variable "subnet_ids" {
  type        = "list"
  description = "List of subnet ids where the EC2 instances are created."
}

variable "sec_group_ids" {
  type        = "list"
  description = "List of all security group ids."
}

variable "public_subnet_count" {
  type        = "string"
  description = "Size of the public subnet_ids."
}