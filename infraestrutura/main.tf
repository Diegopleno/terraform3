terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"
}

resource "aws_launch_template" "maquina"{
  image_id = "ami-0007e082d5009529b"
  instance_type = var.instancia
  key_name = var.ssh_key
  tags = {
    Name = "Instância EC2"
  }
  security_group_names = [ var.grupodeseguranca ]
}

resource "aws_key_pair" "ChaveSSH" {
  key_name = var.ssh_key
  public_key = file("${var.ssh_key}.pub")
}

resource "aws_autoscaling_group" "grupo" {
  availability_zones = [ "${var.regiao_aws}a" ]
  name = var.nomegrupo
  max_size = var.maximo
  min_size = var.minimo
  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
}