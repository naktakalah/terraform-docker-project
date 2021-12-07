resource "aws_instance" "web" {
  ami             = data.aws_ami.amzlinux2.id
  instance_type   = var.instance_type
  user_data       = file("${path.module}/install.sh")
  key_name        = var.instance_keypair
  depends_on = [
    aws_security_group.allow_ssh
  ]
  security_groups = ["${aws_security_group.allow_ssh.name}"]
  tags            = {
    Name          = "microservices_instance"
  }
}