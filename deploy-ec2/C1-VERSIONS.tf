# Terraform block
terraform {
    required_version = "~>1.0"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

# Provider block
provider "aws" {
    region = "us-east-2"
    profile = "prod"
}

