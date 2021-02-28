resource "aws_vpc" "vpc" {
  #name                 = "${var.name}-vpc-${var.environment}"
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.name}-vpc-${var.environment}"
    # Environment = "${terraform.workspace}"
  }
}




locals {
  az_names    = data.aws_availability_zones.azs.names
  pub_sub_ids = aws_subnet.my_public_subnet.*.id
}

# Public Subnet Creation
resource "aws_subnet" "my_public_subnet" {
  count                   = length(local.az_names)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "My VPC PublicSubnet-${count.index + 1}"
  }
}


# Internet Gateway Creation
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "My VPC IGW"
  }
}


# Route Table Creation
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "My VPC Route Table"
  }
}

# Route Table Association with subnet
resource "aws_route_table_association" "my_rt_association" {
  count          = length(local.az_names)
  subnet_id      = local.pub_sub_ids[count.index]
  route_table_id = aws_route_table.my_rt.id
}