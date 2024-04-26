FROM quay.io/jupyter/pyspark-notebook

WORKDIR /home/jovyan

COPY src/ ./src/

RUN pip install --no-cache-dir -r /home/jovyan/src/requirements.txt && fix-permissions "${CONDA_DIR}" && fix-permissions "/home/${NB_USER}"

CMD ["start-notebook.sh"]
