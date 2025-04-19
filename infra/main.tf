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

# Network
module "network" {
  source   = "./modules/network"
  app_name = var.app_name
}

# ECR
module "ecr" {
  source     = "./modules/ecr"
  app_name   = var.app_name
  image_name = var.image_name
}

# bash
module "bash" {
  source     = "./modules/bash"
  image_name = var.image_name
  region     = var.region
}

# EC2
module "ec2" {
  source                = "./modules/ec2"
  app_name              = var.app_name
  instance_profile_name = module.iam.instance_profile_name
  public_subnet_1a_id   = module.network.public_subnet_1a_id
  sg_ecs_id             = module.network.sg_ecs_id
  ecs_cluster_name      = module.ecs.ecs_cluster_name
}

# ECS
module "ecs" {
  source                   = "./modules/ecs"
  app_name                 = var.app_name
  ecs_instance_profile_arn = module.iam.ecs_instance_profile_arn
  ai_repository_url        = module.ecr.ai_repository_url
}
