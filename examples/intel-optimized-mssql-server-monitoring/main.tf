# For enhanced monitoring to send monitoring data to cloudwatch, an IAM role needs to be created that 
# permits RDS to send enhanced monitoring metrics to CloudWatch Logs. The code section below performs that function

resource "aws_iam_role" "enhanced_monitoring_cloudwatch" {
  name = "enhanced_monitoring_cloudwatch"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "monitoring.rds.amazonaws.com"
          ]
        },
        "Action" : [
          "sts:AssumeRole"
        ]
      }
    ]
  })
  # This role needs the AWS managed permission policy arn for AmazonRDSEnhancedMonitoringRole
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"]
}

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

  #Setting the parameters for enhanced monitoring and performance insights
  db_monitoring_interval          = "60"
  db_monitoring_role_arn          = aws_iam_role.enhanced_monitoring_cloudwatch.arn
  db_performance_insights         = true
  db_performance_retention_period = "7"
  db_cloudwatch_logs_export       = ["agent", "error"]
  #performance_insights_kms_key_id       = var.db_performance_insights ? var.db_performance_insights_kms_key_id : null

  # Setting the timeout parameters for the database server for create, delete and update operations
  db_timeouts = {
    create = "2h"
    delete = "2h"
    update = "2h"
  }
}