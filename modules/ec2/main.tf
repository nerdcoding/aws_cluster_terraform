resource "aws_instance" "web" {
  ami                         = "${var.ec2_ami}"
  instance_type               = "t2.micro"
  subnet_id                   = "${element(var.subnet_ids, count.index)}"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = ["${var.sec_group_id}"]
  key_name                    = "${var.ssh_key_name}"
  count                       = "${var.public_subnet_count}"
}