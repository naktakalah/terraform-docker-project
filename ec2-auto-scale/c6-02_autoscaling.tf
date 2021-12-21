resource "aws_launch_configuration" "as_lc_node_app" {
  name_prefix     = "as-lc-node-app"
  image_id        = data.aws_ami.amzlinux2.id
  instance_type   = "t2.micro"
  user_data       = file("${path.module}/install.sh")
  security_groups = ["${aws_security_group.asg_sg.id}"]
  key_name        = var.instance_keypair

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg_node_app" {
  launch_configuration  = "${aws_launch_configuration.as_lc_node_app.id}"
  availability_zones    = [var.azs[0],var.azs[1]]
  min_size              = 1
  max_size              = 4 
  target_group_arns     = ["${aws_alb_target_group.node_tg.arn}"]
  vpc_zone_identifier   = [aws_subnet.public_subnet.id[0],aws_subnet.public_subnet.id[1]]
  health_check_type     = "ELB"
  desired_capacity      = 2 
}

