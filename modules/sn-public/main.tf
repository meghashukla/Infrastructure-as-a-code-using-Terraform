## Public subnet
resource "aws_subnet" "public" {
  count             = length(var.subnet_az)
  vpc_id            = var.vpc_id
  cidr_block        = element(var.subnet_cidr,count.index)
  #availability_zone = element(var.subnet_az,count.index)

  tags = {
        Name = "${var.subnet_name} ${count.index+1}"
}
}
## Internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = "igw-${var.subnet_name}"
  }
}

## Routing table
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  tags = {
    Name = "rt-${var.subnet_name}"
  }
}

resource "aws_route" "gateway_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

## Associate the routing table to public subnet
resource "aws_route_table_association" "rt_assn" {
  count          = length(var.subnet_cidr)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}



