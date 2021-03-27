resource "aws_ebs_volume" "ebsvolume" {
  count             = var.numberofvolumes
  availability_zone = element(var.ebsvolumeaz,1)
  size              = element(var.ebsvolumesize,count.index)
}