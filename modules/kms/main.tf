resource "aws_kms_key" "masterkey" {
  description              = "encryption at rest key"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
}