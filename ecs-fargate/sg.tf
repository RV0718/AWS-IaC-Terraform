resource "aws_security_group" "ecs_task" {
  name        = "${var.name}-ecs_task-${var.environment}"
  description = "Allow incomming traffic for ECS Task"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol  = "tcp"
    from_port = var.container_port
    to_port   = var.container_port
    # cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
    security_groups = [aws_security_group.alb.id]
  }
  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.name}-ecs_task-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_security_group" "alb" {
  name   = "${var.name}-sg-alb-${var.environment}-alb_to_ecs"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol         = "tcp"
    from_port        = 80
    to_port          = 80
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # ingress {
  #   protocol         = "tcp"
  #   from_port        = 8080
  #   to_port          = 8080
  #   cidr_blocks      = ["0.0.0.0/0"]
  #   ipv6_cidr_blocks = ["::/0"]
  # }
  # ingress {
  #   protocol         = "tcp"
  #   from_port        = 443
  #   to_port          = 443
  #   cidr_blocks      = ["0.0.0.0/0"]
  #   ipv6_cidr_blocks = ["::/0"]
  # }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.name}-sg-alb-${var.environment}-alb_to_ecs"
    Environment = var.environment
  }
}
