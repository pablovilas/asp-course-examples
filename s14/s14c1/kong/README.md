# Arquitectura de Software en la Práctica
## API Gateway con Kong

### Instalación

Para instalar Kong vamos a utilizar Docker.

#### Red

Para utilizar Kong necesitamos instalar una DB la cual puede ser Postgres o Cassandra, en este ejemplo utilizaremos la segunda. Como la DB y Kong serán ejecutados en contenedores distintos entonces necesitamos crear una red para que pueda comunicarse entre si.

```bash
docker network create asp-net
```

#### Iniciar DB

```bash
docker run -d --name kong-database \
               --network=asp-net \
               -p 9042:9042 \
               cassandra:3
```

Luego de tener la DB en ejecución debemos ejecutar las migraciones de datos necesarias para que Kong pueda ser ejecutado:

```bash
docker run --rm \
     --network=asp-net \
     -e "KONG_DATABASE=cassandra" \
     -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
     kong:latest kong migrations bootstrap
```

*Nota:* Si ejecuta este comando enseguida del anterior puede que el contenedor no haya finalizado de iniciar

### Iniciar Kong

Para iniciar Kong ejecutamos el siguiente comando:

```bash
docker run --name kong \
     --network=asp-net \
     -e "KONG_DATABASE=cassandra" \
     -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
     -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
     -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
     -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
     -p 8000:8000 \
     -p 8443:8443 \
     -p 8001:8001 \
     -p 8444:8444 \
     kong:latest
```

Para verificar que esté en ejecución utilizamos ```curl -i http://localhost:8001/``` (Unix).
*Nota:* En caso de utilizar preferir administración visual puede utilizar [Konga](https://pantsel.github.io/konga/)

### Servicios

Para obtener todos los servicios registrados ejecutamos el siguiente comando: ```curl -i http://localhost:8001/services```. En este caso no tenemos ninguno, vamos a agregar los servicios provistos en el práctico.

#### Iniciar servicios


Nos movemos a la carpeta ```services``` y editamos el archivo ```docker-compose.yml``` de la siguiente manera:

```yml
version: '3'
services:
  order:
    build: order-service/.
    ports:
      - "9000:9292"
  product:
    build: product-service/.
    ports:
      - "9001:9292"
networks:
  default:
    external:
      name: asp-net
```

luego ejecutamos el comando ```docker-compose up```. Esto va a iniciar los dos servicios de ejemplo.
Verificar que los servicios quedan disponibles en:

* http://localhost:9001/products
* http://localhost:9000/orders

#### Agregamos los servicios a Kong

Agregamos el servicio de órdenes

```bash
curl -i -X POST \
  --url http://localhost:8001/services/ \
  --data 'name=order-service' \
  --data 'url=http://host.docker.internal:9000'
```

Debemos obtener una respuesta como esta:

```bash
HTTP/1.1 201 Created
Date: Sun, 10 Nov 2019 16:25:01 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
Access-Control-Allow-Origin: *
Server: kong/1.4.0
Content-Length: 305
X-Kong-Admin-Latency: 11

{"id":"6607dddb-8860-41c4-8551-64bf6f3ae525","tags":null,"updated_at":1573403110,"destinations":null,"headers":null,"protocols":["http"],"created_at":1573403110,"snis":null,"service":{"id":"abfe16d8-f1ab-4ed0-b54c-56b911535060"},"name":null,"preserve_host":false,"regex_priority":0,"strip_path":false,"sources":null,"paths":["\/orders"],"https_redirect_status_code":426,"hosts":["localhost"],"methods":["GET"]}
```

luego agregamos el servicio de productos:

```bash
curl -i -X POST \
  --url http://localhost:8001/services/ \
  --data 'name=product-service' \
  --data 'url=http://host.docker.internal:9001'
```

#### Agregamos las rutas a Kong

Finalmente le indicamos a Kong cuales son las rutas que debe agregar:

```bash
curl -i -X POST \
    --url http://localhost:8001/services/order-service/routes \
    --data 'hosts[]=localhost' \
    --data 'paths[]=/orders' \
    --data 'strip_path=false' \
    --data 'methods[]=GET' \
    --data 'protocols[]=http'
```

la respuesta debe ser similar a la siguiente:

```bash
HTTP/1.1 201 Created
Date: Sun, 10 Nov 2019 16:25:10 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
Access-Control-Allow-Origin: *
Server: kong/1.4.0
Content-Length: 410
X-Kong-Admin-Latency: 21

{"id":"6607dddb-8860-41c4-8551-64bf6f3ae525","tags":null,"updated_at":1573403110,"destinations":null,"headers":null,"protocols":["http"],"created_at":1573403110,"snis":null,"service":{"id":"abfe16d8-f1ab-4ed0-b54c-56b911535060"},"name":null,"preserve_host":false,"regex_priority":0,"strip_path":false,"sources":null,"paths":["\/orders"],"https_redirect_status_code":426,"hosts":["localhost"],"methods":["GET"]}
```

luego agregamos la ruta para el servicio de productos:

```bash
curl -i -X POST \
    --url http://localhost:8001/services/product-service/routes \
    --data 'hosts[]=localhost' \
    --data 'paths[]=/products' \
    --data 'strip_path=false' \
    --data 'methods[]=GET' \
    --data 'protocols[]=http'
```

#### Verificamos el API Gateway

En un navegador o con cURL verificamos que todos los servicios son accedidos a través de Kong:
 
* http://localhost:8000/orders
* http://localhost:8000/orders/1
* http://localhost:8000/products/1
* http://localhost:8000/product/1