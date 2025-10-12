CREATE DATABASE IF NOT EXISTS pixel_security360;
USE pixel_security360;

CREATE TABLE tipos_usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    nombre_usuario VARCHAR(100) NOT NULL UNIQUE,
    token VARCHAR(100),
    contrasena VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100),
    sexo ENUM('Masculino','Femenino') NOT NULL,
    estado_civil ENUM('Soltero(a)','Casado(a)','Divorciado(a)','Viudo(a)'),
    tipo_empresa ENUM('pública','privada') NOT NULL,
    direccion VARCHAR(255),
    tipo_usuario_id INT NOT NULL,
    FOREIGN KEY (tipo_usuario_id) REFERENCES tipos_usuarios(id)
);

CREATE TABLE autenticacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    agente_usuario VARCHAR(255),
    token VARCHAR(100),
    contrasena VARCHAR(100) NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE tipos_pruebas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    referencia VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_ingreso DATE DEFAULT (CURRENT_DATE),
    estado ENUM('activo','desactivado') NOT NULL
);

CREATE TABLE pagos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    metodo_pago ENUM('Tarjeta','PayPal','Transferencia') NOT NULL,
    numero_tarjeta VARCHAR(20), 
    nombre_titular VARCHAR(100), 
    cvc VARCHAR(4), 
    expiracion VARCHAR(7),
    numero_operacion VARCHAR(50),
    monto DECIMAL(10,2) NOT NULL,
    moneda VARCHAR(10) DEFAULT 'USD',
    fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,
    datos_facturacion TEXT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

INSERT INTO tipos_usuarios (nombre) VALUES
('Cliente'), ('Administradores'), ('Vendedores'), ('Ejecutivos'), ('Otros');

INSERT INTO usuarios (nombre, apellido, nombre_usuario, token, contrasena, ciudad, sexo, estado_civil, tipo_empresa, direccion, tipo_usuario_id) VALUES
('Ana','González','ana.gonzalez','tok_ana_001','passAna1','Panamá','Femenino','Soltero(a)','privada','Calle 1, Panamá',1),
('Carlos','Pérez','carlos.perez','tok_car_002','passCar2','David','Masculino','Casado(a)','pública','Avenida 2, David',1),
('María','Rodríguez','maria.rod','tok_mar_003','passMar3','Colón','Femenino','Casado(a)','privada','Barrio 3, Colón',1),
('Luis','Martínez','luis.mtz','tok_lui_004','passLui4','Panamá','Masculino','Soltero(a)','privada','Calle 4, Panamá',3),
('Sofía','Hernández','sofia.hern','tok_sof_005','passSof5','La Chorrera','Femenino','Casado(a)','pública','Sector 5, La Chorrera',4),
('Jorge','Ramírez','jorge.ram','tok_jor_006','passJor6','Penonomé','Masculino','Divorciado(a)','privada','Calle 6, Penonomé',2),
('Lucía','Vargas','lucia.vg','tok_luc_007','passLuc7','David','Femenino','Soltero(a)','privada','Avenida 7, David',1),
('Miguel','Santos','miguel.s','tok_mig_008','passMig8','Panamá','Masculino','Casado(a)','pública','Calle 8, Panamá',5),
('Paula','Castro','paula.c','tok_pau_009','passPau9','Santiago','Femenino','Viudo(a)','privada','Barrio 9, Santiago',1),
('Diego','Lopez','diego.l','tok_die_010','passDie10','David','Masculino','Casado(a)','privada','Sector 10, David',3),
('Verónica','Ortega','veronica.o','tok_ver_011','passVer11','Panamá','Femenino','Soltero(a)','privada','Calle 11, Panamá',1),
('Rafael','Molina','rafael.m','tok_raf_012','passRaf12','Colón','Masculino','Casado(a)','pública','Avenida 12, Colón',2),
('Gabriela','Suárez','gabriela.s','tok_gab_013','passGab13','La Chorrera','Femenino','Casado(a)','privada','Sector 13, La Chorrera',4),
('Andrés','Cruz','andres.c','tok_and_014','passAnd14','Penonomé','Masculino','Soltero(a)','privada','Calle 14, Penonomé',3),
('Natalia','Méndez','natalia.m','tok_nat_015','passNat15','Panamá','Femenino','Casado(a)','pública','Barrio 15, Panamá',1),
('Óscar','Díaz','oscar.d','tok_osc_016','passOsc16','Santiago','Masculino','Divorciado(a)','privada','Avenida 16, Santiago',5),
('Elena','Fuentes','elena.f','tok_ele_017','passEle17','David','Femenino','Soltero(a)','privada','Calle 17, David',1),
('Pablo','Ramos','pablo.r','tok_pab_018','passPab18','Colón','Masculino','Casado(a)','privada','Sector 18, Colón',3),
('Carolina','Vega','carolina.v','tok_carv_019','passCarv19','Panamá','Femenino','Soltero(a)','pública','Barrio 19, Panamá',4),
('Javier','Ibáñez','javier.i','tok_jav_020','passJav20','La Chorrera','Masculino','Casado(a)','privada','Avenida 20, La Chorrera',2);

