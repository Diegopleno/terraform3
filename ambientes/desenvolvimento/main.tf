module "aws-dev" {
  source = "../../infraestrutura"
  regiao_aws = "us-east-1"
  instancia = "t2.micro"
  ssh_key = "chave-dev"
  nomegrupo = "dev"
  minimo = 0
  maximo = 1
  grupodeseguranca = "Desenvolvimento"
}

output "ip_publico" {
  value = module.aws-dev.ip_publico
}