terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket         = "prova-primeiro-bimestre-devops-826121724893"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "prova-primeiro-bimestre-devops-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}