output "mssql_address" {
  description = "MSSQL instance hostname"
  value       = module.optimized-mssql-server.db_hostname
}

output "mssql_port" {
  description = "MSSQL instance port"
  value       = module.optimized-mssql-server.db_port
}

output "mssql_username" {
  description = "MSSQL instance root username"
  value       = module.optimized-mssql-server.db_username
  sensitive   = true
}

output "mssql_password" {
  description = "MSSQL instance master password."
  value       = module.optimized-mssql-server.db_password
  sensitive   = true
}

output "mssql_endpoint" {
  value       = module.optimized-mssql-server.db_endpoint
  description = "Connection endpoint for the MSSQL instance that has been created"
}

output "mssql_engine" {
  value       = module.optimized-mssql-server.db_engine
  description = "Database instance engine that was configured."
}

output "mssql_status" {
  description = "Status of the database instance that was created."
  value       = module.optimized-mssql-server.db_status
}

output "instance_class" {
  description = "Instance class in use for the database instance that was created."
  value       = module.optimized-mssql-server.instance_class
}

output "mssql_allocated_storage" {
  description = "Storage that was allocated to the instance when it configured."
  value       = module.optimized-mssql-server.db_allocated_storage
}

output "mssql_max_allocated_storage" {
  description = "Maximum storage allocation that is configured on the database instance."
  value       = module.optimized-mssql-server.db_max_allocated_storage
}

output "mssql_arn" {
  description = "ARN of the database instance."
  value       = module.optimized-mssql-server.db_arn
}

output "mssql_kms_key_id" {
  description = "KMS key that is configured on the database instance if storage encryption is enabled."
  value       = module.optimized-mssql-server.db_kms_key_id
}

output "mssql_backup_window" {
  description = "Configured backup window for the database instance."
  value       = module.optimized-mssql-server.db_backup_window
}

output "mssql_maintenance_window" {
  description = "Maintainence window for the database instance."
  value       = module.optimized-mssql-server.db_maintenance_window
}

output "mssql_db_name" {
  description = "Name of the database that was created (if specified) during instance creation."
  value       = module.optimized-mssql-server.db_name
}