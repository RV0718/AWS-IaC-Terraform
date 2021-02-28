output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "my_igw_id" {
  value = aws_internet_gateway.my_igw.id
}

output "my_rt_id" {
  value = aws_route_table.my_rt.id
}

output "my_fargate_cluster" {
  value = aws_ecs_cluster.my_fargate_cluster.id
}

output "my_sg_id" {
  value = aws_ecs_cluster.my_fargate_cluster.id
}