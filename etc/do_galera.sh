#!/usr/bin/env bash

sudo sh -c '
echo "
gathering = smart
fact_caching = jsonfile
fact_caching_connection = ~/.ansible/cache
" >> /etc/ansible/ansible.cfg'

git clone https://github.com/adfinis-sygroup/mariadb-ansible-galera-cluster

cd mariadb-ansible-galera-cluster
echo "[galera_cluster]
192.168.47.21 ansible_user=vagrant ansible_become=true
192.168.47.22 ansible_user=vagrant ansible_become=true
192.168.47.23 ansible_user=vagrant ansible_become=true
" > galera.hosts

ansible-playbook -i galera.hosts galera.yml --tags setup

ansible-playbook -i galera.hosts galera.yml --skip-tags setup

ansible-playbook -i galera.hosts galera_bootstrap.yml

ansible-playbook -i galera.hosts galera_rolling_update.yml
