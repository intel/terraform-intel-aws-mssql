<p align="center">
  <img src="https://github.com/intel/terraform-intel-aws-mssql/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel Optimized Cloud Modules for Terraform

© Copyright 2025, Intel Corporation

## Terraform Intel MSSQL RDS 

This example creates an Amazon RDS database server for Microsoft SQL based on the latest Intel Architecture. It is created in an exisitng VPC. The vpc-id for this existing VPC is required to updated in the main.tf of this example folder. The database server is created is the us-west-1 region. In order to change the region, update the value for region in the variables.tf file inside this example's folder.

## Usage

variables.tf

```hcl
variable "region" {
  description = "Target AWS region to deploy workloads in."
  type        = string
  default     = "us-west-1"
}

variable "db_password" {
  description = "Password for the master database user."
  type        = string
  sensitive   = true
}
```
main.tf
```hcl
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
```



Run Terraform

```hcl
terraform init  
terraform plan
terraform apply -var="db_password=enter_your_password_here" 
```
## Considerations
- Change rds_identifier and vpc_id
- There are some variables in the variables.tf file under the main repo that have default values. If you have existing resources in your AWS account that is conflicting with any of the default values in variables.tf file, please update the default values in variables.tf file