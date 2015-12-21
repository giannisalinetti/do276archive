# DO276 Angular-based HTML5 To Do List app front-end

Start one of the backends and run the build.sh script.

The build.sh script copies the HTML pages to Apache and them starts the httpd24-httpd systemd service.

Open a web browser and visit http://localhost:30000/todo to run the application outside containers.

The SCL httpd24 daemon has to be configured to listen in this alternate port to not conflict with the RHEL7 httpd daemon which is used to emulate UCF classroom services. Start and stop the httpd24-httpd service as needed so it won't conflict with the containerized version of the front end.

The font end expects to find the back end at http://api.example.com:30080/todo/api/ so the developer needs to configure his workstation to make api.example.com point to 127.0.0.1 or whatever IP the back end is listening to.

