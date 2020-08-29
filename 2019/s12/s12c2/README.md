# Arquitectura de Software en la Práctica
## Distributed tracing & Application metrics

### Objetivos

El objetivo de este práctico es realizar dos aplicaciones en las cuales podamos implementar mecanismos de tracing distribuido y métricas de aplicación.

### Servicios a utilizar

* [Zipkin](https://zipkin.io/): sistema de tracing distribuido. Ayuda a recopilar datos necesarios para solucionar problemas de latencia en arquitecturas orientadas a servicios
* [New Relic](https://newrelic.com/): herramienta de monitoreo que proporciona información histórica y en tiempo real sobre el rendimiento y la confiabilidad de las aplicaciones web y móviles.

### Servicios de ejemplo

En esta instancia implementaremos dos servicios sencillos en Ruby + Sinatra:

* catalogue-service
* order-service

#### Catalogue service

* **GET**: */products*

```json
[
   {
      "id":1,
      "name":"Coke 600ml"
   },
   {
      "id":2,
      "name":"Cookies 100grs"
   },
   {
      "id":3,
      "name":"Chocolate 50grs"
   },
   {
      "id":4,
      "name":"Candies 10un"
   },
   {
      "id":5,
      "name":"Milk 1ltr"
   },
   {
      "id":6,
      "name":"Water 500ml"
   },
   {
      "id":7,
      "name":"Wine .75ltr"
   },
   {
      "id":8,
      "name":"Sugar 1kg"
   },
   {
      "id":9,
      "name":"Soap 2un"
   }
] 
```

* **GET**: */products/:id*

```json
{
    "id":1,
    "name":"Coke 600ml"
}
```

#### Order service

* **GET**: */orders*

```json
[
   {
      "id":1,
      "user":{
         "name":"Jhon",
         "address":"Av. Street 123"
      },
      "products":[
         1,
         2
      ]
   },
   {
      "id":2,
      "user":{
         "name":"Charlie",
         "address":"Av. Street 500"
      },
      "products":[
         1,
         3,
         4
      ]
   },
   {
      "id":3,
      "user":{
         "name":"Susan",
         "address":"Av. Street 200"
      },
      "products":[
         1,
         4
      ]
   }
]
```

* **GET**: */orders/:id*

```json
{
   "id":1,
   "user":{
      "name":"Jhon",
      "address":"Av. Street 123"
   },
   "products":[
      {
         "id":1,
         "name":"Coke 600ml"
      },
      {
         "id":2,
         "name":"Cookies 100grs"
      }
   ]
}
```

**Nota:** Al obtener una orden por id se debe devovler la información completa de los productos, por lo que es requerido que el servicio de órdenes acceda al servicio de catalogo.

#### Procedimiento

1. Implementar las aplicaciones solicitadas
2. Incluir tracing en ambas aplicaciones por medio de Zipkin
3. Realizar requests y analizarlos en la UI de Zipkin
4. Incluir Newrelic para el monitoreo de ambas aplicaciones
5. Realizar una prueba de performance de 5 minutos
6. Analizar los datos en Newrelic