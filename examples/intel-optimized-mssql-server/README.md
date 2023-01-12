<p align="center">
  <img src="https://github.com/OTCShare2/terraform-intel-hashicorp/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel Cloud Optimization Modules for Terraform

© Copyright 2023, Intel Corporation

## Terraform Intel MSSQL RDS 

This example creates a Microsoft SQL RDS platform based on the latest Intel Architecture. 

## Usage

variables.tf

```hcl
variable "region" {
  description = "Target AWS region to deploy workloads in."
  type        = string
  default     = "us-west-1"
}
```
main.tf
```hcl
# Provision Intel Optimized AWS MSSQL server
module "optimized-mysql-server" {
  source            = "../../"
  db_engine         = "sqlserver-ee"
  db_engine_version = "15.00"
  db_password       = var.db_password
  rds_identifier    = "rds-example-id"
  # Update the vpc_id below for the VPC that this module will use. Find the vpc-id in your AWS account
  # from the AWS console or using CLI commands. In your AWS account, the vpc-id is represented as "vpc-",
  # followed by a set of alphanumeric characters. One sample representation of a vpc-id is vpc-0a6734z932p20c2m4
  db_username = "sqladministrator"
  vpc_id      = "vpc-example-vpc"
  db_timeouts = {
    create = "2h"
    delete = "2h"
    update = "2h"
  }
}
```



Run Terraform

```hcl
export TF_VAR_db_password ='<USE_A_STRONG_PASSWORD>'
terraform init  
terraform plan
terraform apply 
```
## Considerations
Change rds_identifier and vpc_id