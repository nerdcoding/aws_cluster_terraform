# Create a new route table for all public subnets.
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.cluster_name}_route_table_public"
  }
}

# Add all public subnets to the route table
resource "aws_route_table_association" "public_assoziation" {
  subnet_id      = element(var.public_subnet_ids, count.index)
  route_table_id = aws_route_table.public_route_table.id
  count          = var.public_subnet_count
}

resource "aws_route" "public_routes" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0" # TODO better make a variable
  gateway_id             = var.internet_gateway_id
}

# Create a new route table for all private subnets.
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
  count  = var.private_subnet_count

  tags = {
    Name = "${var.cluster_name}_${element(var.availibility_zones, count.index)}_private_route_table"
  }
}

# Add all private subnets to the route table
resource "aws_route_table_association" "private_assoziation" {
  subnet_id      = element(var.private_subnet_ids, count.index)
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
  count          = var.private_subnet_count
}

resource "aws_route" "private_nat_route" {
  count                  = var.private_subnet_count
  route_table_id         = element(aws_route_table.private_route_table.*.id, count.index)
  nat_gateway_id         = element(var.nat_gateway_ids, count.index)
  destination_cidr_block = "0.0.0.0/0" # TODO better make a variable
}

