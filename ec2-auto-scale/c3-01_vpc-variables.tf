variable "vpc_prod_cidr" {
  description = "CIDR block for production VPC"
  default     = "10.0.0.0/16"
}

variable "public_cidr" {
  description = "CIDR for public subnet"
  type        = list(string)
  default     = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "private_cidr" {
  description = "CIDR for private subnet"
  type        = list(string)
  default     = ["10.0.3.0/24","10.0.4.0/24"]
}

variable "azs" {
  description = "A list of availability zones for the subnets"
  type        = list(string)
  default     = [ "us-east-2a", "us-east-2b" ]
}