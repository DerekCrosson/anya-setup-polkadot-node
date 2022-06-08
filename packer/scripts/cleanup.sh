#!/bin/bash -eux

apt -y remove --purge ansible
apt-add-repository --remove ppa:ansible/ansible

apt -y autoremove
apt -y update