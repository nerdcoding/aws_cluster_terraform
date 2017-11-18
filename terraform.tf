provider "aws" {
  region = "${var.aws-region}"
}

module "vpc" {
  source = "modules/vpc"

  cluster_name         = "${var.cluster_name}"
  vpc_cidr             = "${var.vpc_cidr}"
}