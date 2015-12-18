FROM	do276/todoapi_python
RUN 	pip install mysql-connector-python --allow-external mysql-connector-python
EXPOSE	8080
USER	appuser

ADD	./run.sh ./

CMD	["./run.sh"]
