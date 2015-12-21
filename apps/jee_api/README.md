# DO276 Java/Java EE 7 To Do List App

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

