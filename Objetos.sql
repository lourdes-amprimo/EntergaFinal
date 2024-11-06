-- Bk de tablas 
CREATE TABLE clientes_bk
LIKE clientes; 
INSERT INTO clientes_bk
SELECT * FROM clientes; 

CREATE TABLE empleados_bk
LIKE empleados; 
INSERT INTO empleados_bk
SELECT * FROM empleados; 

CREATE TABLE inventario_bk
LIKE inventario; 
INSERT INTO inventario_bk
SELECT * FROM inventario; 

CREATE TABLE pedidos_bk
LIKE pedidos; 
INSERT INTO pedidos_bk
SELECT * FROM pedidos; 

CREATE TABLE productos_bk
LIKE productos; 
INSERT INTO productos_bk
SELECT * FROM productos; 

CREATE TABLE proovedores_bk
LIKE proovedores; 
INSERT INTO proovedores_bk
SELECT * FROM proovedores; 

CREATE TABLE resenas_bk
LIKE resenas; 
INSERT INTO resenas_bk
SELECT * FROM resenas; 

CREATE TABLE ventas_bk
LIKE ventas; 
INSERT INTO ventas_bk
SELECT * FROM ventas; 

-- vistas
DROP VIEW IF EXISTS vw_pedidos_estado  ;
CREATE VIEW vw_pedidos_estado AS 
SELECT 
    YEAR (FechaPedido) AS ANIO, MONTH (FechaPedido) AS MES,
    COUNT(CASE WHEN Estado = 'Pendiente' THEN 1 END) AS Cantidad_Pendientes,
    COUNT(CASE WHEN Estado = 'Enviado' THEN 1 END) AS Cantidad_Enviados
FROM pedidos
GROUP BY YEAR (FechaPedido), MONTH (FechaPedido) ; 

DROP VIEW IF EXISTS vw_ventas_empleados_mes;
CREATE VIEW vw_ventas_empleados_mes AS 
SELECT 
 YEAR (FechaVenta) AS ANIO, MONTH (FechaVenta) AS MES, Id_empleados AS EMPLEADO,
 COUNT(Id_ventas) AS CANTIDAD_VENTAS
 FROM ventas
GROUP BY YEAR (FechaVenta), MONTH (FechaVenta), Id_empleados 
ORDER BY  ANIO ASC, MES ASC ; 

DROP VIEW IF EXISTS vw_compras_por_cliente;
CREATE VIEW vw_compras_por_cliente AS 
SELECT Id_cliente AS CLIENTE,
    COUNT(Id_ventas) AS Total_Compras
FROM ventas
WHERE 
    FechaVenta BETWEEN '2023-01-01' AND '2024-12-31'  
GROUP BY 
    Id_cliente;
    
DROP VIEW IF EXISTS vw_productos_stock;
CREATE VIEW vw_productos_stock AS
SELECT 
    Id_producto AS PRODUCTO_ID,
    Nombre AS NOMBRE_PRODUCTO,
    Stock AS CANTIDAD_DISPONIBLE,
    CASE 
        WHEN Stock < 50 THEN 'BAJO'
        ELSE 'SUFICIENTE'
    END AS ESTADO_STOCK
FROM productos;

DROP VIEW IF EXISTS vw_resenas_promedio;
CREATE VIEW vw_resenas_promedio AS
SELECT 
    c.Id_clientes AS CLIENTE_ID,
    CONCAT(c.Nombre, ' ', c.Apellido) AS NOMBRE_CLIENTE,
    COUNT(r.Id_resenas) AS TOTAL_RESENAS
FROM clientes c
LEFT JOIN resenas r ON c.Id_clientes = r.Id_clientes
GROUP BY c.Id_clientes;

-- Funciones
DELIMITER //
DROP FUNCTION IF EXISTS fn_total_clientes_registrados //
CREATE FUNCTION total_clientes_registrados ()
RETURNS INT 
DETERMINISTIC
READS SQL DATA 
BEGIN 
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM clientes;
    RETURN total;
END //

DELIMITER ;
-- Para llamar a la función y obtener el total de clientes registrados
SELECT fn_total_clientes_registrados();


