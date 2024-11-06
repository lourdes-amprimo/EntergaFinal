-- insertamos datos 
  INSERT INTO clientes 
  VALUES (1,'Juan','Pérez','juan.perez@example.com','1234567890','Calle Falsa 123','2024-01-01 10:00:00'),
         (2,'Ana','García','ana.garcia@example.com','0987654321','Avenida Siempre Viva 456','2024-02-01 11:00:00'),
         (3,'Luis','Martínez','luis.martinez@example.com','1122334455','Paseo de la Reforma 456','2024-08-03 12:00:00'),
         (4,'Marta','Fernández','marta.fernandez@example.com','2233445566','Av. Libertador 789','2024-08-04 13:00:00'),
         (5,'Carlos','Hernández','carlos.hernandez@example.com','3344556677','Calle Mayor 101','2024-08-05 14:00:00'),
         (6,'Laura','Gómez','laura.gomez@example.com','4455667788','Boulevard de los Ilustres 202','2024-08-06 15:00:00'),
         (7,'Pedro','Jiménez','pedro.jimenez@example.com','5566778899','Av. Gran Bretaña 303','2024-08-07 16:00:00'),
         (8,'Sofia','Rodríguez','sofia.rodriguez@example.com','6677889900','Calle del Sol 404','2024-08-08 17:00:00'),
         (9,'Javier','Moreno','javier.moreno@example.com','7788990011','Avenida del Mar 505','2024-08-09 18:00:00'),
         (10,'Elena','Ruiz','elena.ruiz@example.com','8899001122','Plaza Central 606','2024-08-10 19:00:00');

INSERT INTO empleados
 VALUES (1,'Carlos','López','carlos.lopez@example.com','1122334455','2024-01-15 00:00:00','Vendedor',NULL),
		(2,'María','Martínez','maria.martinez@example.com','5544332211','2024-01-20 00:00:00','Cajero',NULL),
        (3,'Pedro','García','pedro.garcia@example.com','5678901234','2024-02-15 08:00:00','Asistente',NULL),
        (4,'María','Pérez','maria.perez@example.com','6789012345','2024-03-10 08:00:00','Vendedor',1002),
        (5,'Javier','Moreno','javier.moreno@example.com','7890123456','2024-04-05 08:00:00','Gerente',1003),
        (6,'Elena','Ruiz','elena.ruiz@example.com','8901234567','2024-05-12 08:00:00','Asistente',NULL),
        (7,'Ana','López','ana.lopez@example.com','9012345678','2024-06-10 08:00:00','Vendedor',1004),
        (8,'Luis','González','luis.gonzalez@example.com','0123456789','2024-07-15 08:00:00','Gerente',1005),
        (9,'Roberto','Sánchez','roberto.sanchez@example.com','1234567890','2024-08-01 08:00:00','Asistente',NULL),
        (10,'Marta','Hernández','marta.hernandez@example.com','2345678901','2024-08-02 08:00:00','Vendedor',1006);
 
 INSERT INTO inventario 
 VALUES (1,'Inventario de productos electrónicos',1),
        (2,'Inventario contable',2);

INSERT INTO pedidos 
VALUES (1,1,'2024-04-01 15:00:00','2024-04-02 10:00:00','Enviado'),
       (2,2,'2024-04-03 16:00:00','2024-04-04 12:00:00','Pendiente'),
	   (3,1,'2024-08-03 12:00:00','2024-08-04 13:00:00','Enviado'),
       (4,2,'2024-08-04 13:00:00',NULL,'Pendiente'),
       (5,1,'2024-08-05 14:00:00',NULL,'Pendiente'),
       (6,2,'2024-08-06 15:00:00','2024-08-07 16:00:00','Enviado'),
       (7,1,'2024-08-07 16:00:00',NULL,'Pendiente'),
       (8,2,'2024-08-08 17:00:00','2024-08-09 18:00:00','Enviado'),
       (9,1,'2024-08-09 18:00:00',NULL,'Pendiente'),
       (10,2,'2024-08-10 19:00:00',NULL,'Pendiente');
       
INSERT INTO productos 
VALUES (1,'Monitor 32','Monitor 32 pulgadas',100.00,1,50,'2024-03-01 12:00:00'),
       (2,'Monitor 27','Monitor 27 pulgadas',200.00,2,30,'2024-03-02 12:00:00'),
       (3,'Tablet','Tablet con pantalla de 10 pulgadas',300.00,1,75,'2024-08-03 11:00:00'),
       (4,'Auriculares','Auriculares inalámbricos con cancelación de ruido',150.00,2,200,'2024-08-04 12:00:00'),
       (5,'Smartwatch','Smartwatch con monitor de frecuencia cardíaca',200.00,2,150,'2024-08-05 13:00:00'),
       (6,'Cámara','Cámara digital con lente intercambiable',500.00,1,30,'2024-08-06 14:00:00'),
       (7,'Teclado','Teclado mecánico retroiluminado',100.00,1,80,'2024-08-07 15:00:00'),
       (8,'Ratón','Ratón ergonómico con ajuste de DPI',70.00,2,120,'2024-08-08 16:00:00'),
       (9,'Impresora','Impresora multifunción con wifi',250.00,2,40,'2024-08-09 17:00:00'),
       (10,'Altavoces','Altavoces Bluetooth portátiles',80.00,1,90,'2024-08-10 18:00:00');

INSERT INTO proovedores
 VALUES (1,'Proveedor Luis','Proveedor de productos electrónicos','contacto@proveedorLUIS.com'),
		(2,'Proveedor Bruno','Proveedor de productos electronico','ventas@proveedorBruno.com');
        
        
INSERT INTO resenas 
VALUES (1,'Excelente producto, muy satisfecho.',1),
(2,'La calidad no es la esperada.',2),
(3,'La calidad excelente',3),
(4,'Recomiendo, excelente lugar',4),
(5,'Volveria a comprar, buena calidad',5);

INSERT INTO ventas 
VALUES (1,'2024-05-01 14:00:00',1,1,1),
(2,'2024-06-02 15:00:00',3,2,2),
(3,'2024-07-05 22:00:00',5,9,3),
(4,'2024-05-03 17:00:00',2,8,4),
(5,'2024-08-03 18:00:00',4,2,2),
(6,'2024-07-11 09:00:00',9,5,7),
(7,'2024-05-15 10:00:00',2,4,5),
(8,'2024-05-22 19:00:00',1,3,9),
(9,'2024-05-25 13:00:00',3,2,6); 
