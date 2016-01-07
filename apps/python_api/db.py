import os


class db:
    username = os.environ.get("MYSQL_ENV_MYSQL_USER", 'user1')
    password = os.environ.get("MYSQL_ENV_MYSQL_PASSWORD", 'mypa55')
    host = os.environ.get("MYSQL_PORT_3306_TCP_ADDR", '127.0.0.1')
    port = os.environ.get("MYSQL_PORT_3306_TCP_PORT", '3306')
    name = os.environ.get("MYSQL_DB_NAME", 'items')

