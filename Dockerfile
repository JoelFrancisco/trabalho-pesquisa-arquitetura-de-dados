FROM quay.io/jupyter/pyspark-notebook

WORKDIR /home/jovyan

COPY src/ ./src/

CMD ["start-notebook.sh"]
