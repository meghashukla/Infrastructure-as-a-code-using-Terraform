resource "aws_subnet" "private" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr
  availability_zone = var.subnet_az

  tags = {
    Name = "${var.subnet_name}"
  }
}
resource "aws_eip" "eip" {
  vpc      = true
}

resource "aws_nat_gateway" "masterngw" {

  allocation_id = aws_eip.eip.id
  subnet_id     = var.publicsubnet

  tags = {
    Name = "ngw-${var.subnet_name}"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.subnet_name}-rt"
  }
}

resource "aws_route" "nat_gateway_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id             = aws_nat_gateway.masterngw.id
}

resource "aws_route_table_association" "rt_assn" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_route_table.id
}




