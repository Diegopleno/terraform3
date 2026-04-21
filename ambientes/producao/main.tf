module "aws-prod" {
  source = "../../infraestrutura"
  regiao_aws = "us-east-1"
  instancia = "t2.micro"
  ssh_key = "chave-prod"
  nomegrupo = "prod"
  minimo = 1
  maximo = 10
  grupodeseguranca = "producao"
}