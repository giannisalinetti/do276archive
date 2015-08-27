# Java EE To Do List

The following commands run the application as linked containers.
Be sure to verify the database is running before executing the second command.
Change container names as appropriate.

docker run -d --name mysql -e MYSQL_DATABASE=items -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 -e MYSQL_ROOT_PASSWORD=r00tpa55 mysql

docker run -d -e MYSQL_DB_NAME=items -e MYSQL_DB_USERNAME=user1 -e MYSQL_DB_PASSWORD=mypa55 --link mysql:mysql --name eap -p 8080:8080 todojee
