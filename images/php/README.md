# DO276 PHP/CakePHP Docker Image

Applications can include an approot.sh file to define env var APPROOT do pointing to the application root folder so composer gets executed there. This allows for having no PHP code in Apache http DocRoot folder (in a subdirectory of it) without having to configure Alias or RewriteRules.

