resource "aws_security_group" "asg_sg" {
  depends_on  = [aws_security_group.alb_sg]
  name        = "alb-inbound"
  description = "Security group for autoscaling instances"
  vpc_id      = aws_vpc.vpc_prod.id
}

resource "aws_security_group_rule" "inbound_alb" {
  type                      = "ingress"
  from_port                 = 3000
  to_port                   = 3000
  protocol                  = "tcp"
  security_group_id         = "${aws_security_group.asg_sg.id}"
  source_security_group_id  = "${aws_security_group.alb_sg.id}"
}