INSERT INTO autenticacion (usuario_id, agente_usuario, token, contrasena, fecha) VALUES
(1,'Mozilla/5.0 (Windows NT 10.0; Win64; x64)','auth_tok_1','passAna1','2025-10-01 09:00:00'),
(2,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)','auth_tok_2','passCar2','2025-10-02 10:15:00'),
(3,'Mozilla/5.0 (X11; Linux x86_64)','auth_tok_3','passMar3','2025-10-03 11:20:00'),
(4,'Mozilla/5.0 (iPhone; CPU iPhone OS 14_0)','auth_tok_4','passLui4','2025-10-04 12:30:00'),
(5,'Mozilla/5.0 (Android 11; Mobile)','auth_tok_5','passSof5','2025-10-05 08:45:00'),
(6,'Mozilla/5.0 (Windows NT 10.0; Win64; x64)','auth_tok_6','passJor6','2025-10-06 09:10:00'),
(7,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)','auth_tok_7','passLuc7','2025-10-07 14:05:00'),
(8,'Mozilla/5.0 (X11; Linux x86_64)','auth_tok_8','passMig8','2025-10-08 15:50:00'),
(9,'Mozilla/5.0 (iPad; CPU OS 13_2)','auth_tok_9','passPau9','2025-10-09 16:00:00'),
(10,'Mozilla/5.0 (Android 12; Mobile)','auth_tok_10','passDie10','2025-10-10 17:10:00'),
(11,'Mozilla/5.0 (Windows NT 10.0; Win64; x64)','auth_tok_11','passVer11','2025-09-28 09:00:00'),
(12,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)','auth_tok_12','passRaf12','2025-09-29 10:15:00'),
(13,'Mozilla/5.0 (X11; Linux x86_64)','auth_tok_13','passGab13','2025-09-30 11:20:00'),
(14,'Mozilla/5.0 (iPhone; CPU iPhone OS 14_0)','auth_tok_14','passAnd14','2025-09-25 12:30:00'),
(15,'Mozilla/5.0 (Android 11; Mobile)','auth_tok_15','passNat15','2025-09-20 08:45:00'),
(16,'Mozilla/5.0 (Windows NT 10.0; Win64; x64)','auth_tok_16','passOsc16','2025-09-18 09:10:00'),
(17,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)','auth_tok_17','passEle17','2025-09-15 14:05:00'),
(18,'Mozilla/5.0 (X11; Linux x86_64)','auth_tok_18','passPab18','2025-09-12 15:50:00'),
(19,'Mozilla/5.0 (iPad; CPU OS 13_2)','auth_tok_19','passCarv19','2025-09-10 16:00:00'),
(20,'Mozilla/5.0 (Android 12; Mobile)','auth_tok_20','passJav20','2025-09-08 17:10:00');

