resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.villvay_vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.villvay_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "public_RT"
  }
}

resource "aws_route_table_association" "pub_RT_association" {
  subnet_id      = aws_subnet.villvay_pub_subnet.id
  route_table_id = aws_route_table.public_RT.id
}
