resource "aws_vpc" "base" {
  cidr_block = var.cidr_block

  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

resource "aws_internet_gateway" "base" {
  vpc_id = aws_vpc.base.id

  tags = {
    Name = "${var.prefix}-base-igw"
  }
}

//route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.base.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.base.id
  }

  tags = {
    Name = "${var.prefix}-public-rt"
  }
}

//subnets
resource "aws_subnet" "private" {
  count             = length(var.zones)
  vpc_id            = aws_vpc.base.id
  cidr_block        = var.zones[count.index].private_subnet
  availability_zone = var.zones[count.index].zone

  tags = {
    Name = "${var.prefix}-private-subnet-${count.index}"
  }
}

resource "aws_subnet" "public" {
  count             = length(var.zones)
  vpc_id            = aws_vpc.base.id
  cidr_block        = var.zones[count.index].public_subnet
  availability_zone = var.zones[count.index].zone

  tags = {
    Name = "${var.prefix}-public-subnet-${count.index}"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.zones)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  count = length(var.zones)
  vpc   = true
}

resource "aws_nat_gateway" "base" {
  count         = length(var.zones)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "${var.prefix}-nat-${count.index}"
  }
}

resource "aws_route_table" "private" {
  count  = length(var.zones)
  vpc_id = aws_vpc.base.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.base[count.index].id
  }

  tags = {
    Name = "${var.prefix}-private-rt-${count.index}"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.zones)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
