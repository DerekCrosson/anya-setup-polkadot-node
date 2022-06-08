#!/bin/bash -eux

apt -y update && apt-get -y upgrade
apt -y install software-properties-common
apt-add-repository ppa:ansible/ansible

apt -y update
apt -y install ansible
