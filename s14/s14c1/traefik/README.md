# Arquitectura de Software en la Práctica
## API Gateway con Traefik

### Instalación

Para instalar Traefik vamos a utilizar Docker.

#### Configuración

Debemos crear el archivo de configuración ```traefik.yml``` para activar el provider de Docker y la UI web. De esta manera podemos administrar Traefik desde un navegador y cada contenedor se autoregistra en Traefik.
El archivo debe contener lo siguiente:

```yml
## traefik.yml

# Docker configuration backend
providers:
  docker:
    defaultRule: "Host(`{{ trimPrefix `/` .Name }}.docker.localhost`)"

# API and dashboard configuration
api:
  insecure: true
```

#### Iniciar Traefik

``` bash
docker run -d -p 8080:8080 -p 80:80 \
--network=asp-net \
-v $PWD/traefik.yml:/etc/traefik/traefik.yml \
-v /var/run/docker.sock:/var/run/docker.sock \
traefik:v2.0
```

#### Dashboard

Puede verificar el dashboard de Traefik en el siguiente enlace: http://localhost:8080/dashboard/#/

#### Agregar servicios

Como estamos utilizando el provider de Docker entonces tenemos que editar el archivo ```docker-compose.yml``` y dejarlo de la siguiente manera:

```yml
version: '3'
services:
  order:
    build: order-service/.
    ports:
      - "9000:9292"
    labels:
      - traefik.http.routers.order-service.rule=Host(`host.docker.internal:9000`)
      - traefik.http.routers.order-service.rule=PathPrefix(`/orders`)
      - traefik.docker.network=asp-net
  product:
    build: product-service/.
    ports:
      - "9001:9292"
    labels:
      - traefik.http.routers.product-service.rule=Host(`host.docker.internal:9001`)
      - traefik.http.routers.product-service.rule=PathPrefix(`/products`)
      - traefik.docker.network=asp-net
networks:
  default:
    external:
      name: asp-net
```

Nótese como agregamos nuevas *labels* a los contenedores, estos labels son leidos automáticamente por Traefik.
Luego de editar el archivo reinicie los servicios de ejemplo y verifique como estos son agregados en el Dashboard.

#### Verificamos el API Gateway

En un navegador o con cURL verificamos que todos los servicios son accedidos a través de Traefik:
 
* http://localhost/orders
* http://localhost/orders/1
* http://localhost/products/1
* http://localhost/product/1