-- Script de Creación de Base de Datos para OboeMarket
-- Módulo 5: Java Web (JSP + Servlets + DAO + MVC)

CREATE DATABASE IF NOT EXISTS oboemarket_db;
USE oboemarket_db;

-- 1. Tabla de Categorías (Requerido para diseño en la rúbrica)
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

-- 2. Tabla de Productos (Principal)
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

-- 3. Tabla de Clientes (Requerido por la rúbrica para el diseño)
CREATE TABLE IF NOT EXISTS customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    direccion TEXT,
    telefono VARCHAR(20),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Tabla de Pedidos (Requerido por la rúbrica para el diseño)
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(12, 2) NOT NULL,
    estado VARCHAR(20) DEFAULT 'PENDIENTE',
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- 5. Tabla de Ítems de Pedido (Requerido por la rúbrica para el diseño)
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

-- DATOS DE PRUEBA (PRODUCTOS) - 12 PRODUCTOS ÚNICOS
INSERT INTO productos (nombre, descripcion, descripcion_larga, precio, categoria, subcategoria, imagen_url, material, nivel) VALUES 
('Oboe Buffet Crampon Legende', 'Oboe profesional de alta gama.', 'El oboe Légende es un instrumento excepcional con un timbre rico y flexible. Fabricado con madera de granadilla seleccionada y llaves de plata.', 9500000, 'Instrumentos', 'Profesional', 'assets/img/legende oboe 1.png', 'Madera de Granadilla', 'Profesional'),
('Oboe Buffet Crampon Prodige', 'Oboe para estudiantes avanzados.', 'Diseñado para facilitar la transición al nivel profesional. Ofrece una respuesta rápida y una afinación impecable.', 4200000, 'Instrumentos', 'Estudiante', 'assets/img/prodige 1.png', 'Resina / Madera', 'Intermedio'),
('Mandril Chiarugi Oboe', 'Herramienta de precisión para el atado de cañas.', 'Mandril ergonómico de alta calidad para tubos Chiarugi. Indispensable para el oboísta moderno.', 35000, 'Herramientas', 'Atado', 'assets/img/mandril.png', 'Acero / Madera', 'Todos'),
('Tubo Chiarugi 47mm 2', 'Tubo estándar para cañas de oboe.', 'Tubo de latón con corcho natural. Proporciona una vibración estable y clara.', 4500, 'Accesorios', 'Cañas', 'assets/img/tubo chiarugi.png', 'Latón / Corcho', 'Todos'),
('Caña Rigoti Profesional', 'Caña terminada a mano lista para tocar.', 'Caña de dureza media, raspado europeo. Excelente proyección y estabilidad.', 18000, 'Accesorios', 'Cañas', 'assets/img/rigoti cañas.png', 'Arundo Donax', 'Profesional'),
('Hilo para Atado Rigoti', 'Hilo de nylon resistente para cañas.', 'Hilo de alta calidad disponible en varios colores para el atado profesional de cañas de oboe.', 8000, 'Herramientas', 'Atado', 'assets/img/Hilo.png', 'Nylon', 'Todos'),
('Soporte Doble Oboe/Corno', 'Soporte estable para dos instrumentos.', 'Soporte metálico con recubrimiento protector para oboe y corno inglés. Plegable y ligero.', 45000, 'Accesorios', 'Soportes', 'assets/img/SOPORTE OBOE Y CORNO INGLES.png', 'Metal', 'Todos'),
('Caja para 12 Cañas', 'Caja de madera con ventilación.', 'Caja elegante para almacenar hasta 12 cañas de oboe. Mantiene la humedad ideal.', 55000, 'Almacenamiento', 'Cajas', 'assets/img/caja 12.png', 'Madera de Nogal', 'Todos'),
('Estuche para 6 Cañas', 'Estuche compacto y seguro.', 'Estuche rígido para 6 cañas con interior de terciopelo. Ideal para el transporte diario.', 28000, 'Almacenamiento', 'Estuches', 'assets/img/caña 6.png', 'Plástico / Terciopelo', 'Todos'),
('Set Chiarugi Desplegado', 'Kit completo de herramientas.', 'Incluye mandril, bloque de corte y rascadores. Todo lo necesario para fabricar cañas.', 120000, 'Herramientas', 'Sets', 'assets/img/chiarugi desplegado.png', 'Varios', 'Avanzado'),
('Kit Chiarugi Economic', 'Kit básico de herramientas.', 'Versión económica con las herramientas esenciales para principiantes en el raspado.', 65000, 'Herramientas', 'Económico', 'assets/img/chiarugi economic.png', 'Varios', 'Principiante'),
('Collar Ergonómico', 'Collar ajustable con gancho metálico.', 'Reduce la tensión en el pulgar y cuello. Acolchado de alta densidad para mayor confort.', 32000, 'Accesorios', 'Soportes', 'assets/img/collar 1.png', 'Neopreno / Cuero', 'Todos');
