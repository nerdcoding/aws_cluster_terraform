# For each element in the 'subnet_cidrs' a new subnet ist created inside of the 'availibility_zones' list element of the
# same index.
resource "aws_subnet" "subnet" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${element(var.subnet_cidrs, count.index)}"
  availability_zone = "${element(var.availibility_zones, count.index)}"
  count             = "${length(var.subnet_cidrs)}"

  tags {
    Name            = "${var.cluster_name}_${element(var.availibility_zones, count.index)}"
  }
}

# Create a new route table used for all just created subnets
resource "aws_route_table" "subnet" {
  vpc_id             = "${var.vpc_id}"

  tags {
    Name             = "${var.cluster_name}_route_table"
  }
}

# Add all subnets to the route table
resource "aws_route_table_association" "subnet" {
  subnet_id          = "${element(aws_subnet.subnet.*.id, count.index)}"
  route_table_id     = "${aws_route_table.subnet.id}"
  count              = "${length(var.subnet_cidrs)}"
}