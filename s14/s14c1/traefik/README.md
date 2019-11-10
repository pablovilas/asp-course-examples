# Arquitectura de Software en la Práctica
## API Gateway con Traefik

### Instalación

Para instalar Traefik vamos a utilizar Docker.

#### Configuración

Debemos crear un archivos de configuración para activar el provider de Docker y la UI web. De esta manera podemos administrar Traefik desde un navegador y cada contenedor se autoregistra en Traefik.

#### Iniciar Traefik

``` bash
docker run -d -p 8080:8080 -p 80:80 \
--network=kong-net \
-v $PWD/traefik.yml:/etc/traefik/traefik.yml \
-v /var/run/docker.sock:/var/run/docker.sock \
traefik:v2.0
```