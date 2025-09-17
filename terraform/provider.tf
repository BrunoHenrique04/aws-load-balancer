# PROVIDER
terraform {

  required_version = "~> 1.12.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.9.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = "us-east-1"
}
