# Creates an AWS NAT Gateway (not a NAT instance)
resource "aws_eip" "elastic_ip" {
  vpc   = true
  count = "${var.subnet_count}"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${element(aws_eip.elastic_ip.*.id, count.index)}"
  subnet_id     = "${element(var.subnet_ids, count.index)}"
  count         = "${var.subnet_count}"
}