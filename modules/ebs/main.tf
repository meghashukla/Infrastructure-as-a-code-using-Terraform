resource "aws_ebs_volume" "ebsvolume" {
  count             = var.numberofvolumes
  availability_zone = var.ebsvolumeaz
  size              = element(var.ebsvolumesize,count.index)
}