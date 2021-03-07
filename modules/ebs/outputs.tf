output  "volumeid"{
    value = aws_ebs_volume.ebsvolume.*.id
}