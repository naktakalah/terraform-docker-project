resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow TLS inbound traffic"
  vpc_id = "vpc-76df431d"
  ingress {
        from_port     = 22
        to_port       = 22
        protocol      = "tcp"
        cidr_blocks   = ["0.0.0.0/0"]
  }
  ingress {
        from_port     = 3000
        to_port       = 3000
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