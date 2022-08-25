#!/bin/bash -v
# Usando o comando packer build para gerar imagem customizada
ARTIFACT=`packer build -machine-readable packer-orion.json |awk -F, '$0 ~/artifact,0,id/ {print $6}'`
AMI_ID=`echo $ARTIFACT | cut -d ':' -f2`
echo 'variable "AMI_ID" { default = "'${AMI_ID}'" }' > amivar.tf

# Executando o Terraform para provisionar a infraestrutura
terraform init
terraform apply
