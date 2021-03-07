resource "aws_ami_from_instance" "ec2instanceimage" {
  name               = "${var.instance_name}-ami"
  source_instance_id =  var.instance_id
}

resource "aws_launch_configuration" "asglaunchconfiguration" {
  image_id               = aws_ami_from_instance.ec2instanceimage.id
  instance_type          = var.instance_type
  security_groups        = [var.security_groups]
  key_name               = var.key_name
}

resource "aws_autoscaling_group" "autoscalinggroup" {
  launch_configuration = aws_launch_configuration.asglaunchconfiguration.id
  availability_zones = var.subnetazs
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity  = var.desired_capacity
  load_balancers = [var.load_balancer_name]
  health_check_type = "ELB"
  target_group_arns = [var.target_group_arn]
  tag {
    key = "Name"
    value = "${var.load_balancer_name}-asg"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "autoscalinggrouppolicy" {
  name                   = "${var.load_balancer_name}-asgpolicy"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.autoscalinggroup.name
}
