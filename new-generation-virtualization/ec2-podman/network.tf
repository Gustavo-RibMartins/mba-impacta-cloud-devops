resource "aws_vpc" "vpc_podman" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc_podman"
  }
}

resource "aws_subnet" "vpc_podman_subnet_pub_1a" {
  vpc_id            = aws_vpc.vpc_podman.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "vpc_podman_public_subnet_1a"
  }
}

resource "aws_internet_gateway" "igw_podman" {
  vpc_id = aws_vpc.vpc_podman.id

  tags = {
    Name = "igw_podman"
  }
}

resource "aws_route_table" "rt_public_podman" {
  vpc_id = aws_vpc.vpc_podman.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_podman.id
  }

  tags = {
    Name = "rt_public_podman"
  }
}

resource "aws_route_table_association" "vpc_podman_subnet_pub_1a_associate" {
  subnet_id      = aws_subnet.vpc_podman_subnet_pub_1a.id
  route_table_id = aws_route_table.rt_public_podman.id
}

output "vpc_podman_id" {
  value = aws_vpc.vpc_podman.id
}

output "vpc_podman_arn" {
  value = aws_vpc.vpc_podman.arn
}

output "vpc_podman_subnet_pub_1a_id" {
  value = aws_subnet.vpc_podman_subnet_pub_1a.id
}
