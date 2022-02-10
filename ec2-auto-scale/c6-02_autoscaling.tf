# resource "aws_launch_configuration" "as_lc_node_app" {
#   name_prefix     = "as-lc-node-app"
#   image_id        = data.aws_ami.amzlinux2.id
#   instance_type   = "t2.micro"
#   user_data       = file("${path.module}/install.sh")
#   security_groups = ["${aws_security_group.asg_sg.id}"]
#   key_name        = var.instance_keypair

#   lifecycle {
#     create_before_destroy = true
#   }
# }

resource "aws_launch_template" "as_lt_node_app" {
  name_prefix             = "as-lt-"
  image_id                = data.aws_ami.amzlinux2.id
  instance_type           = "t2.micro"
  vpc_security_group_ids  = ["${aws_security_group.asg_sg.id}"]
  user_data               = base64encode(file("${path.module}/install.sh"))
  
}

resource "aws_autoscaling_group" "asg_node_app" {
  # launch_configuration  = "${aws_launch_configuration.as_lc_node_app.name}"
  depends_on            = [aws_alb_target_group.node_tg]
  vpc_zone_identifier   = ["${aws_subnet.public_subnet.0.id}","${aws_subnet.public_subnet.1.id}"]
  min_size              = 1
  max_size              = 4 
  target_group_arns     = ["${aws_alb_target_group.node_tg.arn}"]
  health_check_type     = "ELB"
  desired_capacity      = 2 

  launch_template {
    id      = aws_launch_template.as_lt_node_app.id
    version = "$Latest"
  }
}
