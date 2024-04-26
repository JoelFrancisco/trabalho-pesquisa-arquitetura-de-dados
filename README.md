# trabalho-pesquisa-arquitetura-de-dados :space_invader:

## Reproduzindo o ambiente

As seguintes instruções foram feitas para Linux, não fornecemos instruções para Windows no momento

### Requisitos
 
- Git instalado (https://git-scm.com/book/pt-br/v2/Come%C3%A7ando-Instalando-o-Git)
- Docker instalado (https://www.docker.com/)
- Docker compose instalado (caso esteja em uma distro em que ele não é instalado junto ao pacote do docker favor instalar separadamente)

### Subindo o ambinete

Clone esse repositório 

Execute o docker compose 

```
docker compose up -d
```

Salve o nome do container que será iniciado

Execute, substituindo trabalho-pesquisa-arquitetura-de-dados-pyspark-notebook-1 pelo nome do container iniciado

```
docker logs trabalho-pesquisa-arquitetura-de-dados-pyspark-notebook-1 2>&1 | grep "http://127.0.0.1:8888/lab?token" | tail -n 1
```

Recebera como saída uma url como essa http://127.0.0.1:8888/lab?token=5e6616dcf5b16a4b7f87921ff3a36f9a414bc9a4f035b912

Acesse a url e encontrará o ambiente jupyter

## Dentro do projeto

- Inicia sessão, declara configs e bibliotecas
  
```python
import pyspark
from delta import *

builder = pyspark.sql.SparkSession.builder.appName("trabalho-pesquisa-arquitetura-de-dados") \
    .config("spark.sql.extensions","io.delta.sql.DeltaSparkSessionExtension") \
    .config("spark.sql.catalog.spark_catalog","org.apache.spark.sql.delta.catalog.DeltaCatalog")

spark = configure_spark_with_delta_pip(builder).getOrCreate()
```

- Criar dataframe pelo CSV

```python
df = spark.read.option("header", True).csv("/home/jovyan/data/Indain_Food_Cuisine_Dataset.csv")
```

- Criando as tabelas 
  
```python
# dishe_region
spark.sql("""CREATE TABLE dishe_region (id_region INTEGER, nome STRING) USING delta LOCATION '/home/jovyan/data/delta/dishe_region'""")
```

```python
# diet_type
spark.sql("""CREATE TABLE diet_type (id_diet INTEGER, description STRING) USING delta LOCATION '/home/jovyan/data/delta/diet_type'""")
```

```python
# dishe_instructions
spark.sql("""CREATE TABLE dishe_instructions (id_instructions INTEGER, id_dishes INTEGER, instructions_seq INTEGER, description STRING) USING delta LOCATION '/home/jovyan/data/delta/dishe_instructions'""")
```

```python
# dishe_type
spark.sql("""CREATE TABLE dishe_type (id_region INTEGER, name STRING) USING delta LOCATION '/home/jovyan/data/delta/dishe_type'""")
```

```python
# dishe_similar
spark.sql("""CREATE TABLE dishe_similiar (id_similiar_dishes INTEGER, id_dishes INTEGER, name STRING) USING delta LOCATION '/home/jovyan/data/delta/dishe_similiar'""")
```

```python
# dishe_ingredients
spark.sql("""CREATE TABLE dishe_ingredients (id_ingredients INTEGER, id_dishes INTEGER, name STRING, description STRING, quantity FLOAT, unit_of_measurement STRING) USING delta LOCATION '/home/jovyan/data/delta/dishe_ingredients'""")
```

```python
# dishes
spark.sql("""CREATE TABLE dishes (id_dishes INTEGER, id_diet INTEGER, id_type INTEGER, description STRING, id_region INTEGER, rating INTEGER, id_similiar_dishes INTEGER, id_ingredients INTEGER, preparation_time INTEGER, cook_time INTEGER, makes INTEGER, id_instructions INTEGER) USING delta LOCATION '/home/jovyan/data/delta/dishes'""")
```

- Inserindo dados na tabela, (utilizando sem ser a sintaxe SQL-like para não precisar criar um tabela temporária)
  
```python
from pyspark.sql.functions import monotonically_increasing_id

dishe_region = df.select('Cuisine_name')

dishe_region = dishe_region.withColumn("id_region", monotonically_increasing_id().cast("int"))

dishe_region = dishe_region.withColumnRenamed("Cuisine_name", "nome")

dishe_region = dishe_region.withColumnRenamed("Cuisine_name", "nome")
```

- Select em uma tabela
  
```python
result = spark.sql("SELECT * FROM dishe_region")
result.show()
```

- Delete em uma tabela
  
```python
spark.sql("""DELETE FROM dishe_region WHERE id_region=1""")
```

- Update em uma tabela

```python
spark.sql("""DELETE FROM dishe_region WHERE id_region=1""")
```
