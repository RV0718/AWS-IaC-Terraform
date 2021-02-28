output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "my_igw_id" {
  value = aws_internet_gateway.my_igw.id
}

output "my_rt_id" {
  value = aws_route_table.my_rt.id
}

output "my_fargate_cluster" {
  value = aws_ecs_cluster.ecs_fargate_cluster.id
}

# output "aws_ecs_task_definition_public_id" {
#   value = aws_ecs_task_definition.ecs_fargate_td.
# }