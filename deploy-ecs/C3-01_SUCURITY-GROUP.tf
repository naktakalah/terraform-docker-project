resource "aws_security_group" "ecs_sg" {
  name        = "ecs_sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id = "vpc-76df431d"
  ingress {
        from_port     = 22
        to_port       = 22
        protocol      = "tcp"
        cidr_blocks   = ["0.0.0.0/0"]
  }
  ingress {
        from_port     = 80
        to_port       = 80
        protocol      = "tcp"
        cidr_blocks   = ["0.0.0.0/0"]
  }
  egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
}
  tags = {
    Name = "allow_ssh"
  }
}