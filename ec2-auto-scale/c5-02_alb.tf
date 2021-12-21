# ALB resource for balancing the node app
resource "aws_alb" "alb_prod" {
  name                          = "alb-prod-01"
  load_balancer_type            = "application"
  security_groups               = [aws_security_group.alb_sg.id]
  subnets                       = [for subnet in aws_subnet.public_subnet : subnet.id]
  enable_deletion_protection    = false

  tags = local.common_tags
}

# Target group for HTTP traffic, redirects the traffic to the instances in the port 3000
resource "aws_alb_target_group" "node_tg" {
  name     = "tg-prod-nodeapp"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_prod.id
}

# HTTP listener
resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_alb.alb_prod.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.node_tg.arn
    type             = "forward"
  }
}


