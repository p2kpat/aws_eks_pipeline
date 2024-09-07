#this file ise used to configure a set of rules to be defined for the scaling policy. 
#this would decide where to create or destroy instances based on the parameters provided.
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template
#use the link above to create a launch template to be used by the aws auto scaling group.



resource "aws_launch_template" "aws_eks_ec2_instance_template" {
  name = "aws_eks_pipeline"
  image_id = var.ami_id
  instance_type = "t2.micro"
# key_name


#  metadata_options {
#    http_endpoint               = "enabled"
#   http_tokens                 = "required"
#   http_put_response_hop_limit = 1
#    instance_metadata_tags      = "enabled"
#  }

#  monitoring {
#    enabled = true
#  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.k8s_sg.id]
  }

#use this feature to provide which zones the instances will be created in.
#  placement {
#    availability_zone = "us-east-1a"
#  }
}





#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
#use the link above to define the autoscaling group
resource "aws_autoscaling_group" "autoscale_instance_parameters" {
  name                      = "aws_eks_pipeline_auto_scale_group"
  max_size                  = 3
  min_size                  = 1
  health_check_type         = "EC2"
  desired_capacity          = 1
  vpc_zone_identifier       = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id, aws_subnet.subnet_c.id]
  launch_template {
    id      = aws_launch_template.aws_eks_ec2_instance_template.id
  }
}



#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy
#use the link above to define the autoscaling policy

resource "aws_autoscaling_policy" "aws_asg_policy" {
name = "aws_auto_scaling_policy"
policy_type = "TargetTrackingScaling"
autoscaling_group_name = aws_autoscaling_group.autoscale_instance_parameters.name
estimated_instance_warmup = 200
target_tracking_configuration {
predefined_metric_specification {
predefined_metric_type = "ASGAverageCPUUtilization"
}
    target_value = "20"
}
}
