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

