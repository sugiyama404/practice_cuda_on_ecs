terraform {
  required_version = "=1.10.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# IAM
module "iam" {
  source   = "./modules/iam"
  app_name = var.app_name
}

# Lambda
module "lambda" {
  source              = "./modules/lambda"
  app_name            = var.app_name
  lambda_iam_role_arn = module.iam.lambda_iam_role_arn
}

# sagemaker
module "sagemaker" {
  source                 = "./modules/sagemaker"
  app_name               = var.app_name
  sagemaker_iam_role_arn = module.iam.sagemaker_iam_role_arn
  s3-ml-data-bucket      = module.s3.s3-ml-data-bucket
}
# S3
module "s3" {
  source   = "./modules/s3"
  app_name = var.app_name
}
