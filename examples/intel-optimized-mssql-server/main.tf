# Example of how to pass variable for database password:
# terraform apply -var="db_password=..."
# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables

# Provision Intel Optimized AWS MSSQL server
module "optimized-mssql-server" {
  source            = "intel/aws-mssql/intel"
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