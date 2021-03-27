output  "amiid" {
    value = aws_ami_from_instance.ec2instanceimage.id
}
output "launchconfigid" {
  value = aws_launch_configuration.asglaunchconfiguration.id
}
output "asg_id"{
    value = aws_autoscaling_group.autoscalinggroup.id
}