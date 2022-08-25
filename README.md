# Projeto Orion
Criando Infraestrutura cloud na AWS com Terraform e Packer

### Instalação do Terraform - Versão v1.2.7
- [ ] [Para baixar o Terraform, clique aqui](https://www.terraform.io/downloads)

### Instalação do Packer - Versão v1.8.3
- [ ] [Para baixar o Packer, clique aqui](https://www.packer.io/docs/install)

### Módulo AWS Versão 4.27.0
- [ ] [](https://registry.terraform.io/providers/hashicorp/aws/4.27.0)

## Iniciando

Criando uma estrutura na AWS com redundância em duas Zonas de Disponibilidade na Região da Europa (Irlanda - eu-west-1), utilizando Terraform
e Packer.

### Executando o Deploy

Todos os arquivos de configuração da estrutura estão na raíz do projeto, e dentro do diretório *"scripts"* guardaremos os scripts executados pelo Packer.

Para acesso à AWS, utilizaremos a conta (IAM User) chamada *"terraform"*. As credenciais podem ser usadas via prompt, quando solicitada pela execução do script de build, ou em arquivo local de variáveis chamada terraform.tfvars, o qual por razões de segurança está na exceção do Git *".gitignore"*

A execução do deploy (build da imagem customizada e executação do Terraform) é simplificada pelo script *"build-and-launch.sh"*:

```
# Clone o repositório
git clone https://github.com/ednaldogr/terraform.git <diretório local> ou
git clone git@github.com:ednaldogr/terraform.git <diretório local> <-- Caso tenha chave adicionada ao repositório
cd <diretório local>
# Antes de executar o script de build, crie um par de chaves SSH para ser utilizada na conexão das instâncias EC2:
ssh-keygen -f mykey
# Agora confirme a permissão para execução e execute o script
chmod +x build-and-launch.sh
./build-and-launch.sh
# Confirme as informações referente à infraestrutura que será criada e digite "yes"
# Ao final da execução o Terraform informará o FQDN do Load Balancer, então poderemos testar via browser, ou via linha de comando:
curl <FQDN do ALB>
```

### Estrutura de rede
A estrutura conta com uma VPC, duas subnets públicas, e duas subnets privadas, distribuídas entre as AZ's (eu-west-1a e eu-west-1b)

- Range de IP atribúido à *VPC*: "10.0.0.0/16"
- Range de IP atríbuido à *Subnet Pública* em eu-west-1a *(orion-subnet-public-1)*
- Range de IP atríbuido à *Subnet Privada* em eu-west-1a *(orion-subnet-private-1)*
- Range de IP atríbuido à *Subnet Pública* em eu-west-1b *(orion-subnet-public-2)*
- Range de IP atríbuido à *Subnet Privada* em eu-west-1b *(orion-subnet-private-2)*

As subnets públicas serão associadas ao Internet Gateway *orion-igw*, e as subnets privadas ao Nat Gateway *orion-natgw*

### Instâncias e Balanceador de Carga

A estrutura terá como balanceador de carga o Application Gateway *orion-alb* que distribuirá o tráfego para as instâncias EC2 gerenciadas pelo Auto Scaling Group *orion-autoscaling*
utilizando uma imagem customizada do Ubuntu através da ferramenta Packer.

As instâncias EC2 são provisionadas através do Launch Configuration *"orion-launchconfig"*, e gerenciada pelo Auto Scaling Group *"orion-autoscaling"* podendo ser dimensionado da forma necessária.


### Métricas utilizadas

Além da utilização do Application Load Balancer, utilizaremos metríca baseada em consumo de CPU como política para o nosso Auto Scaling, através do serviço Amazon CloudWatch, configurado no arquivo *autoscalingpolicy.tf*



