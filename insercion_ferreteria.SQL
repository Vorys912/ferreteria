-- Insertar un cargo
INSERT INTO cargos (car_id, car_desc) VALUES (1, 'Vendedor');

-- Insertar un depósito
INSERT INTO deposito (desc_deposito) VALUES ('Depósito Central');

-- Insertar un empleado
INSERT INTO empleados (emp_id, emp_nombre, emp_apellido, emp_ci, emp_tel, car_id)
VALUES (101, 'Lucía', 'Ramírez', 4820011, '0981-123456', 1);

-- Insertar un cliente
INSERT INTO clientes (clie_id, clie_nom, clie_apell, clie_ci)
VALUES (201, 'Carlos', 'González', 3689541);

-- Insertar método de pago
INSERT INTO metodo_de_pago (met_id, met_desc)
VALUES (1, 'Efectivo');

-- Insertar proveedor
INSERT INTO proveedores (prov_id, prov_desc)
VALUES (301, 'Distribuidora El Tornillo');

-- Insertar producto
INSERT INTO productos (prod_id, prod_nom, prod_precio)
VALUES (401, 'Martillo de hierro', 75000);

-- Relacionar producto con proveedor
INSERT INTO PROV_PRODUCTOS (prod_id, prov_id) VALUES (401, 301);

-- Agregar el producto al depósito
INSERT INTO deposito_producto (id_deposito, id_producto, cantidad)
VALUES (1, 401, 50);

-- Insertar venta
INSERT INTO Ventas (venta_id, venta_fecha, venta_hora, emp_id, clie_id, met_id, total)
VALUES (501, '2025-05-17', '09:30', 101, 201, 1, 150000);

-- Detalles de la venta
INSERT INTO det_ventas (venta_id, prod_id, id_deposito, det_cantidad, det_precio, det_subtotal)
VALUES (501, 401, 1, 2, 75000, 150000);
-- Actualizar el teléfono del empleado
UPDATE empleados
SET emp_tel = '0986-641463'
WHERE emp_id = 101;
-- Eliminar un cliente por su CI
DELETE FROM clientes
WHERE clie_ci = 3689541;
-- Vista que muestra resumen de ventas con nombre del cliente y empleado
CREATE VIEW vista_resumen_ventas AS
SELECT 
    V.venta_id,
    V.venta_fecha,
    C.clie_nom || ' ' || C.clie_apell AS cliente,
    E.emp_nombre || ' ' || E.emp_apellido AS empleado,
    V.total
FROM Ventas V
JOIN clientes C ON V.clie_id = C.clie_id
JOIN empleados E ON V.emp_id = E.emp_id;
-- IN
-- Productos con IDs específicos
SELECT * FROM productos
WHERE prod_id IN (401, 402, 403);
--NOT IN
-- Clientes que no realizaron compras (usando subconsulta)
SELECT * FROM clientes
WHERE clie_id NOT IN (1, 2, 4);
--LIKE
-- Productos que contienen la palabra 'martillo'
SELECT * FROM productos
WHERE prod_nom LIKE '%martillo%';
--GROUP BY
-- Total de ventas agrupado por método de pago
SELECT M.met_desc, COUNT(V.venta_id) AS cantidad_ventas, SUM(V.total) AS total_ventas
FROM Ventas V
JOIN metodo_de_pago M ON V.met_id = M.met_id
GROUP BY M.met_desc;
--BETWEEN
-- Ventas realizadas en un rango de fechas
SELECT * FROM Ventas
WHERE venta_fecha BETWEEN '2025-05-01' AND '2025-05-17';