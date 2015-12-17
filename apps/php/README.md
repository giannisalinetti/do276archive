# DO276 PHP/CakePHP To Do List App

Using httpd 2.4 and PHP 5.6 from SCL.

Based on PDO from SCL and Slim 2.6 downloaded using compose.

Should have provisions for CORS but was tested with front end and back end together in the same Apache Httpd instance. Maybe try using different virtual hosts for each one?

* Installing composer from RHEL7 official repos conflits with pythom-demjson from EPEL. Remove it.

`sudo yum remove python-demjson`

`sudo yum -y install composer`

* Install packages: rh-php56 rh-php56-php-pear rh-php56-php-pecl-jsonc rh-php56-php-mysqlnd rh-php56-php rh-php56-php-pdo

* Authorize httpd to connect to databases:

`sudo setsebool httpd_can_network_connect_db on`

* Change /opt/rh/httpd24/root/etc/httpd/conf/httpd.conf as follows because Slim needs .htaccess customization:

`<Directory "/opt/rh/httpd24/root/var/www/html">`

`...`

`    #AllowOverride None`

`    AllowOverride All`

* Edit /opt/rh/httpd24/service-environment so the httpd service from SCL sees PHP from SCL

`HTTPD24_HTTPD_SCLS_ENABLED="httpd24 rh-php56"`

* Restart systemd service httpd24-httpd

* Download dependencies from todo folder:

`composer require slim/slim`

* Copy app to apache docroot (where the todo front end is already installed)

`cd ..`

`cp -rp todo ~/do276/php/`

* Change frontend to access service in port 80

