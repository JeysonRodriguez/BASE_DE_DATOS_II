CREATE DATABASE IF NOT EXISTS `SIS-EXP` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `SIS-EXP`;

CREATE TABLE IF NOT EXISTS personas (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS usuarios (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'user',
    sesion_activa BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aseguradoras (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_persona VARCHAR(36) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_aseguradora_persona FOREIGN KEY (id_persona) REFERENCES personas(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS expedientes (
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
    CONSTRAINT fk_expediente_aseguradora FOREIGN KEY (aseguradora_id) REFERENCES aseguradoras (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_expediente_abogado FOREIGN KEY (abogado_id) REFERENCES usuarios (id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX IF NOT EXISTS idx_expedientes_aseguradora ON expedientes(aseguradora_id);
CREATE INDEX IF NOT EXISTS idx_expedientes_abogado ON expedientes(abogado_id);
CREATE INDEX IF NOT EXISTS idx_expedientes_numero ON expedientes(numero_de_caso);
CREATE INDEX IF NOT EXISTS idx_expedientes_fecha ON expedientes(fecha_inicio);

CREATE OR REPLACE VIEW vista_expedientes AS
SELECT e.id, e.abogado_id, a.nombre AS aseguradora, p.nombre_completo AS asegurado, e.juzgado, e.fecha_inicio, e.fecha_finalizacion, e.numero_de_caso, e.tipo_de_proceso
FROM expedientes e
JOIN aseguradoras a ON a.id = e.aseguradora_id
LEFT JOIN personas p ON a.id_persona = p.id
JOIN usuarios u ON e.abogado_id = u.id;

CREATE OR REPLACE VIEW vista_conteo_expedientes AS
SELECT estado, abogado_id, COUNT(*) AS conteo
FROM expedientes
GROUP BY abogado_id, estado;

CREATE OR REPLACE VIEW vista_expedientes_totales AS
SELECT a.nombre AS aseguradora, e.tipo_de_proceso AS tipo_de_proceso, u.nombre_completo AS abogado, e.fecha_inicio AS fecha_inicio, p.nombre_completo AS asegurado, e.numero_de_caso
FROM expedientes e
JOIN aseguradoras a ON a.id = e.aseguradora_id
LEFT JOIN personas p ON a.id_persona = p.id
JOIN usuarios u ON e.abogado_id = u.id;
