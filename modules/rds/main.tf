resource "aws_db_subnet_group" "default" {
  name       = "${var.cluster_name}-subnet-group"
  subnet_ids = var.private_subnet_ids
}

resource "aws_db_instance" "postgresql" {
  identifier             = "${var.cluster_name}-postgresql"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "9.6.5"
  instance_class         = "db.t2.micro"
  multi_az               = "true"
  name                   = var.database_name
  username               = var.database_user
  password               = var.database_password
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [var.sec_group_id]
  skip_final_snapshot    = true
}

