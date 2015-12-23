FROM	do276/php56
MAINTAINER Jim Rigsbee <jrigsbee@redhat.com>
EXPOSE 8080
USER appuser
RUN cd /todo/api && php composer.phar install

CMD	["scl","enable","httpd24","./run.sh"]
