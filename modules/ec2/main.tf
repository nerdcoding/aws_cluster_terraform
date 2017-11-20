
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "t2.micro"
  subnet_id                   = "${element(var.subnet_ids, count.index)}"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = ["${element(var.sec_group_ids, count.index)}"]
  key_name                    = "${var.ssh_key_name}"
  count                       = "${var.public_subnet_count}"
}