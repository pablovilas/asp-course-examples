# Arquitectura de Software en la Práctica

## Multi-tenancy en rails

La siguiente aplicación es un ejemplo de multi-tenancy en rails. Para esto nos basamos en en siguiente modelo:

* **Usuarios**: mail, contraseña y organización a la que pertenece
* **Organización**: nombre

## Gemas utilizadas

* Gestión de usuarios vía [devise](https://github.com/plataformatec/devise)
* Multi-tenancy con [act_as_tenant](https://github.com/ErwinM/acts_as_tenant). Aunque es posible utilizar [apartment](https://github.com/influitive/apartment)

## Procedimiento

1. Creamos el modelo de organización
2. Incluimos *devise* en el proyecto, copiando las vistas y controladores ya que necesitamos incluir informacion de la organización.
3. Enlazamos los usuarios generados con *devise* y las organizaciones
4. Creamos organizaciones de ejemplo como *seeds*
5. Verificamos que podemos registrar usuarios y estos son almacenado con su respectiva organización
6. Incluimos *act_as_tenant* y realizamos las configuraciones pertinentes
