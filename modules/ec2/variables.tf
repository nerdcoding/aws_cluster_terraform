variable "ssh_key_name" {
  type        = "string"
  description = "The name of the SSH key pair that you must use to log in to the instance securely."
}

variable "subnet_ids" {
  type        = "list"
  description = "List of subnet ids where the EC2 instances are created."
}

variable "sec_group_id" {
  type        = "string"
  description = "The security group this EC2 belongs to."
}

variable "public_ip" {
  type        = "string"
  description = "Boolean (true/false) indicates if the EC2 instance should get a public IP."
}

variable "instance_count" {
  type        = "string"
  description = "Count of intances to create in each subnet."
}

variable "ec2_ami" {
  type        = "string"
  description = "The AMI of the operating system which should be used for each EC2 instance."
}