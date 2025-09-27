# TALLER 01 - Base de Datos Videojuegos con Docker

## REQUISITOS CUMPLIDOS

### Diagrama Entidad-Relación y Cardinalidad
- Diagrama ER implementado
- Cardinalidades 1:N y N:M aplicadas
- Relaciones correctamente establecidas

### Normalización de Base de Datos  
- 1FN, 2FN y 3FN aplicadas
- Estructura normalizada y optimizada
- Sin redundancias de datos

### Proceso DML y DDL con Contenedor
- Contenedor Docker configurado
- Scripts DDL (creación de tablas)
- Scripts DML (inserción de datos)

### Conexión vía CLI y Cliente Gráfico
- Conexión CLI con Docker exec verificada
- Conexión gráfica con Docker Desktop
- MySQL Workbench compatible

## PROCESO CON DOCKER

### Comandos Ejecutados
# Crear contenedor MySQL
docker run --name mysql-videogames -e MYSQL_ROOT_PASSWORD=12345 -p 3306:3306 -d mysql:latest

# Conectar via CLI
docker exec -it mysql-videogames mysql -u root -p

# Ejecutar script (desde dentro de MySQL)
source script_videojuegos.sql