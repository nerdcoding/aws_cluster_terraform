resource "aws_security_group" "public_sg" {
  name        = "${var.cluster_name}_public_security_group"
  vpc_id      = "${var.vpc_id}"
}
resource "aws_security_group" "private_sg" {
  name        = "${var.cluster_name}_private_security_group"
  vpc_id      = "${var.vpc_id}"
}

# public sg rules
resource "aws_security_group_rule" "public_inbound_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.public_sg.id}"
}
resource "aws_security_group_rule" "public_inbound_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.public_sg.id}"
}
resource "aws_security_group_rule" "public_inbound_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.public_sg.id}"
}
resource "aws_security_group_rule" "public_outbound_plsql" {
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.private_sg.id}"
  security_group_id = "${aws_security_group.public_sg.id}"
}
resource "aws_security_group_rule" "public_outbound_http" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.public_sg.id}"
}
resource "aws_security_group_rule" "public_outbound_https" {
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.public_sg.id}"
}


# private sg rules
resource "aws_security_group_rule" "private_inbound_plsql" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.public_sg.id}"
  security_group_id        = "${aws_security_group.private_sg.id}"
}
resource "aws_security_group_rule" "private_outbound_http" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.private_sg.id}"
}
resource "aws_security_group_rule" "private_outbound_https" {
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.private_sg.id}"
}