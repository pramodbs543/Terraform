#This contains NAT Gateway
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  # Replace with your desired CIDR block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project}-vpc"
  }
}


resource "aws_subnet" "private" {
  count      = "${length(local.private_subnets_cidr)}"
  cidr_block = "${local.private_subnets_cidr[count.index]}"
  vpc_id     = aws_vpc.my_vpc.id

  map_public_ip_on_launch = true
  availability_zone       = "${local.AZ[count.index]}"
  tags = {
    Name = "${local.private_subnets_az[count.index]}"
  }
}

resource "aws_subnet" "public" {
  count      = "${length(local.public_subnets)}"
  cidr_block = "${element(values(local.public_subnets), count.index)}"
  vpc_id     = aws_vpc.my_vpc.id

  map_public_ip_on_launch = true
  availability_zone       = "${local.AZ[count.index]}"

  tags = {
    Name = "${element(keys(local.public_subnets), count.index)}"
  }
}


resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.project}-igw"
  }
}

resource "aws_eip" "nat" {
  count=2
  domain                    = "vpc"

}

resource "aws_nat_gateway" "gw" {
count=2
  allocation_id = "${aws_eip.nat[count.index].id}"
  subnet_id     = "${aws_subnet.public[count.index].id}"

  tags = {
    Name = "${local.nat[count.index]}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

    tags = {
    Name = "${var.project}-pub-rt"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_igw.id
}
resource "aws_route_table_association" "public-association" {
  count=2
  subnet_id      = "${aws_subnet.public[count.index].id}"
  route_table_id = aws_route_table.public_rt.id
}

#Private route tables only for app tier instances/tier 2 and not for DB
resource "aws_route_table" "private_rt" {
  count=2
  vpc_id = aws_vpc.my_vpc.id
  #The local route is automatically created
  #Destination is CIDR of VPC and target is local.
  tags = {
    Name = "${var.project}-pvt-rt"
  }
}

resource "aws_route" "private_route" {
  count=2
  route_table_id         = "${aws_route_table.private_rt[count.index].id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_nat_gateway.gw[count.index].id}"
}
resource "aws_route_table_association" "private-association" {
  count=2
  subnet_id      = "${aws_subnet.private[count.index].id}"
  route_table_id = "${aws_route_table.private_rt[count.index].id}"
}