INSERT INTO tipos_pruebas (referencia, nombre, descripcion, fecha_ingreso, estado) VALUES
('TP-001','Reconocimiento','Fase inicial de recolección de información sobre el objetivo','2025-01-10','activo'),
('TP-002','Análisis de Vulnerabilidades','Identificación y evaluación de vulnerabilidades en sistemas','2025-02-12','activo'),
('TP-003','Explotación','Ejecución de exploits para aprovechar vulnerabilidades identificadas','2025-03-15','activo'),
('TP-004','Escalar Privilegios o Post-Explotación','Obtención de mayores privilegios y mantenimiento de acceso','2025-04-20','activo'),
('TP-005','SQL Injection','Prueba de inyección SQL en formularios','2025-05-05','activo'),
('TP-006','XSS','Cross-site scripting básico','2025-05-20','activo'),
('TP-007','CSRF','Cross-site request forgery','2025-06-01','activo'),
('TP-008','RCE','Remote code execution','2025-06-07','desactivado'),
('TP-009','Escaneo de puertos','Escaneo de puertos abiertos','2025-06-15','activo'),
('TP-010','Fuerza bruta','Ataques de autenticación','2025-06-20','activo'),
('TP-011','Enumeración','Enumeración de servicios','2025-07-02','activo'),
('TP-012','Exposición de datos','Filtrado de datos sensibles','2025-07-10','activo'),
('TP-013','Escalada de privilegios','Pruebas de permisos','2025-07-20','desactivado'),
('TP-014','Seguridad de API','Pruebas de endpoints API','2025-08-01','activo'),
('TP-015','Desbordamiento de buffer','Análisis de memoria','2025-08-10','activo'),
('TP-016','Validación de archivos','Pruebas de carga y validación','2025-08-20','activo'),
('TP-017','Seguridad móvil','Pruebas en apps móviles','2025-09-01','activo'),
('TP-018','Fugas de configuración','Revisión de secrets','2025-09-10','activo'),
('TP-019','Análisis estático','Revisión de código','2025-09-20','activo'),
('TP-020','Pruebas de red','Latencia y saturación','2025-09-30','activo');

INSERT INTO pagos (usuario_id, metodo_pago, numero_tarjeta, nombre_titular, cvc, expiracion, numero_operacion, monto, moneda, fecha_pago, datos_facturacion) VALUES
(1,'Tarjeta','4111111111111111','Ana González','123','12/2027','OP-1001',150.00,'USD','2025-09-01 10:00:00','Calle 1, Panamá'),
(2,'PayPal',NULL,NULL,NULL,NULL,'OP-1002',200.50,'USD','2025-09-02 11:15:00','Avenida 2, David'),
(3,'Transferencia',NULL,NULL,NULL,NULL,'OP-1003',99.99,'USD','2025-09-03 12:30:00','Barrio 3, Colón'),
(4,'Tarjeta','5555555555554444','Luis Martínez','456','08/2026','OP-1004',250.00,'USD','2025-09-04 13:45:00','Calle 4, Panamá'),
(5,'PayPal',NULL,NULL,NULL,NULL,'OP-1005',75.00,'USD','2025-09-05 09:10:00','Sector 5, La Chorrera'),
(6,'Transferencia',NULL,NULL,NULL,NULL,'OP-1006',300.00,'USD','2025-09-06 08:05:00','Calle 6, Penonomé'),
(7,'Tarjeta','378282246310005','Lucía Vargas','789','03/2028','OP-1007',45.25,'USD','2025-09-07 14:20:00','Avenida 7, David'),
(8,'PayPal',NULL,NULL,NULL,NULL,'OP-1008',500.00,'USD','2025-09-08 15:30:00','Calle 8, Panamá'),
(9,'Transferencia',NULL,NULL,NULL,NULL,'OP-1009',120.00,'USD','2025-09-09 16:40:00','Barrio 9, Santiago'),
(10,'Tarjeta','6011111111111117','Diego Lopez','321','11/2025','OP-1010',60.00,'USD','2025-09-10 17:50:00','Sector 10, David'),
(11,'PayPal',NULL,NULL,NULL,NULL,'OP-1011',85.00,'USD','2025-09-11 09:55:00','Calle 11, Panamá'),
(12,'Transferencia',NULL,NULL,NULL,NULL,'OP-1012',130.00,'USD','2025-09-12 10:05:00','Avenida 12, Colón'),
(13,'Tarjeta','3530111333300000','Gabriela Suárez','654','06/2027','OP-1013',220.00,'USD','2025-09-13 11:15:00','Sector 13, La Chorrera'),
(14,'PayPal',NULL,NULL,NULL,NULL,'OP-1014',33.33,'USD','2025-09-14 12:25:00','Calle 14, Penonomé'),
(15,'Transferencia',NULL,NULL,NULL,NULL,'OP-1015',410.00,'USD','2025-09-15 13:35:00','Barrio 15, Panamá'),
(16,'Tarjeta','5105105105105100','Óscar Díaz','987','09/2026','OP-1016',55.50,'USD','2025-09-16 14:45:00','Avenida 16, Santiago'),
(17,'PayPal',NULL,NULL,NULL,NULL,'OP-1017',199.99,'USD','2025-09-17 15:55:00','Calle 17, David'),
(18,'Transferencia',NULL,NULL,NULL,NULL,'OP-1018',78.75,'USD','2025-09-18 16:05:00','Sector 18, Colón'),
(19,'Tarjeta','371449635398431','Carolina Vega','147','02/2028','OP-1019',14.99,'USD','2025-09-19 17:15:00','Barrio 19, Panamá'),
(20,'PayPal',NULL,NULL,NULL,NULL,'OP-1020',999.00,'USD','2025-09-20 18:25:00','Avenida 20, La Chorrera');

