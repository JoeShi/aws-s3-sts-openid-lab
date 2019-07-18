provider "aws" {
  region = var.region
  profile = var.profile
}

data "aws_caller_identity" "current" {}

resource "random_string" "suffix" {
  length = 8
  special = false
  number = false
  upper = false
}

output "domain" {
  value = var.domain
}

output "clientId" {
  value = var.clientId
}

output "region" {
  value = var.region
}

output "app" {
  value = var.app
}

output "bucket" {
  value = aws_s3_bucket.s3.bucket
}

output "roleArn" {
  value = aws_iam_role.oidc_role.arn
}
