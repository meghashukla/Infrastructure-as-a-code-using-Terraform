resource "aws_subnet" "private" {

  count             = length(var.subnet_az)
  vpc_id            = var.vpc_id
  cidr_block        = element(var.subnet_cidr,count.index)
  availability_zone = element(var.subnet_az,count.index)

  tags = {
    Name = "${var.subnet_name} ${count.index+1}"

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

  count          = length(var.subnet_cidr)
  subnet_id      = element(aws_subnet.private.*.id, count.index)

  route_table_id = aws_route_table.private_route_table.id
}




