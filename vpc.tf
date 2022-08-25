# Criando a VPC
resource "aws_vpc" "orion-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "orion"
  }
}

# Criando as Subnets Publicas
resource "aws_subnet" "orion-subnet-public-1" {
  vpc_id                  = aws_vpc.orion-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1a"

  tags = {
    Name = "orion-subnet-public-1"
  }
}

resource "aws_subnet" "orion-subnet-public-2" {
  vpc_id                  = aws_vpc.orion-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1b"

  tags = {
    Name = "orion-subnet-public-2"
  }
}

# Criando as Subnets Privadas
resource "aws_subnet" "orion-subnet-private-1" {
  vpc_id                  = aws_vpc.orion-vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1a"

  tags = {
    Name = "orion-subnet-private-1"
  }
}

resource "aws_subnet" "orion-subnet-private-2" {
  vpc_id                  = aws_vpc.orion-vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1b"

  tags = {
    Name = "orion-subnet-private-2"
  }
}
