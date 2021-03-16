# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "cw_log_group" {
  name              = "/ecs/ec2/app"
  retention_in_days = 30

  tags = {
    Name        = "${var.name}-${var.environment}-${var.container_name}"
    Environment = var.environment
    Application = var.container_name
  }
}

resource "aws_cloudwatch_log_stream" "cw_log_stream" {
  name           = "app-log-stream"
  log_group_name = aws_cloudwatch_log_group.cw_log_group.name
}
