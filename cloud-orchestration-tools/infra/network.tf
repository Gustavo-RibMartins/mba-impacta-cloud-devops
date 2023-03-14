resource "aws_vpc" "vorx-vpc-prod" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Vorx-PRODUCAO"
  }
}

resource "aws_subnet" "vorx-subnet-pub-1a" {
  vpc_id            = aws_vpc.vorx-vpc-prod.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Public-Subnet-1a"
  }
}

resource "aws_subnet" "vorx-subnet-pub-1b" {
  vpc_id            = aws_vpc.vorx-vpc-prod.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Public-Subnet-1b"
  }
}

resource "aws_subnet" "vorx-subnet-priv-1a" {
  vpc_id            = aws_vpc.vorx-vpc-prod.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Private-Subnet-1a"
  }
}

resource "aws_subnet" "vorx-subnet-priv-1b" {
  vpc_id            = aws_vpc.vorx-vpc-prod.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Private-Subnet-1b"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vorx-vpc-prod.id

  tags = {
    Name = "igw-prod-vorx-vpc"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vorx-vpc-prod.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "prod-public-rt"
  }
}

resource "aws_route_table_association" "pub-rt-1a-associate" {
  subnet_id      = aws_subnet.vorx-subnet-pub-1a.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "pub-rt-1b-associate" {
  subnet_id      = aws_subnet.vorx-subnet-pub-1b.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table" "private-rt-1a" {
  vpc_id = aws_vpc.vorx-vpc-prod.id

  tags = {
    Name = "prod-private-rt-1a"
  }
}

resource "aws_route_table" "private-rt-1b" {
  vpc_id = aws_vpc.vorx-vpc-prod.id

  tags = {
    Name = "prod-private-rt-1b"
  }
}

resource "aws_route_table_association" "priv-rt-1a-associate" {
  subnet_id      = aws_subnet.vorx-subnet-priv-1a.id
  route_table_id = aws_route_table.private-rt-1a.id
}

resource "aws_route_table_association" "priv-rt-1b-associate" {
  subnet_id      = aws_subnet.vorx-subnet-priv-1b.id
  route_table_id = aws_route_table.private-rt-1b.id
}




output "vpc_vorx_prod_id" {
  value = aws_vpc.vorx-vpc-prod.id
}

output "vpc_vorx_prod_arn" {
  value = aws_vpc.vorx-vpc-prod.arn
}

output "vorx_prod_subnet_pub-1a" {
  value = aws_subnet.vorx-subnet-pub-1a.id
}

output "vorx_prod_subnet_priv-1a" {
  value = aws_subnet.vorx-subnet-priv-1a.id
}

output "vorx_prod_subnet_pub-1b" {
  value = aws_subnet.vorx-subnet-pub-1b.id
}

output "vorx_prod_subnet_priv-1b" {
  value = aws_subnet.vorx-subnet-priv-1b.id
}