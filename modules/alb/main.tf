resource "aws_lb" "applicationloadbalancer" {
  name                      = var.lb_name
  internal                  = false
  load_balancer_type        = "application"
  security_groups           = [var.alb_sg_id]
  #count                     = length(var.alb_subnet_id)
  subnets                   =  var.alb_subnets
}

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.applicationloadbalancer.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

resource "aws_lb_listener_rule" "health_check" {
  listener_arn = aws_lb_listener.http.arn

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "HEALTHY"
      status_code  = "200"
    }
  }

  condition {
    query_string {
      key   = "health"
      value = "check"
    }

    query_string {
      value = "bar"
    }
  }
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "${var.lb_name}-targetgroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
}

#resource "aws_lb_target_group_attachment" "alb_target_group_attachment" {
# target_group_arn = aws_lb_target_group.alb_target_group.arn
# target_id        = var.asg_id
# port             = 80
#}
