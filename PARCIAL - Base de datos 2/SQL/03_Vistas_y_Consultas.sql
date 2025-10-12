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

