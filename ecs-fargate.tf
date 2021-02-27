resource "aws_ecs_cluster" "my_fargate_cluster" {
  name = "my_fargate_cluster"

  capacity_providers = ["FARGATE_SPOT", "FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
  }

  tags = {
    Name = "Sample ECS Fargate Cluster"
  }

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

# module "ecs-fargate" {
#   source  = "cn-terraform/ecs-fargate/aws"
#   version = "2.0.24"
#   # insert the 37 required variables here



# }


# resource "aws_ecs_task_definition" "ecs_fargate_definition" {
#   family                   = "ecs_fargate_definition"
#   task_role_arn            = "${var.ecs_task_role}"
#   execution_role_arn       = "${var.ecs_task_execution_role}"
#   network_mode             = "awsvpc"
#   cpu                      = "256"
#   memory                   = "1024"
#   requires_compatibilities = ["FARGATE"]
#   }