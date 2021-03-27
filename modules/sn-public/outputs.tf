output "id" {
  value = aws_subnet.public.*.id
}

output "name" {
  value = var.subnet_name
}

output "az" {
 value = var.subnet_az
}



