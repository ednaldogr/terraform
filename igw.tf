# Criando o Internet GW
resource "aws_internet_gateway" "orion-igw" {
  vpc_id = aws_vpc.orion-vpc.id

  tags = {
    Name = "orion-public"
  }
}

# Criando Route Tables para as Subnets Publicas
resource "aws_route_table" "orion-rt-public" {
  vpc_id = aws_vpc.orion-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.orion-igw.id
  }

  tags = {
    Name = "orion-public"
  }
}

# Criando associacao entre a Route Table+IGW e as Subnets Publicas
resource "aws_route_table_association" "orion-rtassociation-public-1" {
  subnet_id      = aws_subnet.orion-subnet-public-1.id
  route_table_id = aws_route_table.orion-rt-public.id
}

resource "aws_route_table_association" "orion-rtassociation-public-2" {
  subnet_id      = aws_subnet.orion-subnet-public-2.id
  route_table_id = aws_route_table.orion-rt-public.id
}
