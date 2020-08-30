# Arquitectura de Software en la Práctica
## Docker

### Objetivo

Dockerizar una aplicación multi capa utilizando Docker y Docker Compose.

### Procedimiento

Dockerizar el [api de ejemplo](https://github.com/pablovilas/sa-course-examples/tree/master/c7/orders-api-rest). Puede clonar dicho repositorio.
Para aumentar la velocidad del build, excluya archivos y directorios agregando un archivo `.dockerignore` en el directorio de la aplicación.

*Ejemplo `.dockerignore` para Node.js:*

```
node_modules
npm-debug.log
```

Ahora, agrege un archivo `Dockerfile` dentro de la carpeta de la aplicación de ejemplo.

*Ejemplo `Dockerfile` para Node.js:*

```dockerfile
FROM node:latest
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8080
```

Construir la imagen de la aplicación: `docker build -t node-web-app .`
Ahora, crear un contenedor a partir de esa imagen: `docker run -p 8080:8080 node-web-app node index.js`.
¿Qué es lo que sucede?

#### Trabajando con aplicaciones multi-capas

La aplicación de ejemplo depende de MongoDB para iniciar. Para eso nos vamos a apoyar en Compose.
Compose es una herramienta para definir y ejecutar aplicaciones Docker en múltiples contenedores. Con Compose se utiliza un archivo para configurar los servicios de la aplicación. Luego, utilizando un solo comando, se creará e iniciará todos los servicios desde la configuración.

*Archivo `docker-compose.yml` de ejemplo:*

```yml
version: "3.7"
services:
    node:
        build: .
        container_name: node
        command: ["node", "index.js"]
        ports:
            - "8080:8080"
        depends_on:
            - mongodb
        networks:
            - asp-network
    mongodb:
        container_name: mongodb
        image: mongo:latest
        environment:
            - MONGO_DATA_DIR=/data/db
            - MONGO_LOG_DIR=/dev/null
        ports:
            - "27017:27017"
        networks:
            - asp-network
networks:
    asp-network:
        name: asp-network
```

Luego iniciar la aplicación con el comando `docker-compose up`

* **Comandos útiles:**
    * `docker-compose build`: Construye las imagenes necesarias para ejecutar la aplicación
    * `docker-compose up <service-name>`: Ejecuta un servicio particular, ej: `docker-compose up mongodb`
    * `docker-compose up -d`: Ejecuta la aplicación en modo detached (background)
    * `docker-compose ps`: Lista los contenedores en ejecución
    * `docker-compose down`: Baja los contenedores en ejecución

* **Posibles issues**: 
    * La directiva `depends_on` espera solo a que el **contenedor** esté live y no que el servicio dentro del contenedor sea ejecutado. 
    Se puede solucionar utilizando una herramienta como [wait-for-it](https://github.com/vishnubob/wait-for-it). Para eso tenemos que realizar los siguientes pasos:

        1. Descargar el archivo [wait-for-it.sh](https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh) y colocarlo dentro de la raiz de la aplicación

        2. En el Dockerfile dar permisos de ejecución al archivo `RUN chmod +x wait-for-it.sh`

        3. Modificar la directiva `command` en el archivo `docker-compose.yml`: `command: ["./wait-for-it.sh", "mongodb:27017", "--", "node", "index.js"]`

    * No se puede acceder a `localhost:27017`: Modificar la configuración de acceso al a base y sustituir `localhost` por `host.docker.internal`


Realizar un par de POST para crear datos, luego, obtenerlos. Posteriormente ejecutar el comando `docker-compose down` y luego `docker-compose up`. Intentar obtener los datos creados.
¿Qué es lo que sucede?.

#### Trabajando con volumes

Para que los datos de la base sean persistidos tenemos que crear un volumen y mapearlo. Recuerde que los datos de los contenedores son efímeros.
Para esto, editar el archivo `docker-compose.yml` y agregar la directiva `volumes` al mismo nivel que `image`:
```yml
volumes:
    - "./dockercompose/mongo/:/data/db"
```

esto mapeará la carpeta `/data/db` del contenedor con la carpeta `./dockercompose/mongo/` de nuestra computadora.
Corroborar que ahora los datos no se pierden.
