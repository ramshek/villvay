resource "aws_eip" "EIP" {
  vpc = "true"
}

resource "aws_nat_gateway" "nat_GW" {
  allocation_id = aws_eip.EIP.id
  subnet_id     = aws_subnet.villvay_pub_subnet.id
  depends_on    = [aws_internet_gateway.IGW]
}

resource "aws_route_table" "pvt_RT" {
  vpc_id = aws_vpc.villvay_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_GW.id
  }

  tags = {
    Name = "PVT RT"
  }
}

resource "aws_route_table_association" "pvt_ASSO" {
  route_table_id = aws_route_table.pvt_RT.id
  subnet_id      = aws_subnet.villvay_pvt_subnet.id
}
