variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t2.micro"
}

variable "instance_keypair" {
    description = "key-pair for ec2 instances"
    type = string
    default = "key-pair-01"
}
