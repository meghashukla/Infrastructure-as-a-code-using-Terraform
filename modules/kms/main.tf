resource "aws_kms_key" "masterkey" {

  description              = "encryption at rest key"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  deletion_window_in_days = 10
  policy                   = file("${path.module}/kms_policy.json.tpl")
}

