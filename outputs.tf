output "PostgreSQL Database DNS" {
  value = [
    "${module.rds.postgresql_endpoint}"
  ]
}