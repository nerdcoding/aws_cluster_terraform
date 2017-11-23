output "postgresql_endpoint" {
  value = ["${aws_db_instance.postgresql.endpoint}"]
}