DELIMITER //
DROP FUNCTION IF EXISTS fn_gama_producto //
CREATE FUNCTION fn_gama_producto (producto INT)
RETURNS VARCHAR (50)
DETERMINISTIC
READS SQL DATA 
BEGIN 
    DECLARE existencia INT;
    DECLARE tipo_gama VARCHAR (50); 
    DECLARE costo_producto DECIMAL(10,2);
    -- Verificar si el producto existe
    SELECT COUNT(*) INTO existencia 
    FROM tienda_virtual.productos
    WHERE id_producto = producto;
       IF existencia = 0 THEN 
                      RETURN "NO EXISTE"; 
            ELSE 
            SELECT precio INTO costo_producto 
            FROM tienda_virtual.productos
            WHERE id_producto = producto;
			CASE 
			  WHEN costo_producto <= 100 THEN
                SET tipo_gama = 'Baja Gama';
			  WHEN costo_producto BETWEEN 110 AND 299 THEN
                SET tipo_gama = 'Media Gama';
			  WHEN costo_producto >= 300 THEN
                SET tipo_gama = 'Alta Gama';
            ELSE
                SET tipo_gama = 'No Clasificado';
        END CASE;
         RETURN tipo_gama;
    END IF;
END //
DELIMITER ;

-- Para llamar a la función 
SELECT fn_gama_producto(20); 

SET SQL_SAFE_UPDATES = 1;
-- Procedimientos
DELIMITER //
DROP PROCEDURE IF EXISTS sp_actualizar_precio_producto//
CREATE PROCEDURE sp_actualizar_precio_producto (
    IN p_id_producto INT, 
    IN p_nuevo_precio DECIMAL(10, 2)
)
BEGIN
    UPDATE productos 
    SET precio = p_nuevo_precio 
    WHERE id_producto = p_id_producto;
END //
DELIMITER ;

-- CALL sp_actualizar_precio_producto(3, 299.99); (ejemplo para llamar a este procedure)

SET SQL_SAFE_UPDATES = 1;
-- Procedimientos
DELIMITER //
DROP PROCEDURE IF EXISTS sp_actualizar_mail_cliente//

CREATE PROCEDURE sp_actualizar_mail_cliente (
       IN p_id_cliente INT,
       IN p_nuevo_email VARCHAR(100)
)
BEGIN
    UPDATE clientes
    SET email = p_nuevo_email
    WHERE id_clientes = p_id_cliente;
END //
DELIMITER ;

CALL sp_actualizar_mail_cliente(1, 'juan.email@ejemplo.com');


-- Trigger de validacion (dejame ingresar solamente clientes que su fecha de registro sea mayor a 2024/08)
DROP TRIGGER IF EXISTS tienda_virtual.trigger_before_insert_validacion_fechaRegistro; 
DELIMITER //
CREATE TRIGGER tienda_virtual.trigger_before_insert_validacion_fechaRegistro
BEFORE INSERT ON tienda_virtual.clientes
FOR EACH ROW 
BEGIN 
   IF NEW.FechaRegistro <= '2024-08-31' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'RANGO DE FECHAS DESACTUALIZADO';
  END IF;  
END// 
DELIMITER ; 
-- INSERT INTO tienda_virtual.clientes 
-- VALUES ("15", 'Jesica', 'Lopez', NULL,"547858449", NULL, "2023-09-25 15:00:00" ); para que se vea el error en la validacion 

-- Crear la tabla de auditoría 
CREATE TABLE IF NOT EXISTS auditoria_puestos (
    Id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    Id_empleados INT,
    Puesto_anterior VARCHAR(100),
    Nuevo_puesto VARCHAR(100),
    Fecha_cambio DATETIME
);

DROP TRIGGER IF EXISTS tienda_virtual.before_update_trigger_actualizacion_puesto;
DELIMITER //
CREATE TRIGGER tienda_virtual.before_update_trigger_actualizacion_puesto
BEFORE UPDATE ON empleados
FOR EACH ROW
BEGIN
    -- Comprobar si el puesto ha cambiado
    IF OLD.Puesto = NEW.Puesto THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ESTA INGRESANDO EL MISMO PUESTO DE TRABAJO';
    ELSE
        -- Insertar el cambio en la tabla de auditoría
        INSERT INTO auditoria_puestos (Id_empleados, Puesto_anterior, Nuevo_puesto, Fecha_cambio)
        VALUES (OLD.Id_empleados, OLD.Puesto, NEW.Puesto, NOW());
    END IF;
END //
DELIMITER ;
-- SET SQL_SAFE_UPDATES = 1;
-- UPDATE tienda_virtual.empleados
-- SET puesto = 'Gerente'
-- WHERE Id_empleados = 1;

