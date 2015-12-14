
# Host environment for DO276

This Vagrant Box has the minimal setup to build the base container images, the application container images, and test them using either docker links or kubernetes.

Dockerfiles and sample applications can be found at: `https://github.com/jimrigsbee/do276.git`

## Non-GUI Development Environment Setup
* Install vagrant and plugins
  * Install vagrant from http://vagrantup.com
  * Install virtualbox 5.x from http://virtualbox.org
  * Install the RHEL registration plugin, vagrant-registration:
    * vagrant plugin install vagrant-registration
* Download the RHEL 7.2 Vagrant box 
  * https://access.redhat.com/downloads/content/293/ver=2/rhel---7/2.0.0/x86_64/product-software
  * download RHEL 7.2 Vagrant box for VirtualBox
  * add box to vagrant cache:
    * vagrant box add --name rhel-7.2 ~/Downloads/rhel-cdk-kubernetes-7.2-6.x86_64.vagrant-virtualbox.box
* Copy the user home Vagrantfile to ~/.vagrant.d
  * edit the .vagrant.d/Vagrantfile, change username and password for access.redhat.com
  * copy the Vagrantfile to ~/.vagrant.d
  * This will cause Vagrant to automatically use these credentials during registration
* Start the vagrant machine
  * From the do276/host directory
    * vagrant up --provider virtualbox
    * BUG BUG BUG - The vagrant box appears to have a bug - the DEVICE="eth0" is missing from /etc/sysconfig/network-scripts/ifcfg-eth0
    * Vagrant will complain it cannot connect - bring up VirtualBox and login to the workstation with a terminal, sudo su -, and fix the file, ifup eth0 and you should be good to go
* Enjoy!
  * vagrant ssh
* Turn off auto_config on the private network
  * Vagrant has a bug and will try to change the first NIC's IP address
  * Comment out the first line and uncomment the second in the Vagrantfile
  * The line begins config.vm.network :private_network...
