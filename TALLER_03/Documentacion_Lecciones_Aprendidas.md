#  Lecciones Aprendidas
## Taller de Base de Datos: Fidelización y Análisis de Colaboradores  
**Materia:** Base de Datos II  
**Estudiante:** Jeyson Rodriguez  

---

### 1. Análisis del problema y objetivos técnicos
Este taller tuvo como objetivo aplicar los conocimientos adquiridos en clase sobre el diseño e implementación de bases de datos relacionales.  
El proyecto simuló un entorno empresarial en el que fue necesario **registrar usuarios, controlar accesos, medir su participación en actividades de fidelización y analizar su desempeño** a partir de la información almacenada.

El principal reto fue **integrar el diseño lógico con la implementación práctica en SQL**, garantizando que la estructura de datos permitiera realizar consultas complejas sin comprometer la integridad ni la consistencia de la base.

---

### 2. Diseño relacional y modelado estructurado
Durante el desarrollo del proyecto comprendí mejor la importancia de:
- **Identificar las entidades principales** y sus relaciones (por ejemplo, `1:N` entre perfiles y usuarios, o entre usuarios y actividades de fidelización).  
- Mantener **la integridad referencial** mediante llaves primarias y foráneas.  
- Elegir **tipos de datos apropiados** para cada atributo (`ENUM` para estados, `DECIMAL` para salarios, `DATETIME` para logins).  
- Seguir un **orden lógico** al construir la base de datos: primero las tablas, luego los datos, después las vistas y finalmente las consultas.  

Este proceso ayudó a crear una estructura bien organizada, funcional y fácil de mantener.

---

### 3. Desarrollo de vistas analíticas
Una de las partes más importantes del taller fue la **creación de vistas SQL**, ya que permitieron transformar los datos en información útil para el análisis.  

Las vistas desarrolladas fueron:
- **`v_DesempenoColaboradores`**: combina información sobre el desempeño, puntos de fidelización y actividad reciente de los usuarios.  
- **`v_actividadesPorPerfil`**: calcula el promedio de puntos por perfil, el total de actividades y el porcentaje de participación dentro del sistema.  
- **`v_historialLoginDetallado`**: analiza la frecuencia de inicio de sesión y el tiempo transcurrido entre un acceso y otro.  

Estas vistas mostraron que SQL no solo sirve para guardar información, sino también para **generar conocimiento a partir de los datos**.

---

### 4. Consultas y análisis de resultados
Las consultas finales permitieron interpretar la información desde una perspectiva más analítica:
- Identificar a los **colaboradores con mejor desempeño**.  
- Ver los **perfiles con mayor o menor participación** en actividades.  
- Detectar **usuarios inactivos o con mucho tiempo sin ingresar al sistema**.  
- Evaluar el **porcentaje de logins exitosos y fallidos** por mes.  

Estas consultas reforzaron el uso de **funciones de agregación, subconsultas, filtros y agrupamientos**, lo cual me ayudó a entender cómo se construyen reportes útiles para la gestión empresarial.

---

### 5. Retos técnicos y soluciones implementadas
Durante la práctica surgieron algunos desafíos técnicos:
- **Errores en referencias de campos** entre vistas, que se resolvieron revisando nombres y aplicando funciones como `COUNT(*)` y `NULLIF()`.  
- Uso de **`COALESCE()`** para evitar resultados nulos y mejorar la legibilidad de las consultas.  
- Ajustes en **joins y subconsultas** para mejorar el rendimiento y obtener resultados precisos.  
- Aplicación de **funciones de fecha** como `DATEDIFF()` y `TIMESTAMPDIFF()` para calcular diferencias de tiempo de forma exacta.  

Cada uno de estos retos ayudó a fortalecer mi comprensión del lenguaje SQL y del funcionamiento interno de las consultas.

---

### 6. Conclusión personal
Este taller me ayudó a **conectar la teoría con la práctica**, entendiendo que una base de datos bien diseñada puede convertirse en una herramienta para **analizar el rendimiento y apoyar la toma de decisiones en una empresa**.  

También reforcé mi habilidad para:
- Crear estructuras relacionales completas.  
- Optimizar consultas SQL.  
- Utilizar vistas como base para reportes o dashboards.  
- Interpretar la información que se obtiene del sistema.  

