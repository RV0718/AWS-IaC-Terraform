resource "aws_launch_configuration" "ecs_launch_config" {
  name                 = "${var.name}-${var.environment}-launch-config"
  image_id             = var.ami_id
  iam_instance_profile = aws_iam_instance_profile.ecs_instance_profile.id
  security_groups      = [aws_security_group.ecs_sg.id]
  # This user data represents a collection of “scripts” that will be executed the first time the machine starts.
  # This specific example makes sure the EC2 instance is automatically attached to the ECS cluster that we create earlier
  # and marks the instance as purchased through the Spot pricing
  user_data                   = <<EOF
                  #!/bin/bash
                  echo ECS_CLUSTER="ecs-ec2-dev-cluster" >> /etc/ecs/ecs.config
                  EOF
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = false

  root_block_device {
    volume_type           = "standard"
    volume_size           = 30
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs_asg" {

  name                 = "asg"
  vpc_zone_identifier  = local.private_sub_ids
  launch_configuration = aws_launch_configuration.ecs_launch_config.name
  target_group_arns    = [aws_alb_target_group.main.arn]
  # placement_group           = aws_placement_group.aws_pg.id
  force_delete              = true
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 1
  health_check_grace_period = 100
  health_check_type         = "EC2"
}
