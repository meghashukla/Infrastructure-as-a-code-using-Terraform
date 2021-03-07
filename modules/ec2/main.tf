resource "aws_instance" "web" {
  subnet_id     = var.subnet_id
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [var.sg_id]
  key_name = var.key_name
  user_data = file("${path.module}/scripts.sh")
  
  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_size           =  var.rootvolumesize
    volume_type           =  var.rootvolumetype
    encrypted             =  true
    kms_key_id            =  var.kms_key_id   
    delete_on_termination =  true
  }
  tags = {

    Name = var.instance_name
    }
}




