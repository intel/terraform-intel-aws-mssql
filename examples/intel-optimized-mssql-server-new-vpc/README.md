<p align="center">
  <img src="https://github.com/intel/terraform-intel-aws-mssql/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel Cloud Optimization Modules for Terraform

© Copyright 2023, Intel Corporation

## Terraform Intel MSSQL RDS

This example creates an Amazon RDS database server for Microsoft SQL based on the latest Intel Architecture. It is created in a new VPC. This new vpc is created as the forst step within this example. The vpc-id for this new VPC is passed on to the database server creation step. The database server is created is the us-west-1 region. In order to change the region, update the value for region in the variables.tf file inside this example's folder.

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

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~>3.18.1"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-1a", "us-west-1b", "us-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

# Provision Intel Optimized AWS MSSQL server
module "optimized-mssql-server" {
  source            = "intel/aws-mssql/intel"
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
```



Run Terraform

```hcl
terraform init  
terraform plan
terraform apply -var="db_password=enter_your_password_here"  
```
## Considerations
- This example creates a new vpc. If you get error for vpc creation due to maximum number of vpc's being already present for your account in the specific region being used, please work with AWS Support team to increase your limit
- There are some variables in the variables.tf file under the main repo that have default values. If you have existing resources in your AWS account that is matching any of the default values in variables.tf file, please update the default values in variables.tf file