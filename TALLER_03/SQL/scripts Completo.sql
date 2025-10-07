CREATE DATABASE EmpresaXYZ;
USE EmpresaXYZ;

CREATE TABLE Perfiles (
    id_perfil INT PRIMARY KEY AUTO_INCREMENT,
    nombre_perfil VARCHAR(50) NOT NULL,
    fecha_vigencia_perfil DATE NOT NULL,
    descripcion_perfil TEXT,
    encargado_perfil VARCHAR(100)
);

CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    estado ENUM('activo', 'inactivo') NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    id_perfil INT NOT NULL,
    FOREIGN KEY (id_perfil) REFERENCES Perfiles(id_perfil)
);

CREATE TABLE Login (
    id_login INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    fecha_hora_login DATETIME NOT NULL,
    estado_login ENUM('exitoso', 'fallido') NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Fidelizacion (
    id_actividad INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    fecha_actividad DATE NOT NULL,
    tipo_actividad VARCHAR(100) NOT NULL,
    descripcion_actividad TEXT,
    puntos_otorgados INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

INSERT INTO Perfiles (nombre_perfil, fecha_vigencia_perfil, descripcion_perfil, encargado_perfil) VALUES
('Administrador', '2024-12-31', 'Acceso completo al sistema', 'Juan Pérez'),
('Gerente', '2024-12-31', 'Gestión de equipos y proyectos', 'María García'),
('Analista Senior', '2024-12-31', 'Análisis de datos y reportes', 'Carlos López'),
('Desarrollador', '2024-12-31', 'Desarrollo de software', 'Ana Martínez'),
('Diseñador UX/UI', '2024-12-31', 'Diseño de interfaces', 'Laura Rodríguez'),
('Marketing', '2024-12-31', 'Estrategias de marketing', 'Pedro Sánchez'),
('Ventas', '2024-12-31', 'Gestión de ventas', 'Sofía Hernández'),
('Soporte Técnico', '2024-12-31', 'Soporte a usuarios', 'David González'),
('Recursos Humanos', '2024-12-31', 'Gestión de personal', 'Elena Ramírez'),
('Contabilidad', '2024-12-31', 'Gestión financiera', 'Miguel Torres');

INSERT INTO Usuarios (nombre, apellido, estado, contraseña, cargo, salario, fecha_ingreso, id_perfil) VALUES
('Juan', 'Pérez', 'activo', 'hashed_password_1', 'CEO', 8000.00, '2020-01-15', 1),
('María', 'García', 'activo', 'hashed_password_2', 'Gerente General', 6000.00, '2020-03-20', 2),
('Carlos', 'López', 'activo', 'hashed_password_3', 'Analista de Datos', 4500.00, '2021-02-10', 3),
('Ana', 'Martínez', 'activo', 'hashed_password_4', 'Desarrollador Senior', 5000.00, '2021-05-15', 4),
('Laura', 'Rodríguez', 'activo', 'hashed_password_5', 'Diseñadora Principal', 4200.00, '2021-07-22', 5),
('Pedro', 'Sánchez', 'activo', 'hashed_password_6', 'Especialista en Marketing', 3800.00, '2022-01-10', 6),
('Sofía', 'Hernández', 'activo', 'hashed_password_7', 'Ejecutiva de Ventas', 3500.00, '2022-03-15', 7),
('David', 'González', 'activo', 'hashed_password_8', 'Técnico de Soporte', 3200.00, '2022-06-20', 8),
('Elena', 'Ramírez', 'activo', 'hashed_password_9', 'Gerente de RH', 4800.00, '2021-11-05', 9),
('Miguel', 'Torres', 'activo', 'hashed_password_10', 'Contador General', 4600.00, '2021-12-01', 10),
('Andrea', 'Díaz', 'activo', 'hashed_password_11', 'Desarrollador Junior', 3000.00, '2023-01-15', 4),
('Roberto', 'Castillo', 'activo', 'hashed_password_12', 'Analista Junior', 2800.00, '2023-02-20', 3),
('Carmen', 'Vargas', 'activo', 'hashed_password_13', 'Asistente de Marketing', 2600.00, '2023-03-10', 6),
('Javier', 'Morales', 'activo', 'hashed_password_14', 'Representante de Ventas', 2700.00, '2023-04-05', 7),
('Patricia', 'Rojas', 'activo', 'hashed_password_15', 'Técnico de Soporte', 2500.00, '2023-05-12', 8),
('Ricardo', 'Silva', 'inactivo', 'hashed_password_16', 'Asistente de RH', 2400.00, '2022-08-15', 9),
('Isabel', 'Castro', 'activo', 'hashed_password_17', 'Asistente Contable', 2300.00, '2023-07-20', 10),
('Fernando', 'Ortega', 'activo', 'hashed_password_18', 'Diseñador Junior', 2200.00, '2023-08-25', 5),
('Gabriela', 'Mendoza', 'activo', 'hashed_password_19', 'Analista de Datos', 2900.00, '2023-09-30', 3),
('Daniel', 'Guerrero', 'activo', 'hashed_password_20', 'Desarrollador', 3100.00, '2023-10-15', 4);

INSERT INTO Fidelizacion (id_usuario, fecha_actividad, tipo_actividad, descripcion_actividad, puntos_otorgados) VALUES
(1, '2024-01-15', 'Taller de Innovación', 'Taller para fomentar ideas innovadoras', 50),
(1, '2024-02-15', 'Competencia de Proyectos', 'Competencia interna de proyectos', 75),
(1, '2024-03-15', 'Workshop Tecnológico', 'Workshop sobre nuevas tecnologías', 60),
(1, '2024-05-15', 'Seminario de Liderazgo', 'Seminario para desarrollar habilidades de liderazgo', 70),

(2, '2024-01-15', 'Taller de Innovación', 'Taller para fomentar ideas innovadoras', 50),
(2, '2024-02-28', 'Sesión de Team Building', 'Actividades para fortalecer equipos', 40),
(2, '2024-04-15', 'Programa de Mentoring', 'Sesiones de mentoring entre empleados', 55),
(2, '2024-06-14', 'Curso de Capacitación', 'Capacitación en habilidades blandas', 45),

(3, '2024-01-30', 'Charla Motivacional', 'Charla sobre crecimiento profesional', 30),
(3, '2024-03-29', 'Evento de Reconocimiento', 'Reconocimiento a empleados destacados', 45),
(3, '2024-05-31', 'Feria de Ideas', 'Espacio para presentar ideas de mejora', 50),
(3, '2024-07-12', 'Hackathon Interno', 'Competencia de programación interna', 80),

(4, '2024-02-15', 'Competencia de Proyectos', 'Competencia interna de proyectos', 75),
(4, '2024-04-30', 'Actividad Deportiva', 'Torneo interno deportivo', 35),
(4, '2024-06-28', 'Evento Social', 'Evento de integración social', 25),
(4, '2024-08-23', 'Programa de Voluntariado', 'Actividad de voluntariado corporativo', 60),

(5, '2024-03-15', 'Workshop Tecnológico', 'Workshop sobre nuevas tecnologías', 60),
(5, '2024-05-15', 'Seminario de Liderazgo', 'Seminario para desarrollar habilidades de liderazgo', 70),
(5, '2024-07-26', 'Charla de Bienestar', 'Charla sobre salud y bienestar laboral', 30),
(5, '2024-09-13', 'Competencia de Ideas', 'Competencia de ideas de negocio', 65),

(6, '2024-01-15', 'Taller de Innovación', 'Taller para fomentar ideas innovadoras', 50),
(6, '2024-04-15', 'Programa de Mentoring', 'Sesiones de mentoring entre empleados', 55),
(7, '2024-02-28', 'Sesión de Team Building', 'Actividades para fortalecer equipos', 40),
(7, '2024-05-31', 'Feria de Ideas', 'Espacio para presentar ideas de mejora', 50),
(8, '2024-03-29', 'Evento de Reconocimiento', 'Reconocimiento a empleados destacados', 45),
(8, '2024-06-14', 'Curso de Capacitación', 'Capacitación en habilidades blandas', 45),
(9, '2024-04-30', 'Actividad Deportiva', 'Torneo interno deportivo', 35),
(9, '2024-07-12', 'Hackathon Interno', 'Competencia de programación interna', 80),
(10, '2024-05-15', 'Seminario de Liderazgo', 'Seminario para desarrollar habilidades de liderazgo', 70),
(10, '2024-08-09', 'Workshop de Creatividad', 'Taller para desarrollar creatividad', 40),

(11, '2024-01-10', 'Taller de Comunicación', 'Mejorando habilidades interpersonales', 40),
(12, '2024-01-25', 'Jornada de Innovación', 'Propuestas para optimizar procesos', 50),

(13, '2024-02-12', 'Actividad de Voluntariado', 'Apoyo a comunidad local', 35),
(14, '2024-02-27', 'Workshop de Tecnología', 'Capacitación en nuevas herramientas', 55),

(15, '2024-03-08', 'Taller de Trabajo en Equipo', 'Colaboración efectiva', 45),
(16, '2024-03-22', 'Charla de Productividad', 'Gestión eficiente del tiempo', 40),

(17, '2024-04-10', 'Competencia de Innovación', 'Desarrollo de ideas creativas', 60),
(18, '2024-04-24', 'Seminario de Liderazgo', 'Formación en liderazgo estratégico', 50),

(19, '2024-05-07', 'Jornada de Capacitación', 'Entrenamiento técnico avanzado', 55),
(20, '2024-05-21', 'Evento de Bienestar', 'Actividades para la salud mental', 35),

(11, '2024-06-11', 'Hackathon Interno', 'Desarrollo de prototipos en equipo', 80),
(12, '2024-06-25', 'Competencia de Ideas', 'Ideas para mejorar procesos internos', 65),

(13, '2024-07-09', 'Taller de Comunicación', 'Fortalecimiento de la cultura organizacional', 45),
(14, '2024-07-23', 'Actividad de Integración', 'Evento social para fortalecer equipos', 30),

(15, '2024-08-06', 'Workshop de Creatividad', 'Dinámicas para fomentar la innovación', 50),
(16, '2024-08-20', 'Jornada de Reconocimiento', 'Celebración de logros del equipo', 40),

(17, '2024-09-05', 'Seminario de Tecnología', 'Actualización de herramientas digitales', 55),
(18, '2024-09-19', 'Taller de Liderazgo', 'Desarrollo de liderazgo participativo', 50),

(19, '2024-10-03', 'Competencia de Proyectos', 'Presentación de iniciativas internas', 70),
(20, '2024-10-17', 'Taller de Innovación', 'Fomento de la creatividad organizacional', 60),

(11, '2024-11-07', 'Workshop de Bienestar', 'Gestión emocional y salud laboral', 40),
(12, '2024-11-21', 'Seminario de Productividad', 'Metodologías ágiles en el trabajo', 45),

(13, '2024-12-05', 'Evento de Cierre Anual', 'Reconocimiento a colaboradores destacados', 70),
(14, '2024-12-19', 'Actividad Navideña', 'Convivencia y cultura organizacional', 50);

INSERT INTO Login (id_usuario, fecha_hora_login, estado_login) VALUES
(1, '2024-01-15 08:30:00', 'exitoso'),
(1, '2024-01-16 09:15:00', 'exitoso'),
(1, '2024-01-17 08:45:00', 'fallido'),
(1, '2024-01-18 09:00:00', 'exitoso'),
(2, '2024-01-15 08:20:00', 'exitoso'),
(2, '2024-01-16 08:25:00', 'exitoso'),
(2, '2024-01-17 09:30:00', 'exitoso'),
(3, '2024-01-15 08:35:00', 'exitoso'),
(3, '2024-01-16 08:40:00', 'fallido'),
(3, '2024-01-17 08:50:00', 'exitoso'),

(4, '2024-02-01 08:30:00', 'exitoso'),
(4, '2024-02-02 09:15:00', 'exitoso'),
(5, '2024-02-01 08:20:00', 'exitoso'),
(5, '2024-02-03 08:45:00', 'exitoso'),
(6, '2024-02-05 09:00:00', 'fallido'),
(6, '2024-02-06 08:35:00', 'exitoso'),
(7, '2024-02-07 08:40:00', 'exitoso'),
(8, '2024-02-08 09:10:00', 'exitoso'),
(9, '2024-02-09 08:50:00', 'exitoso'),
(10, '2024-02-10 08:30:00', 'fallido');

CREATE OR REPLACE VIEW v_DesempenoColaboradores AS
SELECT 
    u.id_usuario,
    CONCAT(u.nombre, ' ', u.apellido) AS nombre_completo,
    u.cargo,
    u.salario,
    u.fecha_ingreso,
    COALESCE(SUM(f.puntos_otorgados), 0) AS total_puntos_fidelizacion_acumulados,
    COALESCE(AVG(f.puntos_otorgados), 0) AS promedio_puntos_por_actividad,
    CASE 
        WHEN COALESCE(SUM(f.puntos_otorgados), 0) > 500 THEN 'Excelente'
        WHEN COALESCE(SUM(f.puntos_otorgados), 0) BETWEEN 200 AND 500 THEN 'Bueno'
        ELSE 'Regular'
    END AS estado_fidelizacion,
    DATEDIFF(CURDATE(), COALESCE(MAX(l.fecha_hora_login), u.fecha_ingreso)) AS dias_desde_ultimo_login
FROM Usuarios u
LEFT JOIN Fidelizacion f ON u.id_usuario = f.id_usuario
LEFT JOIN Login l ON u.id_usuario = l.id_usuario AND l.estado_login = 'exitoso'
GROUP BY u.id_usuario, u.nombre, u.apellido, u.cargo, u.salario, u.fecha_ingreso;

CREATE OR REPLACE VIEW v_actividadesPorPerfil AS
SELECT 
    p.id_perfil,
    p.nombre_perfil,
    p.descripcion_perfil,
    COUNT(DISTINCT u.id_usuario) AS cantidad_usuarios_con_este_perfil,
    COUNT(*) AS total_actividades_participadas_por_perfil,
    COALESCE(AVG(puntos_usuario.total_puntos), 0) AS promedio_puntos_por_usuario_en_este_perfil,
    ROUND((COUNT(*) * 100.0 / NULLIF((SELECT COUNT(*) FROM Fidelizacion), 0)), 2) AS porcentaje_participacion_total
FROM Perfiles p
LEFT JOIN Usuarios u ON p.id_perfil = u.id_perfil
LEFT JOIN Fidelizacion f ON u.id_usuario = f.id_usuario
LEFT JOIN (
    SELECT id_usuario, SUM(puntos_otorgados) AS total_puntos
    FROM Fidelizacion
    GROUP BY id_usuario
) puntos_usuario ON u.id_usuario = puntos_usuario.id_usuario
GROUP BY p.id_perfil, p.nombre_perfil, p.descripcion_perfil;

CREATE OR REPLACE VIEW v_historialLoginDetallado AS
SELECT 
    l.id_login,
    u.nombre,
    u.apellido,
    u.cargo,
    l.fecha_hora_login,
    l.estado_login,
    TIMESTAMPDIFF(
        MINUTE, 
        (SELECT MAX(l2.fecha_hora_login) 
         FROM Login l2 
         WHERE l2.id_usuario = l.id_usuario 
         AND l2.fecha_hora_login < l.fecha_hora_login),
        l.fecha_hora_login
    ) AS tiempo_desde_anterior_login_minutos
FROM Login l
JOIN Usuarios u ON l.id_usuario = u.id_usuario
ORDER BY u.id_usuario, l.fecha_hora_login;


SELECT nombre_completo, cargo, total_puntos_fidelizacion_acumulados, estado_fidelizacion
FROM v_DesempenoColaboradores
ORDER BY total_puntos_fidelizacion_acumulados DESC
LIMIT 5;

SELECT nombre_perfil, cantidad_usuarios_con_este_perfil, total_actividades_participadas_por_perfil, porcentaje_participacion_total
FROM v_actividadesPorPerfil
ORDER BY porcentaje_participacion_total DESC;

SELECT nombre_completo, cargo, dias_desde_ultimo_login
FROM v_DesempenoColaboradores
WHERE dias_desde_ultimo_login > 30
ORDER BY dias_desde_ultimo_login DESC;

SELECT 
    DATE_FORMAT(fecha_hora_login, '%Y-%m') AS mes,
    COUNT(CASE WHEN estado_login = 'exitoso' THEN 1 END) AS logins_exitosos,
    COUNT(CASE WHEN estado_login = 'fallido' THEN 1 END) AS logins_fallidos,
    COUNT(*) AS total_logins,
    ROUND((COUNT(CASE WHEN estado_login = 'exitoso' THEN 1 END) * 100.0 / COUNT(*)), 2) AS porcentaje_exitosos
FROM Login
GROUP BY DATE_FORMAT(fecha_hora_login, '%Y-%m')
ORDER BY mes DESC;
