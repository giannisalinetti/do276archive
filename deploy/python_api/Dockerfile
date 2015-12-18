FROM	do276/todoapi_python
RUN     python --version
RUN     sh /etc/profile.d/enable-python34.sh && pip install mysql-connector-python --allow-external mysql-connector-python
EXPOSE	8080
USER	appuser

ADD	./run.sh ./

CMD	["./run.sh"]
