# Define a data source to check if the launch template already exists
data "aws_launch_template" "existing_launch_template" {
  count = var.use_existing_resources ? 1 : 0
  name  = "eks_instance_launch_template" # Ensure this matches the existing launch template name
}

# Create a new launch template only if it doesn't already exist
resource "aws_launch_template" "aws_eks_ec2_instance_template" {
  count           = var.use_existing_resources ? 0 : 1
  name            = "aws_eks_pipeline"
  image_id        = var.ami_id
  instance_type   = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.k8s_sg.id]
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Conditional launch template ID selection using a local variable
locals {
  # Access the first element with [0] as count = 1 or 0
  launch_template_id = var.use_existing_resources ? data.aws_launch_template.existing_launch_template[0].id : aws_launch_template.aws_eks_ec2_instance_template[0].id
}

# Define the Auto Scaling Group (ASG)
resource "aws_autoscaling_group" "autoscale_instance_parameters" {
  name                = "aws_eks_pipeline_auto_scale_group"
  max_size            = 3
  min_size            = 1
  health_check_type   = "EC2"
  desired_capacity    = 1
  vpc_zone_identifier = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id, aws_subnet.subnet_c.id]

  # Use the local variable for the launch template ID
  launch_template {
    id      = local.launch_template_id
    version = "$Latest" # Ensure the latest version is always used
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Define the Auto Scaling policy
resource "aws_autoscaling_policy" "aws_asg_policy" {
  name                     = "aws_auto_scaling_policy"
  policy_type              = "TargetTrackingScaling"
  autoscaling_group_name   = aws_autoscaling_group.autoscale_instance_parameters.name
  estimated_instance_warmup = 200

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 20 # Target value for CPU utilization
  }
}

