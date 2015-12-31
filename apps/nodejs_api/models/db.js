
module.exports.params = {
    dbname: process.env.MYSQL_ENV_MYSQL_DATABASE || "items",
    username: process.env.MYSQL_ENV_MYSQL_USER || "user1",
    password: process.env.MYSQL_ENV_MYSQL_PASSWORD || "mypa55",
    params: {
        host: process.env.MYSQL_PORT_3306_TCP_ADDR || '127.0.0.1',
        port: process.env.MYSQL_PORT_3306_TCP_PORT || '3306',
        dialect: 'mysql'
    }
};

