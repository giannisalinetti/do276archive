FROM	do276/python34
RUN     source /etc/profile.d/enable-python34.sh && pip install mysql-connector-python --allow-external mysql-connector-python
EXPOSE	30080
USER	appuser

ADD	./run.sh ./

CMD	["./run.sh"]
