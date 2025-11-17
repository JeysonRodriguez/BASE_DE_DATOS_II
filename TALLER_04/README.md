# Taller 04 - SIS-EXP – API REST con Flask

Este proyecto implementa una API REST desarrollada con Flask para gestionar expedientes, usuarios, aseguradoras y personas.
La API se conecta a una base de datos MariaDB utilizando variables de entorno y aplica hash seguro de contraseñas con bcrypt.

## Características principales

Conexión a MariaDB mediante variables de entorno (.env).
Endpoints para login, listado de expedientes y conteo por estado.
Script automatizado para crear la base de datos, tablas y datos de prueba.
Contraseñas protegidas con hashing (bcrypt).
Consultas SQL reales basadas en relaciones entre usuarios, aseguradoras y personas.

1. Instalación:
- pip install flask python-dotenv mariadb bcrypt

2. Configuracion de variables de entorno (.env)
DB_HOST=localhost
DB_PORT=3307
DB_USER=root
DB_PASSWORD=123456789
DB_NAME=SIS-EXP

3. Crear la base de datos y datos iniciales
Ejecuta el script que genera todo automáticamente:
- python db/datos.py

Esto crea:
  BD SIS-EXP
  Tablas:
    usuarios
    personas
    aseguradoras
    expedientes
- Datos de ejemplo (usuarios, aseguradoras y expedientes)

Ejecutar la API
Usa Flask CLI:
- flask --app main run --reload

Se ejecutará en:
  http://127.0.0.1:5000/  


Endpoints 
  POST /login
    Autentica usuarios registrados.
    Body JSON:
  {
    "usuario": "jeyson.rodriguez",
     "contrasena": "secret"
  }

GET /expedientes
Lista todos los expedientes con datos combinados de aseguradoras y personas.
Ejemplo de salida:
  {
  "id": "...",
  "aseguradora": "SEGUPLUS",
  "asegurado": "Roberto Aguilar",
  "juzgado": "Juzgado 1",
  "estado": "Pendiente",
  "FECHA": "2025-02-19"
  }

GET /expedientes/conteo
Devuelve cuántos expedientes hay por estado:
  [
  { "estado": "Pendiente", "conteo": 3 },
  { "estado": "En curso", "conteo": 2 },
  { "estado": "Cerrado", "conteo": 1 }
]

Usuarios creados automáticamente
Contraseña por defecto: secret
- jeyson.rodriguez
- andrea.mendoza
- luis.castillo
Todos almacenados con bcrypt.

## Problemas comunes

| Problema                | Solución                                          |
| ----------------------- | ------------------------------------------------- |
| Error de conexión       | Revisa `.env` (host, puerto, usuario, contraseña) |
| Paquete `mariadb` falla | Instala librerías nativas (`mariadb-connector-c`) |
| BD vacía                | Ejecutar `python db/datos.py` nuevamente          |
| Puerto incorrecto       | Confirmar si MariaDB usa 3307                     |

