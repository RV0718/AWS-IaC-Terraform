resource "aws_ecs_cluster" "main" {
  name = "${var.name}-${var.environment}-cluster"

  tags = {
    Name = "${var.name}-cluster-${var.environment}-cluster"
    Env  = var.environment
  }

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_task_definition" "main" {
  family                   = "${var.name}-${var.environment}"
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  requires_compatibilities = ["EC2"]
  network_mode             = var.network_mode
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.task_definition_cpu
  memory                   = var.task_definition_memory

  container_definitions = jsonencode([{
    name  = var.container_name
    image = "${var.container_image}:${var.image_tag}"
    # memory    = var.container_memory
    # cpu       = var.container_cpu
    essential = true
    portMappings = [{
      protocol      = "tcp"
      containerPort = var.container_port
      hostPort      = var.host_port
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/ec2/app"
        awslogs-region        = var.region
        awslogs-stream-prefix = "ec2"
      }
    }
  }])

  tags = {
    Name        = var.container_name
    Environment = var.environment
  }
}

resource "aws_ecs_service" "main" {
  name                               = "${var.name}-${var.environment}-service"
  cluster                            = aws_ecs_cluster.main.id
  task_definition                    = aws_ecs_task_definition.main.arn
  desired_count                      = var.service_desired_count
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  #iam_role                           = aws_iam_role.ecs_service_role.name
  #health_check_grace_period_seconds = 60
  launch_type         = "EC2"
  scheduling_strategy = "REPLICA"
  ordered_placement_strategy {
    type  = "spread"
    field = "host"
  }
}
