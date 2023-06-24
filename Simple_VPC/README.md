#This VPC does not include NAT gateway
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  # Replace with your desired CIDR block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project}-vpc"
  }
}
resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"  # Replace with your desired subnet CIDR block
  availability_zone       = "ap-south-1a"  # Replace with your desired availability zone
  tags = {
    Name = "${var.project}-pvt-subnet"
  }
}
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"  # Replace with your desired subnet CIDR block
  availability_zone       = "ap-south-1b"  # Replace with your desired availability zone
  tags = {
    Name = "${var.project}-pub-subnet"
  }
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.project}-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

    tags = {
    Name = "${var.project}-pub-rt"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_igw.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id
  #The local route is automatically created
  #Destination is CIDR of VPC and target is local.
  tags = {
    Name = "${var.project}-pvt-rt"
  }
}

resource "aws_route_table_association" "private-association" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "public-association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}




