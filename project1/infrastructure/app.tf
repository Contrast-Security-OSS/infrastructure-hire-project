resource "aws_ecs_cluster" "main" {
  name = "${var.project_name_prefix}-ecs-cluster"
}


data "template_file" "app" {
  template = file("${path.module}/app.json.tpl")

  vars = {
    fargate_cpu = var.fargate_cpu
    app_image = var.app_image
    fargate_memory = var.fargate_memory
    app_port = var.app_port
  }
}


resource "aws_ecs_task_definition" "app" {
  family                   = "app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  execution_role_arn       = var.ecs_role
  container_definitions    =  data.template_file.app.rendered
}

resource "aws_ecs_service" "main" {
  name            = "${var.project_name_prefix}-ecs-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs_tasks.id]
    subnets         = aws_subnet.private_subnets.*.id
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "app"
    container_port   = var.app_port
  }

  depends_on = [
    aws_alb_listener.front_end
  ]
}