variable "cluster_name" {
  type = "string"
  description = "Name of the AWS cluster to create."
}

variable "subnet_ids" {
  type = "list"
  description = "The ids af all private subnets."
}

variable "sec_group_id" {
  type        = "string"
  description = "The security group this EC2 belongs to."
}

variable "vpc_id" {
  type = "string"
  description = "The id of the VPC the subnet belongs to"
}

variable "ec2_instance_ids" {
  type = "list"
  description = "The ids of all EC2 instances traffc should be balanced to."
}
variable "ec2_instance_count" {
  type = "string"
  description = "Number of the all target EC2 instances."
}
