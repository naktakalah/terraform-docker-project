variable "app_image" {
  default = "docktor1994/devops_practices:test_node"
  description = "image to be used"
}

variable "app_port" {
  default = "80"
  description = "port to be open in test_node app"
}

variable "fargate_cpu" {
  default = "1024"
}

variable "fargate_memory" {
  default = "2048"
}

variable "aws_region" {
  default = "us-east-2"
}