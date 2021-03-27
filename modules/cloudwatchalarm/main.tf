resource aws_cloudwatch_metric_alarm "alarm5XX" {
  #count = "${local.elb_count}"
  alarm_name          = "${var.instance_name}-5XXalarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = var.max_5xx_errors

  dimensions = {
    LoadBalancer = var.load_balancer_arns
  }
  alarm_description = "SNS if we start getting a lot of 500 errors"
  alarm_actions     = [var.sns_topic_arn]
}