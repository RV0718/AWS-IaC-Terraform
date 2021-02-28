resource "aws_ecs_cluster" "ecs_fargate_cluster" {
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

resource "aws_ecs_task_definition" "ecs_fargate_td" {
  family                   = "${var.name}-ecs_fargate_td-${var.environment}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  # task_role_arn            = aws_iam_role.ecs_task_role.arn
  # task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([{
    name      = "${var.name}-${var.container_name}-${var.environment}"
    image     = "${var.container_image}:${var.image_tag}"
    essential = true
    //environment = var.container_environment
    portMappings = [{
      protocol      = "tcp"
      containerPort = var.container_port
      hostPort      = var.container_port
    }]
    # logConfiguration = {
    #   logDriver = "awslogs"
    #   options = {
    #     awslogs-group         = aws_cloudwatch_log_group.main.name
    #     awslogs-stream-prefix = "ecs"
    #     awslogs-region        = var.region
    #   }
    # }
    # secrets = var.container_secrets
  }])

  tags = {
    Name        = "${var.name}-ecs_fargate_td-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_ecs_service" "ecs_fargate_service" {
  name                               = "${var.name}-ecs_fargate_service-${var.environment}"
  cluster                            = aws_ecs_cluster.ecs_fargate_cluster.id
  task_definition                    = aws_ecs_task_definition.ecs_fargate_td.arn
  desired_count                      = var.service_desired_count
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  //health_check_grace_period_seconds  = 60
  launch_type         = "FARGATE"
  scheduling_strategy = "REPLICA"

  network_configuration {
    # security_groups  = [local.sg_ids]
    security_groups  = [aws_security_group.ecs_task_sg.id]
    subnets          = aws_subnet.my_public_subnet.*.id
    assign_public_ip = true
  }


  # load_balancer {
  #   target_group_arn = var.aws_alb_target_group_arn
  #   container_name   = "${var.name}-container-${var.environment}"
  #   container_port   = var.container_port
  # }

  # we ignore task_definition changes as the revision changes on deploy
  # of a new version of the application
  # desired_count is ignored as it can change due to autoscaling policy
  # lifecycle {
  #   ignore_changes = [task_definition, desired_count]
  # }
}


# resource "aws_ecs_task_definition" "ecs_fargate_definition" {
#   family                   = "ecs_fargate_definition"
#   task_role_arn            = "${var.ecs_task_role}"
#   execution_role_arn       = "${var.ecs_task_execution_role}"
#   network_mode             = "awsvpc"
#   cpu                      = "256"
#   memory                   = "1024"
#   requires_compatibilities = ["FARGATE"]
#   }