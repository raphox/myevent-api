# My Event API

Aplicação desenvolvida com intuito de demonstrar minha capacidade técnica em Ruby on Rails e conhecimentos em geral.

O projeto foi hospedado em https://myevent-api.herokuapp.com/my_events.

Um exemplo de consumo pode ser acesso em https://jsbin.com/rudeboj/edit?html,output.

A documentação da API pode ser acessada em http://docs.raphoxmyeventapi.apiary.io/.

## Requisitos

* Ruby 2.4.1+
* Ruby on Rails 5.1.4+
* MongoDB 3.4.6+
* sidekiq 5+
* Elasticsearch 1.7.6+

## Features

* CRUD do *model* `MyEvent`
* Metodo de consulta de registro por string para popular sugestões de um *autocomplete* do *model* `MyEvent`
* API RESTful em formato JSON API
* Indexação de dados com Elasticsearch para otimizar consultas de registros
* Utilizado MongoDB para aumentar a capacidade de inserção de registros
* Uitilizado Sidekiq para não prejudicar o desempenho do MongoDB durante a inserção de registros
