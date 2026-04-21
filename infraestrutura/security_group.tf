resource "aws_security_group" "acesso-dev" {
    name = var.grupodeseguranca
#    name = "acesso-dev"
#    description = "acesso squad desenvolvimento"
    
    ingress{
        cidr_blocks = [ "0.0.0.0/0" ]
        ipv6_cidr_blocks = [ "::/0" ]
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
    egress{
        cidr_blocks = [ "0.0.0.0/0" ]
        ipv6_cidr_blocks = [ "::/0" ]
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
    tags = {
        name = "sg-acesso"
    }
}
/*
resource "aws_security_group" "acesso-prod" {
    name = "acesso-prod"
    description = "acesso squad producao"
    ingress{
        cidr_blocks = [ "0.0.0.0/0" ]
        ipv6_cidr_blocks = [ "::/0" ]
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
    egress{
        cidr_blocks = [ "0.0.0.0/0" ]
        ipv6_cidr_blocks = [ "::/0" ]
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
    tags = {
        name = "acesso-produção"
    }
}

locals {
  security_group_id = var.ambiente == "acesso-dev" ? aws_security_group.acesso-dev.id : aws_security_group.acesso-prod.id
}
*/

/*
output "security_group_id_desenvolvimento" {
  #value = length(aws_security_group.acesso-dev.id) > 0 ? aws_security_group.acesso-dev.id : null # Altere para o nome que você definiu
  #value = length(aws_security_group.acesso-dev) > 0 ? aws_security_group.acesso-dev[0].id : ""
  value = aws_security_group.acesso-dev.id
}

output "security_group_id_producao" {
  #value = length(aws_security_group.acesso-prod.id) > 0 ? aws_security_group.acesso-prod.id : null
  #value = length(aws_security_group.acesso-prod) > 0 ? aws_security_group.acesso-dev[0].id : ""
  value = aws_security_group.acesso-prod.id
}

output "id_securitygroup" {
  value = var.id_grupo_de_segurança
}*/