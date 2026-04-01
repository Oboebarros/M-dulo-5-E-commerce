-- Script de Creación de Base de Datos para OboeMarket
-- Módulo 5

CREATE DATABASE IF NOT EXISTS oboemarket_db;
USE oboemarket_db;

-- 1. Tabla de Categorías 
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

-- 2. Tabla de Productos 
CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    descripcion_larga TEXT,
    precio DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    categoria VARCHAR(50) NOT NULL,
    subcategoria VARCHAR(50),
    imagen_url VARCHAR(255),
    material VARCHAR(100),
    nivel VARCHAR(50),
    stock INT DEFAULT 10,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tabla de Usuarios (Módulo 6: Seguridad y Roles)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    rol VARCHAR(20) NOT NULL DEFAULT 'CLIENT',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- DATOS DE PRUEBA (USUARIOS)
-- Contraseña 'admin123' encriptada con BCrypt (ejemplo)
INSERT INTO users (nombre, apellido, email, password, rol) VALUES 
('Admin', 'Oboe', 'admin@oboemarket.cl', '$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.TVuHOnu', 'ADMIN'),
('Cliente', 'Prueba', 'cliente@gmail.com', '$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.TVuHOnu', 'CLIENT');

-- 4. Tabla de Pedidos 
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(12, 2) NOT NULL,
    estado VARCHAR(20) DEFAULT 'PENDIENTE',
    FOREIGN KEY (customer_id) REFERENCES users(id)
);

-- 5. Tabla de Ítems de Pedido 
CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- LIMPIAR TABLA MANEJANDO RESTRICCIONES DE CLAVE FORÁNEA
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE order_items;
TRUNCATE TABLE orders;
TRUNCATE TABLE productos;
SET FOREIGN_KEY_CHECKS = 1;

-- DATOS DE PRUEBA (PRODUCTOS)
INSERT INTO productos (nombre, descripcion, precio, categoria, subcategoria, imagen_url) VALUES 
 ('Oboe Buffet Légende',      'Gama alta profesional de Buffet Crampon.',           9500000.00, 'Instrumentos', 'Profesional',    'assets/img/legende oboe 1.png'), 
 ('Oboe Buffet Prodige',      'Perfecto para estudiantes. Resina ABS.',             2200000.00, 'Instrumentos', 'Estudiante',     'assets/img/prodige 1.png'), 
 ('Estuche Reeds n Stuff (12)','Caja de madera para 12 cañas.',                      38000.00, 'Almacenamiento','Cañas',          'assets/img/caja 12.png'), 
 ('Estuche Reeds n Stuff (6)', 'Caja de madera para 6 cañas.',                       22000.00, 'Almacenamiento','Cañas',          'assets/img/caña 6.png'), 
 ('Navaja Chiarugi Económica', 'Navaja estudiante biselada.',                        25000.00, 'Herramientas', 'Navajas',        'assets/img/chiarugi economic.png'), 
 ('Navaja Chiarugi Profesional','Filo profesional para raspado preciso.',            52000.00, 'Herramientas', 'Navajas',        'assets/img/chiarugi desplegado.png'), 
 ('Mandril Chiarugi',          'Herramienta de montaje esencial.',                   22000.00, 'Herramientas', 'Montaje',        'assets/img/mandril.png'), 
 ('Hilo de Seda',              'Hilo resistente para atado de cañas.',               12000.00, 'Herramientas', 'Atado',          'assets/img/Hilo.png'), 
 ('Tubo Chiarugi N°2',         'Tudeles de precisión para montaje.',                  3500.00, 'Accesorios',   'Tubos',          'assets/img/tubo chiarugi.png'), 
 ('Palas Rigotti',             '10 palas de maderas seleccionadas.',                 18000.00, 'Accesorios',   'Materia Prima',  'assets/img/rigoti cañas.png'), 
 ('Soporte Oboe y Corno Inglés','Soporte doble de alta estabilidad.',                30000.00, 'Accesorios',   'Soportes',       'assets/img/SOPORTE OBOE Y CORNO INGLES.png'), 
 ('Colgador Oboe',             'Arnés cómodo para estudio.',                         25000.00, 'Accesorios',   'Correas',        'assets/img/collar 1.png');
