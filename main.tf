terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc-with-subnets"{
  source = "./vpc-with-subnets"
}

module "vpc-routing"{
  source = "./vpc-routing"
  public_subnet_ids = module.vpc-with-subnets.public_subnet_ids
  main_route_table_id = module.vpc-with-subnets.main_route_table_id
}

