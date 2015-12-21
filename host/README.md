
# Host environment for DO276

This Vagrant Box has the minimal setup to build the base container images, the application container images, and test them using either docker links or kubernetes.

Dockerfiles and sample applications can be found at: `https://github.com/jimrigsbee/do276.git`

Tested by flozano@redhat.com under RHEL 7.1 CSB and using:

* VirtualBox 5.0.8
* Vagrant 1.7.4
* CDK 2.0-beta3
  * vagrant-registration 1.0.0


## Non-GUI Development Environment Setup

* Install vagrant and plugins
  * Install vagrant from http://vagrantup.com
  * Install virtualbox 5.x from http://virtualbox.org
  * Install the RHEL registration plugin from CDK 2.0:
    * https://access.redhat.com/downloads/content/293/ver=2/rhel---7/2.0.0/x86_64/product-software
    * vagrant plugin install ~/cdk-2.0.0-beta3/plugins/vagrant-registration-1.0.0.gem
    * install the plugin using your regular user!
* Download the RHEL 7.2 Vagrant box 
  * download RHEL 7.2 Vagrant box for VirtualBox from:
  * `https://access.redhat.com/downloads/content/293/ver=2/rhel---7/2.0.0/x86_64/product-software`
  * add box to vagrant cache:
    * vagrant box add --name rhel-7.2 ~/Downloads/rhel-cdk-kubernetes-7.2-6.x86_64.vagrant-virtualbox.box
* OPTIONAL: Download latest CDK build to fix the DEVICE BUG
  * download `rhel-7.2-server-kubernetes-vagrant-scratch-7.2-1.x86_64.vagrant-virtualbox.box` from:
  * `http://cdk-builds.usersys.redhat.com/builds/11-Dec-2015/`
  * use this file to create the rhel-7.2 base vagrant box:
  * vagrant box remove rhel-7.2
  * vagrant box add --name rhel-7.2 ~/Downloads/rhel-7.2-server-kubernetes-vagrant-scratch-7.2-1.x86_64.vagrant-virtualbox.box
  * If you have already created your workstation box it have to be destroyed before replacing the base box
* From the do276/host directory
* Configure RHN credentials into $HOME/.vagrant.d
  * copy the template configuration file ./.vagrant.d/Vagrantfile to $HOME/.vagrant.d
  * edit the $HOME/.vagrant.d/Vagrantfile, change username and password for access.redhat.com
  * This will cause the Vagrant registration plugin to automatically use these credentials
* Start the vagrant machine
    * vagrant up --provider virtualbox
    * while vagrant is trying to connect perform the next step
    * BUG BUG BUG - The vagrant box appears to have a bug - the DEVICE="eth0" is missing from /etc/sysconfig/network-scripts/ifcfg-eth0
      * Vagrant will complain it cannot connect - bring up VirtualBox and login to the workstation with a terminal, sudo su -, and fix the file, ifup eth0 and you should be good to go
      * Maybe ifup fails for you, so systemctl restart NetworkManager
      * Log in using the VM console as 'vagrant' password 'vagrant'
      * User 'vagrant' already has sudo access
      * If you are fast enough vagrant up won't timeout.
      * If not, shutdown the VM on VirtualBox and vagrant up again
    * vagrant up may look frozen during registration and provisioning but it is ok.
* Enjoy!
  * vagrant ssh
  * you can 'su - student' to work like in UCF classroom
* Turn off auto_config on the private network
  * Vagrant has a bug and will try to change the first NIC's IP address
  * Comment out the first line and uncomment the second in the Vagrantfile
  * The line begins config.vm.network :private_network...

## Grading scripts

Thix box resolves content.example.com to 127.0.0.1 to simulate the grading infrastructure on a UCF classroom.

A sample grading script named 'example' is installed, you can enter the box as a student and run the sample grading script it using:

  `[flozano@flozano host]$ vagrant ssh -- -l student`

  `[student@workstation ~]$ lab example setup`

  `[student@workstation ~]$ lab example grade`

New scripts can be added to /content/courses/do276/atomic/grading-scripts.

During development, any content in the host folder is copied to /vagrant inside the box so you can use this to move content in an out the VM. Just don't commit this to the github project.

If you add any new grading scripts to your box remember to set the correct SELinux context:

$ sudo chcon -R --reference=/var/www /content

## Private Registry

Those steps are already in install.sh (which calls privatereg.sh)

* Sign on as root: sudo su -
* cd /vagrant
* sh privatereg.sh
* vi /etc/sysconfig/docker
  * add servera.example.com:5000 as added registry and insecure registry
  * systemctl restart docker
  * Those edits are now performed by privatereg.sh


## helper script

The shell script `up-with-contents.sh` was designed to help put container images and lab scripts inside the vagrant box. It copies the /contents folder from DO276 SVN and images saved as tar.gz in a local cache folder (default is $HOME) to the vagrant box and makes sure they are installed. In the end t clean up makes sure the docker daemon has no local images, all are only in the local private registry.

It is supposed to be run with the box halted (but not destroyed) and will up the box. In the end the script logs in as the student user.

To make it clear: Before using the helper script, vagrant up the VM at least one so it is provisioned. Then vagrant halt. Then run the script.

