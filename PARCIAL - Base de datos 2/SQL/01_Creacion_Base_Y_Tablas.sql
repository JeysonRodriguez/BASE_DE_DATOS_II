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
