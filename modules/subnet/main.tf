# For each element in the 'subnet_cidrs' a new subnet ist created inside of the 'availibility_zones' list element of the
# same index.
resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = element(var.subnet_cidrs, count.index)
  availability_zone = element(var.availibility_zones, count.index)
  count             = length(var.subnet_cidrs)

  tags = {
    Name = "${var.cluster_name}_${element(var.availibility_zones, count.index)}"
  }
}

