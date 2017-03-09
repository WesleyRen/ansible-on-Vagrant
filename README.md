# ansible-on-Vagrant #

## pre-requisit: ##
* latest Vagrant (1.9.1 version has issues with private ip setup).

## how to use this ##

* Clone this repo.
* Make sure you have latest box image, to minimize updates needed:
* start up db Vagrant boxes
* start up Ansible Vagrant boxes

You may copy and paste following example:
~~~~
git clone https://gecgithub01.walmart.com/wren1/ansible-on-Vagrant.git
pushd ansible-on-Vagrant; vagrant box update
pushd db-hosts; vagrant up; popd;
pushd ansible-host; vagrant up; popd
~~~~
