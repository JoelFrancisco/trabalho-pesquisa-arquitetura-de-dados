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

- Incia sessão, declara configs e bibliotecas e cria dataframe pelo CSV
  
  <img src="github/IMG_1.jpg">

- Criando as tabelas
  
  <img src="github/IMG_2.jpg">

- Inserindo dados na tabela, (utilizando sem ser a sintaxe SQL-like para não precisar criar um tabela temporaria)
  
  <img src="github/IMG_3.jpg">

- Select em uma tabela
  
  <img src="github/IMG_4.jpg">

- Delete em uma tabela
  
  <img src="github/IMG_5.jpg">

- Update em uma tabela

  <img src="github/IMG_6.jpg">
