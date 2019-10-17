ASP Semana 9 - Clase 2
======================

Acercamiento a arquitecturas de microservicios
------

### Objetivo

El objetivo de este práctico es presentar microservicios y realizar un ejemplo básico.

### Resumen

RapiCotiza es una aplicación web que dado un país retorna el valor de su moneda con respecto a otras.
Dado un listado de países se puede seleccionar un uno de origen, otro de destino y un determinado monto, el sistema debe retornar la conversión de ese monto en el país de destino
De un país de sabe su *nombre*, su *[código ISO](https://en.wikipedia.org/wiki/ISO_3166-1#Current_codes)* y el *[código ISO](https://www.iban.com/currency-codes)* de la moneda.

### Pasos

1. Implementar un sistema en Rails que haga un ABM de países con los atributos mencionados.
2. Implementar un microservicio que dado un monto, una moneda de origen y una moneda de destino haga la conversión de la misma. Sugerencia: utilizar una moneda de referencia para facilitar la conversión.
    
    Ejemplo:
    * 1 UYI = 0.03 REF
    * 1 EUR = 1.15 REF
    * 1 USD = 1 REF
    * 1 UYI to EUR = 0.026 EUR (1 UYI / 1.15 REF) * 0.03 REF

3. Conectar el sistema con el microservicio de conversión y desplegar los resultados en *Heroku*

### Tips

* Para conectar los servicios puede utilizar la gema [faraday](https://github.com/lostisland/faraday)
* Ejemplo de un microservicio en Node.js de servicio para devolver la hora del pais de acuerdo al [IANA timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)