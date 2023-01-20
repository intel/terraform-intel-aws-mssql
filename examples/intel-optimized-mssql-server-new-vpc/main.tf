# Example of how to pass variable for database password:
# terraform apply -var="db_password=..."
# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~>3.18.1"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-1a", "us-west-1b", "us-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Provision Intel Optimized AWS MSSQL server
module "optimized-mssql-server" {
  source            = "../../"
  db_engine         = "sqlserver-ee"
  db_engine_version = "15.00"
  db_username       = "sqladministrator"
  db_password       = var.db_password

  # Set the rds_identifier below based on your naming conventions. The value for rds_identifier provided below is for example illustration purposes only
  rds_identifier = "rds-example-id"

  vpc_id = module.vpc.vpc_id

  # Setting the timeout parameters for the database server for create, delete and update operations
  db_timeouts = {
    create = "2h"
    delete = "2h"
    update = "2h"
  }
}