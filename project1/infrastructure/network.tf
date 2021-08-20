### VPC

data "aws_availability_zones" "available_zones" {
  state = "available"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = "${var.project_name_prefix}-vpc"
  }
}

# Create public subnet
resource "aws_subnet" "public_subnets" {
  count                   = var.aws_az_count
  cidr_block              = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  vpc_id                  = aws_vpc.main_vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name_prefix}-public-subnet"
  }
}

# Create private subnet
resource "aws_subnet" "private_subnets" {
  count                 = var.aws_az_count
  cidr_block            = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, var.aws_az_count + count.index)
  availability_zone     = data.aws_availability_zones.available_zones.names[count.index]
  vpc_id                = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name_prefix}-private-subnet"
  }
}

# Create Gateway for the public subnet
resource "aws_internet_gateway" "public_gw" {
  vpc_id = aws_vpc.main_vpc.id

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
    count          = var.aws_az_count
    subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
    route_table_id = element(aws_route_table.public_rt.*.id, count.index)
}

#Create a NAT gateway with an EIP for private subnet to get internet connectivity
resource "aws_eip" "gw" {
  count      = var.aws_az_count
  vpc        = true
  depends_on = [aws_internet_gateway.public_gw]
}

# Create NAT Gateway using the public subnet
resource "aws_nat_gateway" "gw" {
  count      = var.aws_az_count
  subnet_id     = element(aws_subnet.public_subnets.*.id, count.index)
  allocation_id = element(aws_eip.gw.*.id, count.index)

  tags = {
    Name = "${var.project_name_prefix}-nat-gateway-${var.aws_az_count}"
  }
}

# Create a route table for the private subnet
resource "aws_route_table" "private_rt" {
  count      = var.aws_az_count
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"        # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = element(aws_nat_gateway.gw.*.id, count.index)
  }
}

# Associate private route table to the private subnet
resource "aws_route_table_association" "private_rta" {
  count          = var.aws_az_count
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private_rt.*.id, count.index)
}

## Security

# Restrict access to only port 80
resource "aws_security_group" "lb_sg" {
  name        = "tf-ecs-alb"
  description = "controls access to the ALB"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Traffic to the ECS Cluster should only come from the ALB
resource "aws_security_group" "ecs_tasks" {
  name        = "${var.project_name_prefix}-tasks"
  description = "allow inbound access from the ALB only"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    protocol        = "tcp"
    from_port       = var.app_port
    to_port         = var.app_port
    security_groups = [aws_security_group.lb_sg.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### ALB

resource "aws_alb" "main_alb" {
  name            = "${var.project_name_prefix}-app"
  subnets         = aws_subnet.public_subnets.*.id
  security_groups = [aws_security_group.lb_sg.id]
}

resource "aws_alb_target_group" "app" {
  name        = "${var.project_name_prefix}-app"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main_vpc.id
  target_type = "ip"
}

# Redirect traffic ALB -> ALB target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main_alb.id
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}