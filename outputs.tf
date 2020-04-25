output "PostgreSQL_Database_DNS" {
  value = [
    module.rds.postgresql_endpoint,
  ]
}

