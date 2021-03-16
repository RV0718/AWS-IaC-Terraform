output "vpc_id" {
  value = aws_vpc.main.id
}

output "my_igw_id" {
  value = aws_internet_gateway.main.id
}

output "my_rt_id" {
  value = aws_route_table.main.id
}

output "cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "aws_alb_target_group_arn" {
  value = aws_alb_target_group.main.arn
}

output "alb_hostname" {
  value = aws_alb.main.dns_name
}

output "public_subnets_ids" {
  value = aws_subnet.public_subnet.*.id
}