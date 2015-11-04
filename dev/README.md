
# Dev environment for DO276

This Vagrant Box adds GUI desktop (Gnome3) to the Host environment, plus a host of development tools for Java EE, Node.js, Ruby, Python and PHP.

The Geany programmer's editor is also present if you prefer ssh -X than using the VM console, as  RHEL7 Gtk3 apps such as gedit do not work well over SSH.

If you wanna run JBDS/Eclipse (not installed in this box) you have to execute them using `SWT_GTK3=0`.

Wildfly is configured with port-offset 1000 to avoid conflict with Kubernetes.

Dockerfiles and sample applications can be found at: `https://github.com/jimrigsbee/do276.git`


## Tested under RHEL7 using:

(Copyed from host/README.md)

* `VirtualBox-5.0-5.0.8_103449_el7-1.x86_64`
* `vagrant-1.7.4-1.x86_64`
* `rhel-server-libvirt-7.1-3.x86_64.box`
* CDK 1.0
  * `vagrant-atomic-0.0.3.gem`
  * `vagrant-registration-0.0.8.gem`

