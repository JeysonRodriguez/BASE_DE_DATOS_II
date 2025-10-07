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

