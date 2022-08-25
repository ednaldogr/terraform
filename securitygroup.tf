# Regra para liberar meu IP para acesso SSH nas instancias
resource "aws_security_group" "allow-ssh" {
  vpc_id      = aws_vpc.orion-vpc.id
  name        = "allow-ssh"
  description = "Security Group acesso SSH somente para o meu IP e saida para qualquer lugar"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["191.181.58.23/32"]
  }
  tags = {
    Name = "allow-ssh"
  }
}


# Regra para liberar acesso HTTP e HTTPS nas instancias atraves do Application Load Balancer
resource "aws_security_group" "alb-securitygroup-web" {
  vpc_id      = aws_vpc.orion-vpc.id
  name        = "alb"
  description = "Security Group para o Application Load Balancer"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Permitindo HTTP de qualquer lugar
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Permitindo HTTPS de qualquer lugar
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "alb-securitygroup-web"
  }
}
