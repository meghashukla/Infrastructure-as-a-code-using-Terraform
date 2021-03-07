output "alb_id" {
    value = aws_lb.applicationloadbalancer.id
}

output "alb_dns_name" {
  value = aws_lb.applicationloadbalancer.dns_name
}

output "alb_name" {
  value = var.lb_name
}
output "target_group_arn" {
  value = aws_lb_target_group.alb_target_group.arn
}