-- BASE DE DATOS VIDEOJUEGOS
CREATE DATABASE IF NOT EXISTS videojuegos;
USE videojuegos;

CREATE TABLE Desarrollador (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    pais VARCHAR(50)
);

CREATE TABLE Plataforma (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fabricante VARCHAR(100)
);

CREATE TABLE Genero (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Videojuego (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    fecha_lanzamiento DATE,
    precio DECIMAL(10,2),
    desarrollador_id INT,
    FOREIGN KEY (desarrollador_id) REFERENCES Desarrollador(id)
);

CREATE TABLE Videojuego_Plataforma (
    videojuego_id INT,
    plataforma_id INT,
    PRIMARY KEY (videojuego_id, plataforma_id),
    FOREIGN KEY (videojuego_id) REFERENCES Videojuego(id),
    FOREIGN KEY (plataforma_id) REFERENCES Plataforma(id)
);

CREATE TABLE Videojuego_Genero (
    videojuego_id INT,
    genero_id INT,
    PRIMARY KEY (videojuego_id, genero_id),
    FOREIGN KEY (videojuego_id) REFERENCES Videojuego(id),
    FOREIGN KEY (genero_id) REFERENCES Genero(id)
);

INSERT INTO Desarrollador (nombre, pais) VALUES
('Nintendo', 'Japón'),
('Ubisoft', 'Francia');

INSERT INTO Plataforma (nombre, fabricante) VALUES
('Switch', 'Nintendo'),
('PlayStation 5', 'Sony'),
('PC', 'Microsoft');

INSERT INTO Genero (nombre) VALUES
('Acción'), ('Aventura'), ('RPG');

INSERT INTO Videojuego (titulo, fecha_lanzamiento, precio, desarrollador_id) VALUES
('Zelda: Breath of the Wild', '2017-03-03', 59.99, 1),
('Assassins Creed Valhalla', '2020-11-10', 69.99, 2);

INSERT INTO Videojuego_Plataforma VALUES (1,1), (1,3), (2,2), (2,3);
INSERT INTO Videojuego_Genero VALUES (1,2), (1,3), (2,1), (2,2);

SELECT '=== TABLAS CREADAS ===' AS '';
SHOW TABLES;

SELECT '=== DESARROLLADORES ===' AS '';
SELECT * FROM Desarrollador;

SELECT '=== VIDEOJUEGOS CON RELACIONES ===' AS '';
SELECT v.titulo, d.nombre as desarrollador, p.nombre as plataforma, g.nombre as genero
FROM Videojuego v
JOIN Desarrollador d ON v.desarrollador_id = d.id
JOIN Videojuego_Plataforma vp ON v.id = vp.videojuego_id
JOIN Plataforma p ON vp.plataforma_id = p.id
JOIN Videojuego_Genero vg ON v.id = vg.videojuego_id
JOIN Genero g ON vg.genero_id = g.id;