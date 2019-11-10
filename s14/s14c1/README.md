# Arquitectura de Software en la Práctica
## API Gateway

### Objetivos

El objetivo de este práctico es implementar el patrón API Gateway utilizando diferentes productos de la industria, particularmente:

* [Kong](https://konghq.com/)
* [Traefik](https://traefik.io/)

### Servicios de ejemplo

Utilizaremos dos micro-servicios de ejemplo que serán expuestos a través de las herramientas mencionadas. Los servicios se encuentran dentro de la carpeta *services*:

* *order-service*:
    * GET: */orders*
    * GET: */orders/:id*

* *product-service*:
    * GET: */products*
    * GET: */products/:id*


### Procedimiento

* [Kong](kong/README.md)
* [Traefik](traefik/README.md)