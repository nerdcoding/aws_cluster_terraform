# Terraform should create AWS resources. Make sure the envirnoment variables `AWS_ACCESS_KEY_ID` and
# `AWS_SECRET_ACCESS_KEY` exists.
provider "aws" {
  region = var.aws-region
}

# Creates a VPC and a Internet Gateway in the VPC
module "vpc" {
  source = "./modules/vpc"

  cluster_name = var.cluster_name
  vpc_cidr     = var.vpc_cidr
}

# For each 'private_subnet_cidr' a private subnet is created.
module "private_subnet" {
  source = "./modules/subnet"

  cluster_name       = "${var.cluster_name}_private_subnet"
  vpc_id             = module.vpc.vpc_id
  subnet_cidrs       = var.private_subnet_cidrs
  availibility_zones = var.availibility_zones
}

# For each 'public_subnet_cidr' a public subnet is created.
module "public_subnet" {
  source = "./modules/subnet"

  cluster_name       = "${var.cluster_name}_public_subnet"
  vpc_id             = module.vpc.vpc_id
  subnet_cidrs       = var.public_subnet_cidrs
  availibility_zones = var.availibility_zones
}

# In each public subnet a NAT Gateway is created with an associated Elastic IP. The private subnet in this availability
# zone can send requests to the Internet through this NAT Gateway.
module "nat" {
  source = "./modules/nat_gateway"

  subnet_ids   = module.public_subnet.subnet_ids
  subnet_count = length(var.public_subnet_cidrs)
}

# Creates one public route table for all public subnets. For each private subnet a route table is created. The public
# route table gets a rule that routes all traffic through Internet Gateway. Each private route table gets a rule that
# routes all traffic through the associated NAT Gateway.
module "route_tables" {
  source = "./modules/route_table"

  availibility_zones   = var.availibility_zones
  cluster_name         = var.cluster_name
  vpc_id               = module.vpc.vpc_id
  public_subnet_ids    = module.public_subnet.subnet_ids
  private_subnet_ids   = module.private_subnet.subnet_ids
  public_subnet_count  = length(var.public_subnet_cidrs)
  private_subnet_count = length(var.private_subnet_cidrs)
  internet_gateway_id  = module.vpc.internet_gateway_id
  nat_gateway_ids      = module.nat.nat_gateway_ids
}

# Creates a public and private security groupd the regulate the in- and outbound traffic through EC2 instances.
module "security_groups" {
  source = "./modules/security_groups"

  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
}

# Creates t2.micro EC2 instances in each private subnet.
module "private_ec2_instances" {
  source = "./modules/ec2"

  ssh_key_name   = var.ssh_key_name
  subnet_ids     = module.private_subnet.subnet_ids
  instance_count = var.private_ec2_instances
  public_ip      = "false"
  sec_group_id   = module.security_groups.private_security_group_id
  ec2_ami        = var.ec2_ami
}

# Creates a t2.micro EC2 instance in each public subnet used as host bastion.
module "public_ec2_instances" {
  source = "./modules/ec2"

  ssh_key_name   = var.ssh_key_name
  subnet_ids     = module.public_subnet.subnet_ids
  instance_count = "2"
  public_ip      = "true"
  sec_group_id   = module.security_groups.public_security_group_id
  ec2_ami        = var.ec2_ami
}

# Creates an relation database with PostgreSQL as engine. The database lays in a subnet group which spans over all
# private subnets.
module "rds" {
  source = "./modules/rds"

  cluster_name       = var.cluster_name
  private_subnet_ids = module.private_subnet.subnet_ids
  sec_group_id       = module.security_groups.private_security_group_id
  database_name      = var.database_name
  database_user      = var.database_user
  database_password  = var.database_password
}

module "load_balancer" {
  source = "./modules/load_balancer"

  cluster_name       = var.cluster_name
  subnet_ids         = module.public_subnet.subnet_ids
  sec_group_id       = module.security_groups.public_security_group_id
  vpc_id             = module.vpc.vpc_id
  ec2_instance_ids   = module.private_ec2_instances.aws_instance_ids
  ec2_instance_count = var.private_ec2_instances
}

