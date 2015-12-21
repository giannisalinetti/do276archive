# DO276 Java/Java EE 7 To Do List App

Assumes your workstation -- the host that runs the Vagrant box VM -- /etc/hosts is configured with:

127.0.0.1 api.example.com

It is NOT enough to have this on the Vagrant Box as your workstation web browser needs to resolve api.example.com so the AngularJS front end can talk to
 the back end API

Assumes Wildlfy is configured to with port-offser 22000 so http port is 30080

Start Wildfly:

`$ cd ~/wildfly-*/bin`
`$ ./standalone.sh`

Open another terminal/session and run scripts in order:

`$ ./createDS.sh`
`$ . /build.sh`
`$ ./deploy.sh`
`$ ./test.sh`

Then start the HTML5 front-end

