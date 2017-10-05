# My Event API

Aplicação desenvolvida com intuito de demonstrar minha capacidade técnica em Ruby on Rails e conhecimentos em geral.

O projeto foi hospedado em https://myevent-api.herokuapp.com/my_events.

Um exemplo de consumo pode ser acessado em https://jsbin.com/pitejuv/edit?html,css,output.

A documentação da API pode ser acessada em http://docs.raphoxmyeventapi.apiary.io/.

## Requisitos

* Ruby 2.4.1+
* Ruby on Rails 5.1.4+
* MongoDB 3.4.6+
* sidekiq 5+
* Elasticsearch 1.7.6+

## Features

* CRUD (create, read, update and delete) do *model* `MyEvent`
* Método de consulta de registro por *string* para popular sugestões de um *autocomplete* do *model* `MyEvent`
* API [RESTful](https://en.wikipedia.org/wiki/Representational_state_transfer) em formato [JSON API](http://jsonapi.org/)
* Indexação de dados com [Elasticsearch](https://www.elastic.co/products/elasticsearch) para otimizar consultas de registros
* Utilizado [MongoDB](https://www.mongodb.com/) para aumentar a capacidade de inserção de registros
* Utilizado [Sidekiq](http://sidekiq.org/) para criação de index no *Elasticsearch* sem prejudicar o desempenho do MongoDB durante a inserção de registros
