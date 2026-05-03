#!/bin/bash
cd /home/ubuntu
sudo apt update &&
sudo apt install -y python3 python3-pip python3-venv virtualenv ansible-core

sudo tee playbook.yml > /dev/null <<'EOT'
- hosts: localhost
  become: yes
  tasks:
  - name: Git Clone
    ansible.builtin.git:
      repo: https://github.com/alura-cursos/clientes-leo-api.git
      dest: /home/ubuntu/tcc
      version: master
      force: yes
  - name: Instala setuptools na virtualenv
    pip:
      virtualenv: /home/ubuntu/tcc/virtualenv
      virtualenv_command: python3 -m venv
      name: setuptools
      state: present
  - name: Instalando Depedencias do Django & Djangorestframework
    pip:
      virtualenv: /home/ubuntu/tcc/virtualenv
      requirements: /home/ubuntu/tcc/requirements.txt
  - name: Alterando os hosts do settings
    lineinfile:
      path: /home/ubuntu/tcc/setup/settings.py
      regex: 'ALLOWED_HOSTS'
      line: 'ALLOWED_HOSTS = ["*"]'
      backrefs: yes
  - name: configurando o banco de dados
    shell: '. /home/ubuntu/tcc/virtualenv/bin/activate; python /home/ubuntu/tcc/manage.py migrate'
  - name: carregando dados do banco
    shell: '. /home/ubuntu/tcc/virtualenv/bin/activate; python /home/ubuntu/tcc/manage.py loaddata clientes.json'
  - name: iniciando o servidor django
    shell: |
      cd /home/ubuntu/tcc
      . virtualenv/bin/activate
      nohup python manage.py runserver 0.0.0.0:8000 > django.log 2>&1 & 
    async: 10 
    poll: 0
  - name: Aguarda o servidor Django ficar ativo
    wait_for:
      port: 8000
      host: '0.0.0.0'
      delay: 2
      timeout: 30
    become: no

EOT

sudo ./terraform3/ambientes/producao/execution.sh
#sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
#sudo python3 get-pip.py
#sudo python3 -m pip install ansible