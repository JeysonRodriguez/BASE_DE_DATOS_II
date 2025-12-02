-- backup_SIS_EXP.sql
-- Backup de la base de datos SIS-EXP
-- Generado el: [FECHA ACTUAL]
-- Usuario: root

-- 1. Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS `SIS-EXP` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `SIS-EXP`;

-- 2. Eliminar tablas si existen (en orden inverso por dependencias)
DROP TABLE IF EXISTS expedientes;
DROP TABLE IF EXISTS aseguradoras;
DROP TABLE IF EXISTS personas;
DROP TABLE IF EXISTS usuarios;

-- 3. Crear tablas
CREATE TABLE personas (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE usuarios (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'user',
    sesion_activa BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE aseguradoras (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_persona VARCHAR(36) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_aseguradora_persona FOREIGN KEY (id_persona) 
        REFERENCES personas(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE expedientes (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    aseguradora_id VARCHAR(36) NOT NULL,
    estado ENUM('Pendiente','En curso','Cerrado') NOT NULL DEFAULT 'Pendiente',
    juzgado VARCHAR(255) NOT NULL,
    fecha_inicio DATE,
    fecha_finalizacion DATE,
    formato VARCHAR(50),
    conductor VARCHAR(255),
    numero_de_caso VARCHAR(50),
    tipo_de_proceso ENUM('TRANSITO','PENAL') NOT NULL,
    abogado_id VARCHAR(36) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_expediente_aseguradora FOREIGN KEY (aseguradora_id) 
        REFERENCES aseguradoras (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_expediente_abogado FOREIGN KEY (abogado_id) 
        REFERENCES usuarios (id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Crear índices
CREATE INDEX idx_expedientes_aseguradora ON expedientes(aseguradora_id);
CREATE INDEX idx_expedientes_abogado ON expedientes(abogado_id);
CREATE INDEX idx_expedientes_numero ON expedientes(numero_de_caso);
CREATE INDEX idx_expedientes_fecha ON expedientes(fecha_inicio);

-- 5. Insertar datos de prueba

-- Insertar usuarios (contraseña: 'secret' en bcrypt)
INSERT INTO usuarios (id, nombre_completo, usuario, contrasena, role) VALUES
('550e8400-e29b-41d4-a716-446655440000', 'Lic. Juan Pérez', 'juan.perez', '$2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', 'admin'),
('550e8400-e29b-41d4-a716-446655440001', 'Lic. Diana Campbell', 'diana.campbell', '$2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', 'abogado'),
('550e8400-e29b-41d4-a716-446655440002', 'Lic. Harold Gray', 'harold.gray', '$2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', 'abogado'),
('550e8400-e29b-41d4-a716-446655440003', 'Sofía Rodríguez', 'sofia.rodriguez', '$2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', 'user');

INSERT INTO personas (id, nombre_completo) VALUES
('660e8400-e29b-41d4-a716-446655440000', 'ANTHONY TREJOS'),
('660e8400-e29b-41d4-a716-446655440001', 'LUIS MOLINA'),
('660e8400-e29b-41d4-a716-446655440002', 'KATHERINE KENT'),
('660e8400-e29b-41d4-a716-446655440003', 'MARTIN ALVARADO'),
('660e8400-e29b-41d4-a716-446655440004', 'JOEL ARAUZ RODRIGUEZ'),
('660e8400-e29b-41d4-a716-446655440005', 'MICHELLE VEGA'),
('660e8400-e29b-41d4-a716-446655440006', 'CANDICE HENRY');

INSERT INTO aseguradoras (id, nombre, id_persona) VALUES
('770e8400-e29b-41d4-a716-446655440000', 'ASSA', '660e8400-e29b-41d4-a716-446655440000'),
('770e8400-e29b-41d4-a716-446655440001', 'ANCON', '660e8400-e29b-41d4-a716-446655440001'),
('770e8400-e29b-41d4-a716-446655440002', 'ASSA', '660e8400-e29b-41d4-a716-446655440002'),
('770e8400-e29b-41d4-a716-446655440003', 'CONANCE', '660e8400-e29b-41d4-a716-446655440003'),
('770e8400-e29b-41d4-a716-446655440004', 'PARTICULAR', '660e8400-e29b-41d4-a716-446655440004'),
('770e8400-e29b-41d4-a716-446655440005', 'INTEROCEANICA', '660e8400-e29b-41d4-a716-446655440005'),
('770e8400-e29b-41d4-a716-446655440006', 'ANCON', '660e8400-e29b-41d4-a716-446655440006');


INSERT INTO expedientes (id, aseguradora_id, estado, juzgado, fecha_inicio, fecha_finalizacion, 
                         formato, conductor, numero_de_caso, tipo_de_proceso, abogado_id) VALUES
('880e8400-e29b-41d4-a716-446655440000', '770e8400-e29b-41d4-a716-446655440000', 'Pendiente', 
 'JUZGADO STO (PEDREGAL)', '2019-01-07', '2019-03-07', '5435435', 'ANTHONY TREJOS', 
 'CASE-001', 'PENAL', '550e8400-e29b-41d4-a716-446655440001'),
('880e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440001', 'En curso', 
 'JUZGADO ATO (PEDREGAL)', '2019-01-07', '2019-04-15', '5435436', 'LUIS MOLINA', 
 'CASE-002', 'TRANSITO', '550e8400-e29b-41d4-a716-446655440002'),
('880e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440002', 'Cerrado', 
 'JUZGADO STO (PEDREGAL)', '2019-01-07', '2019-02-20', '5435437', 'KATHERINE KENT', 
 'CASE-003', 'PENAL', '550e8400-e29b-41d4-a716-446655440001');

-- 6. Crear vistas
CREATE OR REPLACE VIEW vista_expedientes AS
SELECT e.id, e.abogado_id, a.nombre AS aseguradora, p.nombre_completo AS asegurado, 
       e.juzgado, e.fecha_inicio, e.fecha_finalizacion, e.numero_de_caso, e.tipo_de_proceso
FROM expedientes e
JOIN aseguradoras a ON a.id = e.aseguradora_id
LEFT JOIN personas p ON a.id_persona = p.id
JOIN usuarios u ON e.abogado_id = u.id;

CREATE OR REPLACE VIEW vista_conteo_expedientes AS
SELECT estado, abogado_id, COUNT(*) AS conteo
FROM expedientes
GROUP BY abogado_id, estado;

CREATE OR REPLACE VIEW vista_expedientes_totales AS
SELECT a.nombre AS aseguradora, e.tipo_de_proceso AS tipo_de_proceso, 
       u.nombre_completo AS abogado, e.fecha_inicio AS fecha_inicio, 
       p.nombre_completo AS asegurado, e.numero_de_caso
FROM expedientes e
JOIN aseguradoras a ON a.id = e.aseguradora_id
LEFT JOIN personas p ON a.id_persona = p.id
JOIN usuarios u ON e.abogado_id = u.id;

-- 7. Mensaje final
SELECT 'Backup de SIS-EXP creado exitosamente' AS mensaje;
SELECT COUNT(*) AS total_expedientes FROM expedientes;