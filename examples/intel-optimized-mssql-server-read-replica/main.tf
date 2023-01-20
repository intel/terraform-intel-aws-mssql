# Example of how to pass variable for database password:
# terraform apply -var="db_password=..."
# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables

# Provision Intel Optimized AWS MSSQL server
module "optimized-mssql-server" {
  source            = "../../"
  db_engine         = "sqlserver-ee"
  db_engine_version = "15.00"
  db_username       = "sqladministrator"
  db_password       = var.db_password

  # Set the rds_identifier below based on your naming conventions. The value for rds_identifier provided below is for example illustration purposes only
  rds_identifier = "rds-example-id"

  # Update the vpc_id below for the VPC that this module will use. Find the vpc-id in your AWS account
  # from the AWS console or using CLI commands. In your AWS account, the vpc-id is represented as "vpc-",
  # followed by a set of alphanumeric characters. One sample representation of a vpc-id is vpc-0a6734z932p20c2m4
  vpc_id = "replace_with_existing_vpc_id"

  # Setting the timeout parameters for the database server for create, delete and update operations
  db_timeouts = {
    create = "2h"
    delete = "2h"
    update = "2h"
  }
}

# Provision Intel Optimized AWS MSSQL server read replica
module "optimized-mssql-server-read-replica" {
  source                           = "../../"
  db_engine                        = "sqlserver-ee"
  db_engine_version                = "15.00"
  db_username                      = "sqladministrator"
  db_password                      = var.db_password
  multi_az                         = false # Read Replica cannot be multi az, hence this needs to be set to false
  aws_database_instance_identifier = "sqlserver-rr"
  db_replicate_source_db           = module.optimized-mssql-server.db_instance_id
  kms_key_id                       = module.optimized-mssql-server.db_kms_key_id
  skip_final_snapshot              = true
  db_backup_retention_period       = 0

  # Set the rds_identifier below based on your naming conventions. The value for rds_identifier provided below is for example illustration purposes only
  rds_identifier = "rds-example-id-rr"

  # Update the vpc_id below for the VPC that this module will use. Find the vpc-id in your AWS account
  # from the AWS console or using CLI commands. In your AWS account, the vpc-id is represented as "vpc-",
  # followed by a set of alphanumeric characters. One sample representation of a vpc-id is vpc-0a6734z932p20c2m4
  # In this example read replica is created in the same vpc as the source vpc.
  vpc_id = "replace_with_existing_vpc_id"

  # Setting the timeout parameters for the database server for create, delete and update operations
  db_timeouts = {
    create = "2h"
    delete = "2h"
    update = "2h"
  }
}