module "aws-prod" {
  source = "../../infraestrutura"
  regiao_aws = "us-east-1"
  instancia = "t2.micro"
  ssh_key = "chave-prod"
#  ambiente = "acesso-prod" #grupo_de_segurança = module.network.security_group_id_producao
  grupodeseguranca = "producao"
}

output "ip_publico" {
  value = module.aws-prod.ip_publico
}
/* ip_publico = "aws_instance.app_server.id"
  id_da_instancia = "var.id_da_instancia"
  grupo_de_segurança = "acesso"
  id_grupo_de_segurança = "acesso"
}*/

/*
output "ip_publico" {
  value = module.aws-dev.ip_publico
  description = "Endereço IP publico"
}

output "id_da_instancia" {
  value = module.aws-dev.id_da_instancia
  description = "ID da instancia"
}
output "id_grupo_de_segurança" {
  value = module.aws-dev.id_securitygroup
  description = "ID grupo de segurança"
}
 output "id_securitygroup" {
  value = module.aws-id_securitygroup.acesso
 value = module.aws_security_group.acesso
  description = "ID do Grupo de segurança"
}*/