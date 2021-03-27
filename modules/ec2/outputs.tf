
output "instanceid" {
  value = aws_instance.web.id
}

output "subnet_id" {
  value = var.subnet_id
}

output "instance_name" {
  value = var.instance_name
}