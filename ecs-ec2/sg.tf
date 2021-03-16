resource "aws_security_group" "ecs_sg" {
  name        = "${var.name}-${var.environment}-ecs_sg"
  description = "Allow incoming traffic for ECS EC2"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol        = "tcp"
    from_port       = var.container_port
    to_port         = var.container_port
    security_groups = [aws_security_group.alb_to_ecs.id]
  }

  # egress {
  #   from_port   = 0
  #   to_port     = 65535
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.name}-${var.environment}-ecs_sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "alb_to_ecs" {
  name   = "${var.name}-${var.environment}-alb_to_ecs"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol         = "tcp"
    from_port        = 80
    to_port          = 80
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.name}-${var.environment}-alb"
    Environment = var.environment
  }
}
