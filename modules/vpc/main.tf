
resource "aws_eip" "elastic_ip" {

}

resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"
  //enable_dns_hostnames = true
  tags {
    Name = "${var.cluster_name}_vpc"
  }
}