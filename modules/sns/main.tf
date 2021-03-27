resource "aws_sns_topic" "sns_alarms_for_http_5XX" {
  name = "sns_alarms_for_http_5XX"
}

  data "template_file" "cloudformation_sns_stack" {
  template = file("${path.module}/email-sns-stack.json.tpl")

  vars = {
    display_name  = var.display_name
    email_address = var.email_address
    protocol      = var.protocol
  }
}

resource "aws_cloudformation_stack" "sns_topic" {
  name = "mystack"
  template_body = data.template_file.cloudformation_sns_stack.rendered
}

resource "aws_sns_topic_subscription" "user_updates_email_target" {
  topic_arn = aws_sns_topic.sns_alarms_for_http_5XX.arn
  protocol  = var.protocol
  endpoint  = aws_cloudformation_stack.sns_topic.id
}