#!/bin/bash

echo "Installing net-tools..."
yum -y install net-tools

echo "Installing k3s"
sudo systemctl disable firewalld --now
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="
  --node-ip=192.168.42.110
  --bind-address=192.168.42.110
  --advertise-address=192.168.42.110
  --write-kubeconfig-mode=644" sh -

# mkdir -p /vagrant/token
# sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/token

echo "alias k='kubectl'" >> /home/vagrant/.bashrc

# kubectl apply -f FILENAME
# k apply -f ./deployment.yaml