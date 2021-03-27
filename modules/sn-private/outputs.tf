output "id" {
  value = aws_subnet.private.*.id
}

output "name" {
  value = var.subnet_name
}

output "az" {
  value = var.subnet_az
}

output "route_table_id" {
  value = aws_route_table.private_route_table.id
}

output "public_ip" {
  value = aws_eip.eip.public_ip
}