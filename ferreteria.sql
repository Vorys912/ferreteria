CREATE TABLE cargos (
    car_id INTEGER PRIMARY KEY,
    car_desc VARCHAR(100)
);

CREATE TABLE deposito (
    id_deposito SERIAL PRIMARY KEY,
    desc_deposito VARCHAR(100)
);

CREATE TABLE empleados (
    emp_id INTEGER PRIMARY KEY,
    emp_nombre VARCHAR(50),
    emp_apellido VARCHAR(50),
    emp_ci INTEGER,
    emp_tel VARCHAR(50),
    car_id INTEGER,
    FOREIGN KEY (car_id) REFERENCES cargos(car_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE clientes (
    clie_id INTEGER PRIMARY KEY,
    clie_nom VARCHAR(50),
    clie_apell VARCHAR(50),
    clie_ci INTEGER
);

CREATE TABLE metodo_de_pago (
    met_id INTEGER PRIMARY KEY,
    met_desc VARCHAR(50)
);

CREATE TABLE proveedores (
    prov_id INTEGER PRIMARY KEY,
    prov_desc VARCHAR(50)
);

CREATE TABLE productos (
    prod_id INTEGER PRIMARY KEY,
    prod_nom VARCHAR(100),
    prod_precio DECIMAL
    
);

CREATE TABLE PROV_PRODUCTOS
(
prod_id INTEGER,
prov_id INTEGER,
FOREIGN KEY (prov_id) REFERENCES proveedores(prov_id) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (prod_id) REFERENCES productos(prod_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE deposito_producto (
    id_deposito INTEGER,
    id_producto INTEGER,
    cantidad INTEGER,
    FOREIGN KEY (id_deposito) REFERENCES deposito(id_deposito) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_producto) REFERENCES productos(prod_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Ventas (
    venta_id INTEGER PRIMARY KEY,
    venta_fecha DATE,
    venta_hora TIME,
    emp_id INTEGER,
    clie_id INTEGER,
    met_id INTEGER,
    total DECIMAL,
    FOREIGN KEY (emp_id) REFERENCES empleados(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (clie_id) REFERENCES clientes(clie_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (met_id) REFERENCES metodo_de_pago(met_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE det_ventas (
    venta_id INTEGER PRIMARY KEY,
    prod_id INTEGER,
    id_deposito INTEGER,
    det_cantidad INTEGER,
    det_precio DECIMAL,
    det_subtotal DECIMAL,
    FOREIGN KEY (venta_id) REFERENCES Ventas(venta_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (prod_id) REFERENCES productos(prod_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_deposito) REFERENCES deposito(id_deposito) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE compra (
    compra_id INTEGER PRIMARY KEY,
    compra_fecha DATE,
    compra_hora TIME,
    emp_id INTEGER,
    prov_id INTEGER,
    met_id INTEGER,
    total DECIMAL,
    FOREIGN KEY (emp_id) REFERENCES empleados(emp_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (prov_id) REFERENCES proveedores(prov_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (met_id) REFERENCES metodo_de_pago(met_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE det_compras (
    compra_id INTEGER,
    prod_id INTEGER,
    id_deposito INTEGER,
    det_cantidad INTEGER,
    det_precio DECIMAL,
    det_subtotal DECIMAL,
    FOREIGN KEY (compra_id) REFERENCES compra(compra_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (prod_id) REFERENCES productos(prod_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (id_deposito) REFERENCES deposito(id_deposito) ON UPDATE CASCADE ON DELETE RESTRICT
);