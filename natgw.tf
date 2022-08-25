# Criacao do Nat GW
resource "aws_eip" "nat-eip" {
  vpc = true
}

resource "aws_nat_gateway" "orion-natgw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.orion-subnet-public-1.id
  depends_on    = [aws_internet_gateway.orion-igw]
}

# Criando Route Tables para as Subnets Privadas usando NAT
resource "aws_route_table" "orion-rt-private" {
  vpc_id = aws_vpc.orion-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.orion-natgw.id
  }

  tags = {
    Name = "orion-private-1"
  }
}

# Criando associacao entre a Route Table+NATGW e as Subnets Privadas
resource "aws_route_table_association" "orion-rtassociation-private-1" {
  subnet_id      = aws_subnet.orion-subnet-private-1.id
  route_table_id = aws_route_table.orion-rt-private.id
}

resource "aws_route_table_association" "orion-rtassociation-private-2" {
  subnet_id      = aws_subnet.orion-subnet-private-2.id
  route_table_id = aws_route_table.orion-rt-private.id
}
