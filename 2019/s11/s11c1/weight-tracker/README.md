# Arquitectura de Software en la Práctica
## Aplicación WeightTracker

### Objetivos

El objetivo de este práctico es realizar una aplicación que lleve registro del peso de las personas.
La aplicación cuenta con los siguientes modelos:

* **User:** es el usuario del sistema, donde se conoce su nombre y edad
* **Weight:** es la medición del peso de una persona, se conoce su valor, fecha de muestreo y la persona en cuestión

### Funcionalidad

1. Se deberá implementar un ABM de usuarios con los datos mencionados
2. Adicionalmente, se deberá implementar un ABM de ingreso de mediciones de peso, por cada medición se ingresa el usuario.
3. Al mostrar un usuario se debe desplegar además de sus datos el peso promedio del mismo.
4. Al listar los pesos ingresados se debe indicar a que usuario pertenece

#### Procedimiento

1. Implementar la aplicación solicitada
2. Separar la gestión de pesos en un nuevo servicio
3. Integrar el nuevo servicio con la aplicación existente
4. Discuta cuál es el impacto de esta decisión sobre:
    * Calculo del promedio de pesos por usuario
    * Desplegar nombre de usuario por cada medición