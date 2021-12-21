# Create the VPC
resource "aws_vpc" "vpc_prod" {
  cidr_block  = var.vpc_prod_cidr
  tags        = local.common_tags
}

# Public subnet
resource "aws_subnet" "public_subnet" {
  count             = length(var.public_cidr)
  availability_zone = var.azs[count.index]
  vpc_id            = aws_vpc.vpc_prod.id
  cidr_block        = var.public_cidr[count.index]
  tags              = local.common_tags
}

# Private subnet
resource "aws_subnet" "private_subnet" {
  count             = length(var.private_cidr)
  availability_zone = var.azs[count.index]
  vpc_id            = aws_vpc.vpc_prod.id
  cidr_block        = var.private_cidr[count.index]
  tags              = local.common_tags
}

# Internet GW for public subnets
resource "aws_internet_gateway" "my_inet_gw" {
  vpc_id = aws_vpc.vpc_prod.id
  tags   = local.common_tags
}

# Route table for public subnets
resource "aws_route_table" "public_rt" {
  depends_on   = [
    aws_internet_gateway.my_inet_gw
  ]
  vpc_id       = aws_vpc.vpc_prod.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_inet_gw.id
  }
}

# Route table for private subnets
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc_prod.id
}

# Route association for public subnet
resource "aws_route_table_association" "public_rta" {
  count           = length(var.private_cidr)
  subnet_id       = element(aws_subnet.public_subnet.*.id,count.index)
  route_table_id  = aws_route_table.public_rt.id
}

# Route association for private subnet
resource "aws_route_table_association" "private_rta" {
  count           = length(var.public_cidr)
  subnet_id       = element(aws_subnet.private_subnet.*.id,count.index)
  route_table_id  = aws_route_table.private_rt.id
}