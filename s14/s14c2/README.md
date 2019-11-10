# Arquitectura de Software en la Práctica
## API Gateway

### Objetivos

El objetivo de este práctico es implementar el patrón Service Discovery utilizando el servicio [Consul](https://www.consul.io/)

#### Instalación

```docker run -p 8500:8500 --network=asp-net --name=consul consul```


curl -X PUT --data-binary @order-service-spec.json http://localhost:8500/v1/agent/service/register

curl -X PUT --data-binary @product-service-spec.json http://localhost:8500/v1/agent/service/register



