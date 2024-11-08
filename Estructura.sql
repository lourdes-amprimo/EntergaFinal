
CREATE DATABASE  IF NOT EXISTS tienda_virtual ;
USE tienda_virtual;


-- creacion de tablas
DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes (
  Id_clientes int NOT NULL AUTO_INCREMENT,
  Nombre varchar(100) DEFAULT NULL,
  Apellido varchar(100) DEFAULT NULL,
  Email varchar(100) DEFAULT NULL,
  Teléfono varchar(15) DEFAULT NULL,
  Dirección varchar(255) DEFAULT NULL,
  FechaRegistro datetime DEFAULT NULL,
  PRIMARY KEY (Id_clientes)); 
  
  DROP TABLE IF EXISTS empleados;
  CREATE TABLE empleados (
  Id_empleados int NOT NULL AUTO_INCREMENT,
  Nombre varchar(100) DEFAULT NULL,
  Apellido varchar(100) DEFAULT NULL,
  Email varchar(100) DEFAULT NULL,
  Teléfono varchar(15) DEFAULT NULL,
  FechaContratación datetime DEFAULT NULL,
  Puesto varchar(100) DEFAULT NULL,
  Orden_recibida int DEFAULT NULL,
  PRIMARY KEY (Id_empleados));
  
  DROP TABLE IF EXISTS inventario;
  CREATE TABLE inventario (
  Id_Inventario int NOT NULL AUTO_INCREMENT,
  Descripción varchar(255) DEFAULT NULL,
  Id_productos int DEFAULT NULL,
  PRIMARY KEY (Id_Inventario),
  KEY Id_productos (Id_productos),
  CONSTRAINT fk_inventario FOREIGN KEY (Id_productos) REFERENCES productos (Id_producto));
  
  DROP TABLE IF EXISTS pedidos;
  CREATE TABLE pedidos (
  Id_pedidos int NOT NULL AUTO_INCREMENT,
  Id_empleados int DEFAULT NULL,
  FechaPedido datetime DEFAULT NULL,
  FechaEnvio datetime DEFAULT NULL,
  Estado varchar(50) DEFAULT NULL,
  PRIMARY KEY (Id_pedidos),
  KEY Id_empleados (Id_empleados),
  CONSTRAINT fk_pedidos_empleado FOREIGN KEY (Id_empleados) REFERENCES empleados (Id_empleados));
  
  DROP TABLE IF EXISTS productos;
  CREATE TABLE productos (
  Id_producto int NOT NULL AUTO_INCREMENT,
  Nombre varchar(100) DEFAULT NULL,
  Descripción varchar(255) DEFAULT NULL,
  Precio decimal(10,2) DEFAULT NULL,
  Id_proovedor int DEFAULT NULL,
  Stock int DEFAULT NULL,
  FechaAgregado datetime DEFAULT NULL,
  PRIMARY KEY (Id_producto),
  KEY Id_proovedor (Id_proovedor),
  CONSTRAINT fk_productos FOREIGN KEY (Id_proovedor) REFERENCES proovedores (Id_proovedor));
  
  DROP TABLE IF EXISTS proovedores;
  CREATE TABLE proovedores (
  Id_proovedor int NOT NULL AUTO_INCREMENT,
  Nombre varchar(100) DEFAULT NULL,
  Descripción varchar(255) DEFAULT NULL,
  Email varchar(100) DEFAULT NULL,
  PRIMARY KEY (Id_proovedor));
  
  DROP TABLE IF EXISTS resenas;
  CREATE TABLE resenas (
  Id_resenas int NOT NULL AUTO_INCREMENT,
  Descripción varchar(400) DEFAULT NULL,
  Id_clientes int DEFAULT NULL,
  PRIMARY KEY (Id_resenas),
  KEY Id_clientes (Id_clientes),
  CONSTRAINT fk_resenas FOREIGN KEY (Id_clientes) REFERENCES clientes (Id_clientes));
  
  DROP TABLE IF EXISTS ventas;
  CREATE TABLE ventas (
  Id_ventas int NOT NULL AUTO_INCREMENT,
  FechaVenta datetime DEFAULT NULL,
  Id_empleados int DEFAULT NULL,
  Id_cliente int DEFAULT NULL,
  Id_producto int DEFAULT NULL,
  PRIMARY KEY (Id_ventas),
  KEY Id_empleados (Id_empleados),
  KEY Id_cliente (Id_cliente),
  KEY Id_producto (Id_producto),
  CONSTRAINT fk_ventas_empleado FOREIGN KEY (Id_empleados) REFERENCES empleados (Id_empleados),
  CONSTRAINT fk_ventas_cliente FOREIGN KEY (Id_cliente) REFERENCES clientes (Id_clientes),
  CONSTRAINT fk_ventas_producto FOREIGN KEY (Id_producto) REFERENCES productos (Id_producto)); 
  
