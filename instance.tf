# Criacao da instancia chamada "orion"
resource "aws_instance" "orion" {
  ami           = lookup(var.AMIS, var.AWS_REGION, "")
  instance_type = "t2.micro"

  # Chave SSH (key.tf)
  key_name      = aws_key_pair.mykey.key_name

  # Configuracao para conexao SSH
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

  # Enviando a pagina estatica para a raiz do site provisionado pelo Nginx
  provisioner "file" {
    source      = "index.nginx-debian.html"
    destination = "/tmp/index.nginx-debian.html"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mv -f /tmp/index.nginx-debian.html /var/www/html/",
    ]
  }
}

# Informando o IP publico da instancia
output "ip" {
  value = aws_instance.orion.public_ip
}
