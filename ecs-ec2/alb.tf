resource "aws_alb" "main" {
  name               = "${var.name}-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = aws_security_group.alb_to_ecs.*.id
  subnets            = aws_subnet.public_subnet.*.id

  enable_deletion_protection = false

  tags = {
    Name        = "${var.name}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_alb_target_group" "main" {
  name        = "${var.name}-${var.environment}-alb-target-grp"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"



  #TODO need to correct it later

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.name}-${var.environment}"
    Environment = var.environment
  }
}

# Redirect/forward to https listener
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.main.id
  port              = var.container_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.main.arn
    type             = "forward"

    # redirect {
    #   port        = 443
    #   protocol    = "HTTPS"
    #   status_code = "HTTP_301"
    # }
  }
}
