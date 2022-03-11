vagrant box
vagrant box list
vagrant box add <name>
vagrant plugin list

--------------------------
Images : 

vagrant box add centos/6 # for CentOS Linux 6, or...
vagrant box add centos/7 # for CentOS Linux 7

--------------------------
upgrade :

vagrant box update --box centos/6
vagrant box update --box centos/7

--------------------------
Verifying the integrity of the images : 

curl http://cloud.centos.org/centos/7/vagrant/x86_64/images/sha256sum.txt.asc -o sha256sum.txt.asc
gpg --verify sha256sum.txt.asc

--------------------------
Vagrant file :
 
Vagrant init

--------------------------
Vagrantfile config example : 

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  config.vm.provider :virtualbox do |virtualbox, override|
    virtualbox.memory = 1024
    override.vm.box_download_checksum_type = "sha256"
    override.vm.box_download_checksum = "b24c912b136d2aa9b7b94fc2689b2001c8d04280cf25983123e45b6a52693fb3"
    override.vm.box_url = "https://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1803_01.VirtualBox.box"
  end
end

--------------------------
Execute : 

vagrant up
vagrant ssh
sudo su

Close : vagrant halt

Destroy : vagrant destroy
Reload : vagrant reload
Free ram : free -h
System : nproc 
Provision : vagrant provision
Suspend : vagrant suspend

--------------------------
kubectl :

kubectl get all --all-namespaces
kubectl cluster-info
k get nodes -o wide

--------------------------

P1 :

vagrant init centos/7
vagrant plugin install vagrant-vbguest

ssh private key solution : https://terryl.in/en/vagrant-up-hangs/
Config : https://www.vagrantup.com/docs/providers/virtualbox/configuration
Kubectl : https://levelup.gitconnected.com/
K3s : https://rancher.com/docs/k3s/latest/en/
local-kubernetes-development-using-vagrant-and-k3s-547bd5687a7f
Multi machine : https://www.vagrantup.com/docs/multi-machine