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
  user_data = base64encode(join("\n", [file("ansible.sh"), file("execution.sh")]))
}

resource "aws_key_pair" "ChaveSSH" {
  key_name = var.ssh_key
  public_key = file("${var.ssh_key}.pub")
}

resource "aws_autoscaling_group" "grupo" {
  availability_zones = [ "${var.regiao_aws}a", "${var.regiao_aws}b" ]
  name = var.nomegrupo
  max_size = var.maximo
  min_size = var.minimo
  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
  target_group_arns = [ aws_lb_target_group.targetLoadbalancer.arn ]
}

resource "aws_default_subnet" "subnet_1" {
  availability_zone = "${var.regiao_aws}a"
  
}

resource "aws_default_subnet" "subnet_2" {
  availability_zone = "${var.regiao_aws}b"
  
}

resource "aws_lb" "loadBalancer" {
  internal = false
  subnets = [ aws_default_subnet.subnet_1.id, aws_default_subnet.subnet_2.id ]
#  security_groups = [aws_security_group.acesso-dev.id]
}

resource "aws_lb_target_group" "targetLoadbalancer" {
  name = "maquinasAlvo"
  port = "8000"
  protocol = "HTTP"
  vpc_id = aws_default_vpc.default.id
}

resource "aws_default_vpc" "default" {
  
}

resource "aws_lb_listener" "entradaLoadBalancer" {
  load_balancer_arn = aws_lb.loadBalancer.arn
  port = "8000"
  protocol = "HTTP"
  default_action {
   type = "forward" 
   target_group_arn = aws_lb_target_group.targetLoadbalancer.arn
  }
}