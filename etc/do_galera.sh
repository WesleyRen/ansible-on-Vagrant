#!/usr/bin/env bash

sudo sh -c '
echo "
gathering = smart
fact_caching = jsonfile
fact_caching_connection = ~/.ansible/cache
" >> /etc/ansible/ansible.cfg'

playbook_dir=mariadb-ansible-galera-cluster
ts=$(date "+%Y.%m.%d-%H.%M.%S")
[ -d $playbook_dir ] && mv $playbook_dir $playbook_dir.$ts
git clone https://github.com/adfinis-sygroup/$playbook_dir

cd $playbook_dir
echo "[galera_cluster]
galera-db-1 ansible_host=192.168.47.21 ansible_user=vagrant ansible_become=true
galera-db-2 ansible_host=192.168.47.22 ansible_user=vagrant ansible_become=true
galera-db-3 ansible_host=192.168.47.23 ansible_user=vagrant ansible_become=true
" > galera.hosts

ansible-playbook -i galera.hosts galera.yml --tags setup

ansible-playbook -i galera.hosts galera.yml --skip-tags setup

ansible-playbook -i galera.hosts galera_bootstrap.yml

ansible-playbook -i galera.hosts galera_rolling_update.yml
