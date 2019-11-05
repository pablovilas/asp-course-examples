ASP Semana 13 - Clase 1
======================

Message broker: RabbitMQ
------

## Instalación

* Docker

    ```
    docker run -d -p 15672:15672 -p 5672:5672 -p 5671:5671 --hostname rabbitmq --name rabbitmq rabbitmq:3-management-alpine
    ```

    Consola administrativa:

    * URL: http://localhost:8080
    * User: guest
    * Password: guest

* Managed

Servicio [CloudAMQP](https://www.cloudamqp.com/)

## Ejemplos

### Productor consumidor



### Publish subscribe


### Routing


### Topics

