resource "aws_vpc" "villvay_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "villvay_vpc"
  }
}


resource "aws_subnet" "villvay_pvt_subnet" {
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  vpc_id                  = aws_vpc.villvay_vpc.id
  map_public_ip_on_launch = "false"

  tags = {
    Name = "main-pvt-subnet"
  }
}

resource "aws_subnet" "villvay_pub_subnet" {
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = "true"
  vpc_id                  = aws_vpc.villvay_vpc.id

  tags = {
    Name = "main-pub-subnet"
  }
}

