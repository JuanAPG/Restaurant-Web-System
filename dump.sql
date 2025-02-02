CREATE TABLE IF NOT EXISTS ROLES (
    idRol INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

-- Insertar valores en ROLES
INSERT INTO ROLES (nombre) VALUES
('cliente'),
('admin'),
('staff');

-- Crear tabla TIPOS_STAFF
CREATE TABLE IF NOT EXISTS TIPOS_STAFF (
    idRolStaff INT PRIMARY KEY AUTO_INCREMENT,
    nombre_staff VARCHAR(255) NOT NULL
);

-- Insertar valores en TIPOS_STAFF
INSERT INTO TIPOS_STAFF (nombre_staff) VALUES
('Gerente'),
('Mesero'),
('Cocinero'),
('Repartidor');

-- Crear tabla USUARIOS_RESTAURANTE
CREATE TABLE IF NOT EXISTS USUARIOS_RESTAURANTE (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre_usuario VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    idRol INT NOT NULL,
    FOREIGN KEY (idRol) REFERENCES ROLES(idRol) ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO USUARIOS_RESTAURANTE (nombre_usuario, password, idRol) VALUES
('JuanGalvan', SHA2('666', 256), 2),
('FernandoOlivares', SHA2('666', 256), 2),
('PamelaRodriguez', SHA2('666', 256), 2),
('EstefaniaNajera', SHA2('666', 256), 2),
('JuanPe', SHA2('666', 256), 3),
('MariaLo', SHA2('666', 256), 1),
('CarlosGo', SHA2('666', 256), 1),
('AnaMar', SHA2('666', 256), 1),
('LuisSa', SHA2('666', 256), 1);

CREATE TABLE ROLES_STAFF (
    idUsuario INT NOT NULL,
    idRolStaff INT NOT NULL,
    FOREIGN KEY (idUsuario) REFERENCES USUARIOS_RESTAURANTE(idUsuario),
    FOREIGN KEY (idRolStaff) REFERENCES TIPOS_STAFF(idRolStaff)
);

INSERT INTO ROLES_STAFF VALUES
('5', '1');

CREATE TABLE PUNTOS_CLIENTES (
    idPuntos INT PRIMARY KEY AUTO_INCREMENT,
    cant_puntos INT NOT NULL
);

INSERT INTO PUNTOS_CLIENTES (cant_puntos) VALUES
(100),
(150),
(200),
(50),
(75);

CREATE TABLE STATUS_CLIENTES (
    idStatus INT PRIMARY KEY AUTO_INCREMENT,
    Status_Clientes VARCHAR(255)
);

INSERT INTO STATUS_CLIENTES (Status_Clientes) VALUES
('Activo'),
('Inactivo');


CREATE TABLE CLIENTES (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    idPuntos INT NOT NULL DEFAULT 0,
    idUsuario INT NOT NULL,
    idStatus INT NOT NULL DEFAULT 1,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (idUsuario) REFERENCES USUARIOS_RESTAURANTE(idUsuario),
    FOREIGN KEY (idPuntos) REFERENCES PUNTOS_CLIENTES(idPuntos),
    FOREIGN KEY (idStatus) REFERENCES STATUS_CLIENTES(idStatus)
);


INSERT INTO CLIENTES (idPuntos, idUsuario, idStatus, nombre, apellido, correo) VALUES
(1, 5, 1, 'Juan', 'Pérez','juan.perez@email.com'),
(2, 6, 1, 'María', 'López','maria.lopez@email.com'),
(3, 7, 2, 'Carlos', 'Gómez','carlos.gomez@email.com'),
(4, 8, 1, 'Ana', 'Martínez','ana.martinez@email.com'),
(5, 9, 2, 'Luis', 'Sánchez','luis.sanchez@email.com');


CREATE TABLE TELEFONOS_CLIENTE (
    idtelefono INT PRIMARY KEY AUTO_INCREMENT,
    idCliente INT NOT NULL,
    telefono VARCHAR(14),
    FOREIGN KEY (idCliente) REFERENCES CLIENTES(idCliente)
);

INSERT INTO TELEFONOS_CLIENTE (idCliente, telefono) VALUES
(1,'5551234567'),
(2,'5552345678'),
(4,'5553456789'),
(3,'5554567890'),
(5,'5555678901');

CREATE TABLE DIRECCIONES_CLIENTE (
    iddireccion INT PRIMARY KEY AUTO_INCREMENT,
    idCliente INT NOT NULL,
    direccion VARCHAR(255),
    FOREIGN KEY (idCliente) REFERENCES CLIENTES(idCliente)
);

INSERT INTO DIRECCIONES_CLIENTE (idCliente, direccion) VALUES
(1,'Calle Falsa 123, Ciudad, CP 12345'),
(2,'Av. Siempre Viva 456, Ciudad, CP 67890'),
(3,'Boulevard de los Héroes 789, Ciudad, CP 11223'),
(4,'Paseo de la Reforma 101, Ciudad, CP 33445'),
(5,'Plaza Mayor 202, Ciudad, CP 55667');

CREATE TABLE DETALLES_METODOPAGOS (
    idDetalleMetodoPago INT PRIMARY KEY AUTO_INCREMENT,
    num_tarjeta VARCHAR(255),
    fecha_expiracion DATE
);

INSERT INTO DETALLES_METODOPAGOS (num_tarjeta, fecha_expiracion) VALUES
('1234567812345678', '2025-12-31'),
('2345678923456789', '2024-10-31'),
('3456789034567890', '2026-05-31');

CREATE TABLE METODOPAGOS (
    idMetodoPago INT PRIMARY KEY AUTO_INCREMENT,
    nombre_metodo VARCHAR(255),
    idCliente INT NOT NULL,
    idDetalleMetodoPago INT,
    FOREIGN KEY (idDetalleMetodoPago) REFERENCES DETALLES_METODOPAGOS (idDetalleMetodoPago),
    FOREIGN KEY (idCliente) REFERENCES CLIENTES (idCliente)
);

INSERT INTO METODOPAGOS (nombre_metodo, idCliente, idDetalleMetodoPago) VALUES
('Visa', 1, 1),
('MasterCard', 2, 2),
('American Express', 3, NULL),
('Discover', 4, 3),
('Efectivo', 5, NULL);

CREATE TABLE CATEGORIAS (
    idCategoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50)
);

INSERT INTO CATEGORIAS (nombre) VALUES
('Rollo Frío'),
('Rollo Caliente'),
('Entrante'),
('Postre');

CREATE TABLE STATUS_RESERVAS (
    idStatus INT PRIMARY KEY AUTO_INCREMENT,
    Status_Reservas VARCHAR(255)
);

INSERT INTO STATUS_RESERVAS (Status_Reservas) VALUES
('Completada'),
('Pendiente'),
('Cancelada');

CREATE TABLE RESERVAS (
    idReserva INT PRIMARY KEY AUTO_INCREMENT,
    fecha_reserva DATE NOT NULL,
    hora_reserva TIME NOT NULL,
    num_personas INT NOT NULL,
    idStatus INT NOT NULL,
    tema VARCHAR(100),
    idCliente INT NOT NULL,
    FOREIGN KEY (idStatus) REFERENCES STATUS_RESERVAS (idStatus),
    FOREIGN KEY (idCliente) REFERENCES CLIENTES (idCliente)
);

INSERT INTO RESERVAS (fecha_reserva, hora_reserva, num_personas, idStatus, tema, idCliente) VALUES
('2024-11-20', '19:00:00', 4, 1, 'Reunión de trabajo', 1), 
('2024-12-25', '13:30:00', 2, 2, 'Comida de navidad', 2),  
('2024-11-30', '18:00:00', 6, 3, 'Cena con amigos', 3),   
('2024-12-01', '20:00:00', 3, 1, 'Cena familiar', 4),       
('2024-08-15', '14:00:00', 5, 3, 'Reunión de equipo', 5),  
('2023-09-10', '12:00:00', 2, 2, 'Comida de trabajo', 5);

CREATE TABLE PLATILLOS (
    idPlatillo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    imagen_URL TEXT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    descripcion VARCHAR(255),
    inventario INT,
    idCategoria INT,
    FOREIGN KEY (idCategoria) REFERENCES CATEGORIAS(idCategoria)
);

INSERT INTO PLATILLOS (nombre, imagen_URL, precio, descripcion, inventario, idCategoria) VALUES
('Tostada de Atún', 'https://media-cdn.tripadvisor.com/media/photo-s/18/84/96/2b/tostada-de-atun-fresco.jpg', 100.00, 'Aleta azul, aioli de búfalo, aguacate, cilantro', 20, 1),
('Tostada de Hamachi Aji', 'https://www.foodgal.com/wp-content/uploads/2022/10/Juniper-Ivy-hamachi-tostada.jpg', 120.00, 'Yuzu-soya, aji amarillo, mayo ajo tatemado, cebollín, furakake shiso', 0, 1),
('Batera de Toro', 'https://losarrocesdekiko.com/wp-content/uploads/2022/04/Rabo-de-toro--scaled.jpg', 140.00, 'Aleta azul, yuzu-aioli, aguacate, aji amarillo', 10, 1),
('Batera de Salmón', 'https://media-cdn.tripadvisor.com/media/photo-s/1d/3f/0b/0e/batera-de-salmao.jpg', 130.00, 'Salmón, aioli habanero, lemon soy, cebollín, cilantro criollo', 18, 1),
('Tarta de Toro', 'https://cdn7.kiwilimon.com/recetaimagen/29776/960x720/31682.jpg.webp', 150.00, 'Aleta azul, vinagreta yuzu-trufa', 12, 1),
('Edamame', 'https://misssushi.es/wp-content/uploads/edamame.jpg', 80.00, 'Sal Maldon, salsa negra, polvo piquín', 0, 2),
('Shishitos', 'https://www.justonecookbook.com/wp-content/uploads/2022/08/Blistered-Shishito-Peppers-With-Ginger-Soy-Sauce-9223-II.jpg', 90.00, 'Sal Maldon, limón california', 20, 2),
('Papás Fritas', 'https://kodamasushi.cl/wp-content/uploads/2019/08/papas-fritas-touri-sushi02.jpg', 70.00, 'Sal matcha, soya-trufa', 30, 2),
('Camarones Roca', 'https://i0.wp.com/cucharamia.com/wp-content/uploads/2021/07/camarones-roca.jpg?w=798&ssl=1', 180.00, 'Soya dulce, mayo-picante, ajonjolí', 15, 2),
('Jalapeño Poppers', 'https://www.recipetineats.com/tachyon/2024/02/Jalapeno-poppers_2.jpg?resize=1200%2C1500&zoom=0.54', 160.00, 'Cangrejo, atún aleta azul, queso feta, soya-yuzu', 25, 2),
('Huachinango Tempura', 'https://tofuu.getjusto.com/orioneat-local/resized2/rcgzQe2pLxFQT8Ghw-800-x.webp', 200.00, 'Sal Maldon, salsa negra, polvo piquín', 18, 2);

CREATE TABLE TIPOSPROMOCION (
    idTipoPromocion INT PRIMARY KEY AUTO_INCREMENT,
    tipo_promocion VARCHAR(255)
);

INSERT INTO TIPOSPROMOCION (tipo_promocion) VALUES
('VeranoLoco'),
('Black Friday'), 
('Navidad'),    
('Día del Cliente');

CREATE TABLE PROMOCIONES (
    idPromocion INT PRIMARY KEY AUTO_INCREMENT,
    idTipoPromocion INT NOT NULL,
    idPlatillo INT NOT NULL,
    descuento DECIMAL(5, 2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    FOREIGN KEY (idTipoPromocion) REFERENCES TIPOSPROMOCION(idTipoPromocion),
    FOREIGN KEY (idPlatillo) REFERENCES PLATILLOS(idPlatillo)
);

INSERT INTO PROMOCIONES (idTipoPromocion, idPlatillo, descuento, fecha_inicio, fecha_fin, descripcion) VALUES
(1, 1, 15.00, '2024-06-01', '2024-06-30', 'Descuento del 15% en todos los rollos fríos para celebrar el verano.'),
(1, 2, 15.00, '2024-06-01', '2024-06-30', 'Descuento del 15% en Tostada de Hamachi Aji durante el verano.'),
(1, 3, 15.00, '2024-06-01', '2024-06-30', 'Descuento del 15% en Batera de Toro para refrescarte este verano.'),
(2, 4, 20.00, '2024-11-25', '2024-11-30', 'Descuento del 20% en Tostada de Salmón por Black Friday.'),
(2, 5, 20.00, '2024-11-25', '2024-11-30', 'Descuento del 20% en Tartar de Toro durante Black Friday.'),
(2, 6, 20.00, '2024-11-25', '2024-11-30', 'Descuento del 20% en Edamame para el Black Friday.'),
(3, 7, 10.00, '2024-12-01', '2024-12-25', 'Descuento del 10% en Camarones Roca para celebrar la Navidad.'),
(3, 8, 10.00, '2024-12-01', '2024-12-25', 'Descuento del 10% en Papás Fritas durante Navidad.'),
(3, 9, 10.00, '2024-12-01', '2024-12-25', 'Descuento del 10% en Jalapeño Poppers por Navidad.'),
(4, 10, 25.00, '2024-10-01', '2024-10-31', 'Descuento del 25% en todos los platillos por el Día del Cliente.'),
(4, 11, 25.00, '2024-10-01', '2024-10-31', 'Descuento del 25% en Huachinango Tempura por el Día del Cliente.');

CREATE TABLE STATUS_PEDIDO (
    idStatus INT PRIMARY KEY AUTO_INCREMENT,
    nombre_status VARCHAR(255)
);

INSERT INTO STATUS_PEDIDO (nombre_status) VALUES
('Orden Recibida'),
('En Preparación'), 
('Pedido Completo'),
('Cancelado'); 

CREATE TABLE PEDIDOS (
    idPedido INT PRIMARY KEY AUTO_INCREMENT,
    fecha_pedido DATE NOT NULL,
    fecha_entrega DATE,
    total_pedido DECIMAL(10, 2) NOT NULL,
    idCliente INT NOT NULL,
    idStatus INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES CLIENTES(idCliente),
    FOREIGN KEY (idStatus) REFERENCES STATUS_PEDIDO(idStatus)
);

INSERT INTO PEDIDOS (fecha_pedido, fecha_entrega, total_pedido, idStatus, idCliente) VALUES
('2024-11-01', '2024-11-02', 250.00, 1, 2),  
('2024-11-02', '2024-11-03', 300.00, 2, 2), 
('2024-11-03', '2024-11-04', 150.00, 3, 3), 
('2024-11-04', '2024-11-05', 200.00, 1, 4),   
('2024-11-05', '2024-11-06', 180.00, 1, 4),   
('2024-11-06', '2024-11-07', 220.00, 2, 5), 
('2024-11-07', '2024-11-08', 270.00, 1, 5); 

CREATE TABLE DETALLESPEDIDO (
    idPedido INT,
    idPlatillo INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (idPedido, idPlatillo),
    FOREIGN KEY (idPedido) REFERENCES PEDIDOS(idPedido),
    FOREIGN KEY (idPlatillo) REFERENCES PLATILLOS(idPlatillo)
);

INSERT INTO DETALLESPEDIDO (idPedido, idPlatillo, cantidad, precio_unitario) VALUES
(1, 1, 2, 50.00),  
(1, 2, 1, 150.00),
(2, 3, 2, 100.00), 
(2, 4, 1, 200.00), 
(3, 5, 1, 150.00), 
(3, 6, 3, 100.00),
(4, 7, 2, 150.00),  
(5, 8, 2, 130.00), 
(5, 9, 1, 180.00), 
(6, 10, 3, 90.00),  
(7, 11, 1, 70.00);  

CREATE TABLE TIPOS_RESENA (
    idTipoResena INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255)
);

INSERT INTO TIPOS_RESENA (nombre) VALUES
('Restaurante'),
('Platillo');

CREATE TABLE RESENAS (
    idResena INT PRIMARY KEY AUTO_INCREMENT,
    puntuacion INT NOT NULL,
    titulo VARCHAR(50) NOT NULL,
    comentario TEXT NOT NULL,
    fecha_comentario DATE NOT NULL,
    idCliente INT,
    idTipoResena INT NOT NULL,
    idPedido INT ,
    FOREIGN KEY (idCliente) REFERENCES CLIENTES(idCliente),
    FOREIGN KEY (idPedido) REFERENCES PEDIDOS(idPedido),
    FOREIGN KEY (idTipoResena) REFERENCES TIPOS_RESENA(idTipoResena) ON DELETE CASCADE
);

INSERT INTO RESENAS (puntuacion, titulo, comentario, fecha_comentario, idCliente, idTipoResena, idPedido) VALUES
(5, 'Increíble experiencia', 'Excelente ambiente, atención de primera y los platillos deliciosos. Sin duda volveré.', '2024-11-15', 2, 2, 2), 
(4, 'Buen servicio', 'El servicio fue bueno, pero la comida estuvo un poco más salada de lo que esperaba.', '2024-11-16', 2, 2, 1), 
(3, 'Regular', 'El lugar es bonito, pero el servicio fue lento y algunos platillos no estaban disponibles.', '2024-11-17', 3, 1, null),
(5, 'Espectacular platillo', 'El Tartar de Toro es espectacular, fresco y con un sabor único.', '2024-11-18', 4, 2, 4),
(4, 'Delicioso Edamame', 'El Edamame estuvo delicioso, aunque podría mejorar la presentación.', '2024-11-19', 5, 2, 6),
(5, 'Recomendado', 'Las Tostadas de Atún fueron una maravilla, todo en su punto perfecto. ¡Altamente recomendable!', '2024-11-20', 5, 2, 7);

CREATE TABLE RESTAURANTES (
    idRestaurante INT PRIMARY KEY AUTO_INCREMENT,
    nombre_sucursal VARCHAR(255),
    ubicacion TEXT,
    telefono VARCHAR(20) NOT NULL,
    descripcion TEXT
);

INSERT INTO RESTAURANTES (nombre_sucursal, ubicacion, telefono, descripcion) VALUES
('Sucursal Valle Oriente', 'Av. Gonzalitos 123, Col. Valle Oriente, Monterrey, N.L.', '81-1234-5678', 'Se trata de una sucursal moderna con un ambiente acogedor, ideal para cenas familiares y reuniones de negocios.'),
('Sucursal Centro', 'Paseo Santa Lucía 456, Col. Centro, Monterrey, N.L.', '81-2345-6789', 'Ubicada en el corazón de Monterrey, ofrece una experiencia gastronómica única con sabores frescos y auténticos.'),
('Sucursal Carretera Nacional', 'Carretera Nacional 789, Col. Cumbres, Monterrey, N.L.', '81-3456-7890', 'Ofrece un espacio amplio y cómodo, ideal para disfrutar de un almuerzo en familia o una cena con amigos.');
