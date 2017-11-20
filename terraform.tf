# Terraform should create AWS resources. Make sure the envirnoment variables `AWS_ACCESS_KEY_ID` and
# `AWS_SECRET_ACCESS_KEY` exists.
provider "aws" {
  region = "${var.aws-region}"
}

# Creates a VPC and a Internet Gateway in the VPC
module "vpc" {
  source = "modules/vpc"

  cluster_name         = "${var.cluster_name}"
  vpc_cidr             = "${var.vpc_cidr}"
}

# For each 'private_subnet_cidr' a private subnet is created.
module "private_subnet" {
  source = "modules/subnet"

  cluster_name       = "${var.cluster_name}_private_subnet"
  vpc_id             = "${module.vpc.vpc_id}"
  subnet_cidrs       = "${var.private_subnet_cidrs}"
  availibility_zones = "${var.availibility_zones}"
}
# For each 'public_subnet_cidr' a public subnet is created.
module "public_subnet" {
  source = "modules/subnet"

  cluster_name       = "${var.cluster_name}_public_subnet"
  vpc_id             = "${module.vpc.vpc_id}"
  subnet_cidrs       = "${var.public_subnet_cidrs}"
  availibility_zones = "${var.availibility_zones}"
}
