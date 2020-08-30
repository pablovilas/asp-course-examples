# Arquitectura de Software en la Práctica
## Docker

### Objetivo

Dockerizar una aplicación multi capa utilizando Docker y Docker Compose.

### Procedimiento

Dockerizar el [api de ejemplo]([https://github.com/pablovilas/sa-course-examples/tree/master/c7/orders-api-rest). Puede clonar dicho repositorio.
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
Ahora, crear un contenedor a partir de esa imagen: `docker run -p 8080:8080 node-web-app`.
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
        command: ["./wait-for-it.sh", "mongodb:27017", "--", "node", "index.js"]
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
        volumes:
            - "./dockercompose/mongo/:/data/db"
        ports:
            - "27017:27017"
        networks:
            - asp-network
networks:
    asp-network:
        name: asp-network
```


