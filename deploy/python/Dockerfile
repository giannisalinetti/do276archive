FROM	do276/python
RUN     source /etc/profile.d/enable-python34.sh && pip install mysql-connector-python --allow-external mysql-connector-python
EXPOSE	8080
USER	appuser

ADD	./run.sh ./

CMD	["./run.sh"]
#CMD	["md5sum", "/dev/zero", ">/dev/null"]
