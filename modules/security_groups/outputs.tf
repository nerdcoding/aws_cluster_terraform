output "public_security_group_ids" {
  value = ["${aws_security_group.public_sg.*.id}"]
}
