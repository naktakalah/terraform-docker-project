# Variables for generic requirements

variable "aws_region" {
  description = "Region where resources will be created"
  default = "us-east-2"
}

variable "instance_keypair" {
  description = "Key name for SSH connection to instances"
  default = "key-pair-01"
}

variable "aws_profile_prod" {
  description = "Value for production profile"
  default = "prod"
}

variable "owner" {
  description = "The SRE that created this resource"
  default = "Hernan Aguero"
}

variable "environment" {
  description = "The environment in which this resource is deploying"
  default = "Production"
}

variable "sre_email" {
  description = "Email for contact with SRE"
  default = "hernaaguero@gmail.com"
}