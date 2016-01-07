<?php

$dsn = 'mysql:host='.$_ENV["MYSQL_PORT_3306_TCP_ADDR"] . ':' . $_ENV["MYSQL_PORT_3306_TCP_PORT"] .';dbname='.$_ENV["MYSQL_ENV_MYSQL_DATABASE"];
$user = $_ENV["MYSQL_ENV_MYSQL_USER"];
$pass = $_ENV["MYSQL_ENV_MYSQL_PASSWORD"];

?>
