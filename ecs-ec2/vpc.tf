locals {
  az_names        = data.aws_availability_zones.azs.names
  pub_sub_ids     = aws_subnet.public_subnet.*.id
  private_sub_ids = aws_subnet.private_subnet.*.id
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.name}-${var.environment}"
    Environment = var.environment
  }
}

#Private Subnet Creation
resource "aws_subnet" "private_subnet" {
  count             = length(local.az_names)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = local.az_names[count.index]
  tags = {
    Name        = "My VPC PrivateSubnet-${count.index + 1}"
    Environment = var.environment
  }
}


# Public Subnet Creation
resource "aws_subnet" "public_subnet" {
  count                   = length(local.az_names)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 3)
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true # indicate whether this is public or private subnet. true means public subnet
  tags = {
    Name        = "My VPC PublicSubnet-${count.index + 1}"
    Environment = var.environment
  }
}


# Internet Gateway Creation
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "My VPC IGW"
  }
}


# Route Table Creation
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "My VPC Route Table"
  }
}

# Route Table Association with subnet
resource "aws_route_table_association" "main" {
  count          = length(local.az_names)
  subnet_id      = local.pub_sub_ids[count.index]
  route_table_id = aws_route_table.main.id
}


# Create a NAT gateway with an Elastic IP for each private subnet to get internet connectivity
resource "aws_eip" "eip_gw" {
  count      = length(local.az_names)
  vpc        = true
  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "nat_gw" {
  count         = length(local.az_names)
  subnet_id     = element(aws_subnet.public_subnet.*.id, count.index)
  allocation_id = element(aws_eip.eip_gw.*.id, count.index)
}

# Create a new route table for the private subnets, make it route non-local traffic through 
# the NAT gateway to the internet
resource "aws_route_table" "private_rt" {
  count  = length(local.az_names)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_gw.*.id, count.index)
  }
}

# Explicitly associate the newly created route tables to the private subnets 
# (so they don't default to the main route table)
resource "aws_route_table_association" "private" {
  count          = length(local.az_names)
  subnet_id      = local.private_sub_ids[count.index]
  route_table_id = element(aws_route_table.private_rt.*.id, count.index)
}
