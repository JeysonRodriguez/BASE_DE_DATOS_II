
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
(10, '2024-08-09', 'Workshop de Creatividad', 'Taller para desarrollar creatividad', 40);

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
