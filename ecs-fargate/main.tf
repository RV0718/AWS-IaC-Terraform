resource "aws_ecs_cluster" "main" {
  name = "${var.name}-ecs_fargate_cluster-${var.environment}"

  capacity_providers = ["FARGATE_SPOT", "FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
  }

  tags = {
    Name = "${var.name}-ecs_fargate_cluster-${var.environment}"
  }

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_task_definition" "main" {
  family                   = "${var.name}-ecs_fargate_td-${var.environment}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_definition_cpu
  memory                   = var.task_definition_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([{
    name      = var.container_name
    image     = "${var.container_image}:${var.image_tag}"
    essential = true
    environment = [{
      "name" : "REDIS_HOST",
      "value" : "localhost"
    }]
    portMappings = [{
      protocol      = "tcp"
      containerPort = var.container_port
      hostPort      = var.container_port
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/app"
        awslogs-region        = var.region
        awslogs-stream-prefix = "ecs"
      }
    }
  }])



  tags = {
    Name        = var.container_name
    Environment = var.environment
  }
}

resource "aws_ecs_service" "main" {
  name                               = "${var.name}-ecs_fargate_service-${var.environment}"
  cluster                            = aws_ecs_cluster.main.id
  task_definition                    = aws_ecs_task_definition.main.arn
  desired_count                      = var.service_desired_count
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  launch_type         = "FARGATE"
  scheduling_strategy = "REPLICA"

  network_configuration {
    security_groups  = [aws_security_group.ecs_task.id]
    subnets          = aws_subnet.private_subnet.*.id
    assign_public_ip = false
  }


  load_balancer {
    target_group_arn = aws_alb_target_group.main.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  depends_on = [aws_alb_listener.http]
  # we ignore task_definition changes as the revision changes on deploy
  # of a new version of the application
  # desired_count is ignored as it can change due to autoscaling policy
  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
}
