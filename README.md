# DO276
DO276 Solution Files

The source in this repository creates:

* Docker images for each application environment
* To Do List application for each language/framework

Folders:

* `apps` - source code for the To Do List application using different runtimes. `runtime` folders, such as `jee` " are "combo" apps to run outside containers and accessing a local mysql database. `runtime_api` such as `jee-api` are just the HTTP API implementations, accessed by the AngularJS front end at `html5` and designed to run as three containers: one for the AngularJS front end, other for the HTTP API back end, and the third one for the mysql database.

* `deploy` - scripts and other supporting files to run each version of the application inside containers, using either docker links and kubernetes. Also included are Dockerfiles to derive applicaton images from the runtime images on the images folder.

* `dev` - UNMAINTAINED GUI developer workstation.

* `docs` - application and lab design documentation (probably not 100% accurate by now)

* `host` - vagrant box to run the application both inside and outside containers

* `images` - Dockerfiles and support files to build specific runtime images using RHEL7 and the SCL.

