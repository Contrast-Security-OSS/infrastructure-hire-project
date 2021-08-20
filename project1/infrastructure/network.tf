
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = "${var.project_name_prefix}-vpc"
  }
}

# Create public subnet
resource "aws_subnet" "public_subnet" {
  cidr_block              = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, 0)
  availability_zone       = var.aws_zone
  vpc_id                  = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name_prefix}-public-subnet"
  }
}

# Create private subnet
resource "aws_subnet" "private_subnet" {
  cidr_block            = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, 1)
  availability_zone     = var.aws_zone
  vpc_id                = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name_prefix}-private-subnet"
  }
}

# Create Gateway for the public subnet
resource "aws_internet_gateway" "public_gw" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags = {
    Name = "${var.project_name_prefix}-internet-gateway"
  }
}

# Create a route table for the private subnet
resource "aws_route_table" "public_rt" {    # Creating RT for Public Subnet
  vpc_id =  aws_vpc.main_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.public_gw.id
  }
}

# Associate public route table to the private subnet
resource "aws_route_table_association" "public_rta" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

# Create a NAT gateway with an EIP for private subnet to get internet connectivity
resource "aws_eip" "gw" {
  vpc        = true
  depends_on = [aws_internet_gateway.public_gw]
}

# Create NAT Gateway using the public subnet
resource "aws_nat_gateway" "gw" {
  subnet_id     = aws_subnet.public_subnet.id
  allocation_id = aws_eip.gw.id

  tags = {
    Name = "${var.project_name_prefix}-nat-gateway"
  }
}

# Create a route table for the private subnet
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"        # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.gw.id
  }
}

# Associate private route table to the private subnet
resource "aws_route_table_association" "private_rta" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}
