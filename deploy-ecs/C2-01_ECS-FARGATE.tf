resource "aws_ecs_cluster" "nodeapp_cluster" {
  name = "mynodeapp-cluster"
}

data "template_file" "node_app1" {
  template = file("./template/image.json")
  vars = {
    app_image       = var.app_image
    app_port        = var.app_port
    aws_region      = var.aws_region
  }
}

resource "aws_ecs_task_definition" "node_app1" {
  family = "node_app1"
  requires_compatibilities  = ["FARGATE"]
  network_mode              = "awsvpc"
  cpu                       = var.fargate_cpu
  memory                    = var.fargate_memory
  container_definitions     = data.template_file.node_app1.rendered
}

resource "aws_ecs_service" "mynode_app" {
  name            = "node_app1"
  cluster         = aws_ecs_cluster.nodeapp_cluster.id
  task_definition = aws_ecs_task_definition.node_app1.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = ["subnet-c5d624b8"]
    assign_public_ip = true
  }
}