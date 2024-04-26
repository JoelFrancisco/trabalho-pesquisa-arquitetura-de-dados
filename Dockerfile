FROM quay.io/jupyter/pyspark-notebook

WORKDIR /home/jovyan

COPY src/ ./src/

RUN pip install --no-cache-dir -r /home/jovyan/src/requirements.txt

CMD ["start-notebook.sh"]
