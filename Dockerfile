FROM quay.io/jupyter/pyspark-notebook

WORKDIR /home/jovyan

COPY src/ ./src/

RUN pip install --trusted-host pypi.python.org -r /home/jovyan/src/requirements.txt

CMD ["start-notebook.sh"]
