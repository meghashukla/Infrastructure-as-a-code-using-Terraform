output "sns_topic_id" {
  value= aws_sns_topic.sns_alarms_for_http_5XX.arn
}
output "endpoint_arn"{
    value = aws_cloudformation_stack.sns_topic.id
}