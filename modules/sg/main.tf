# Private security group
resource "aws_security_group" "internal" {
  name        = var.sg_internal
  description = "Security group to access private ports"
  vpc_id      = var.vpc_id


  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["10.0.0.0/16"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_internal
  }
}

resource "aws_security_group" "public" {
  name        = var.sg_public
  description = "Public access security group"
  vpc_id      = var.vpc_id

  # allow http traffic
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port =  80
    to_port   =  80
    protocol  =  "tcp"

    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["10.0.0.0/16"]
  }

  tags  = {
    Name = var.sg_public
  }
}