-- 1. Usuario del sistema: Información general + tipo de usuario
CREATE OR REPLACE VIEW v_usuario_del_sistema AS
SELECT u.id AS usuario_id, u.nombre, u.apellido, u.nombre_usuario, u.ciudad, u.sexo, 
       u.estado_civil, u.tipo_empresa, u.direccion, u.token, 
       tu.id AS tipo_usuario_id, tu.nombre AS tipo_usuario_nombre
FROM usuarios u
JOIN tipos_usuarios tu ON u.tipo_usuario_id = tu.id;

-- 2. Clasificación de tipos de usuarios: Total de usuarios por tipo de empresa
CREATE OR REPLACE VIEW v_clasificacion_tipos_usuarios AS
SELECT 
    u.nombre AS nombre_usuario,
    u.apellido, 
    u.tipo_empresa,
    tu.nombre AS tipo_usuario_nombre
FROM usuarios u
JOIN tipos_usuarios tu ON u.tipo_usuario_id = tu.id
ORDER BY u.tipo_empresa, u.apellido;

-- 3. Medios de pagos: Métodos de pago + información del usuario
CREATE OR REPLACE VIEW v_medios_de_pagos AS
SELECT p.id AS pago_id, p.metodo_pago, p.monto, p.moneda, p.fecha_pago,
       u.nombre, u.apellido, u.estado_civil, u.direccion
FROM pagos p
JOIN usuarios u ON p.usuario_id = u.id;

-- 4. Autenticación: Fecha, nombre usuario + apellido, ciudad, tipo empresa
CREATE OR REPLACE VIEW v_autenticacion AS
SELECT 
    a.fecha, 
    u.nombre AS nombre_usuario, 
    u.apellido, 
    u.ciudad,
    u.tipo_empresa,
    a.agente_usuario,
    a.token AS auth_token
FROM autenticacion a
JOIN usuarios u ON a.usuario_id = u.id;

-- 5. Tipos de pruebas activas
CREATE OR REPLACE VIEW v_tipos_pruebas_activas AS
SELECT id, referencia, nombre, descripcion, fecha_ingreso
FROM tipos_pruebas 
WHERE estado = 'activo';

-- 1. Ver Usuarios del sistema
SELECT * FROM v_usuario_del_sistema LIMIT 20;

-- 2. Ver Clasificación de tipos de usuarios  
SELECT * FROM v_clasificacion_tipos_usuarios LIMIT 10;

-- 3. Ver Medios de pagos
SELECT * FROM v_medios_de_pagos LIMIT 15;

-- 4. Ver Autenticación 
SELECT * FROM v_autenticacion LIMIT 15;

-- 5. Ver Tipos de pruebas activas
SELECT * FROM v_tipos_pruebas_activas;

