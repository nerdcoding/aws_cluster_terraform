resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  //enable_dns_hostnames = true
  tags = {
    Name = "${var.cluster_name}_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.cluster_name}_igw"
  }
}

