CREATE TABLE personas (
    dni VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    email VARCHAR(100)
);
CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(20),
    sueldo DECIMAL(10, 2),
    rol ENUM('vendedor', 'manager'),
    fecha_ingreso VARCHAR(10),
    fecha_egreso VARCHAR(10) DEFAULT NULL,
    FOREIGN KEY (dni) REFERENCES personas(dni)
);

CREATE TABLE vehiculos (
    id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
    patente VARCHAR(10),
    modelo VARCHAR(50),
    color VARCHAR(30),
    id_empleado INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

CREATE TABLE estacionamiento (
    patente VARCHAR(10),
    fecha_ingreso VARCHAR(10),
    lote VARCHAR(10),
    PRIMARY KEY (patente, fecha_ingreso)
);

CREATE TABLE productos (
    codigo_barra VARCHAR(20) PRIMARY KEY,
    descripcion VARCHAR(100),
    precio DECIMAL(10, 2)
);

CREATE TABLE ventas (
    dni VARCHAR(20), -- el que compro
    id_empleado INT, -- el que vendio
    codigo_barra VARCHAR(20),
    fecha_hora VARCHAR(20),
    PRIMARY KEY (id_empleado,fecha_hora), -- un empleado solo puede hacer una venta en una hora x
    FOREIGN KEY (dni) REFERENCES personas(dni),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

CREATE TABLE producto_venta( -- muchos productos a una sola venta
	id_empleado INT, -- quien hizo la venta de los productos
	codigo_barra VARCHAR(20), 
    fecha_hora VARCHAR(20),
    PRIMARY KEY(codigo_barra,fecha_hora), -- campos unicos que identifican la venta
    FOREIGN KEY (id_empleado, fecha_hora) REFERENCES ventas(id_empleado, fecha_hora), 
    -- cada campo en producto_venta debe corresponder a una venta en tabla ventas
    FOREIGN KEY (codigo_barra) REFERENCES productos(codigo_barra) -- identificacion de producto
);

-- 1, 2
CREATE VIEW empleados_sin_sueldo AS 
SELECT e.dni, e.rol, e.fecha_ingreso, e.fecha_egreso 
FROM empleados e
INNER JOIN personas p ON
p.dni = e.dni
WHERE e.fecha_egreso IS NULL -- actuales empleados

-- 3
CREATE VIEW vehiculos_de_empleados AS
SELECT v.id_vehiculo as Id, v.patente as Patente, v.modelo as Modelo, v.color as Color,
 CONCAT(p.nombre+' '+ p.apellido) AS Propietario,
e.dni AS DNI, e.rol AS Rol, e.fecha_ingreso AS Ingreso
FROM vehiculos AS v
INNER JOIN empleados e ON e.id_empleado = v.id_empleado
INNER JOIN personas p ON p.dni = e.dni
ORDER BY p.nombre DESC

-- 4
CREATE VIEW personas_no_empleadas AS
SELECT CONCAT(p.nombre+' '+ p.apellido) AS NombreCompleto, p.email AS Email, p.dni as DNI
FROM personas p
INNER JOIN empleados e ON e.dni = p.dni
WHERE e.fecha_ingreso IS NULL

-- 5
CREATE VIEW empleados_10_octubre AS 
SELECT CONCAT(p.nombre,' ', p.apellido) AS NombreCompleto, p.email AS Email, 
e.dni AS DNI, e.rol AS Rol, est.fecha_ingreso AS IngresoParking
FROM empleados e
INNER JOIN personas p ON p.dni = e.dni
INNER JOIN vehiculos v ON e.id_empleado = v.id_empleado
INNER JOIN estacionamiento est ON v.patente = est.patente
WHERE est.fecha_ingreso LIKE '10/10/2023'

-- 6
CREATE VIEW producto_comprado_persona AS
SELECT p.codigo_barra as CodigoProducto, p.descripcion, p.precio, v.fecha_hora AS FechaCompra
FROM ventas v
INNER JOIN personas pe ON v.dni = pe.dni -- traigo datos del comprador
INNER JOIN producto_venta pv 
ON v.id_empleado = pv.id_empleado
AND v.fecha_hora = pv.fecha_hora
INNER JOIN productos p ON pv.codigo_barra = p.codigo_barra
WHERE pe.dni = '36789111';

-- 7
CREATE VIEW monto_total_venta AS
SELECT COUNT(*) AS CantidadVentas,SUM(p.precio) AS MontoTotal, v.codigo_barra AS CodigoProducto, v.fecha_hora AS Fecha_Venta 
FROM ventas v
INNER JOIN productos p ON v.codigo_barra = p.codigo_barra -- prod asociado a una venta
WHERE v.id_empleado = 2
GROUP BY v.codigo_barra, v.fecha_hora;

create USER 'usuario_db'@'localhost' IDENTIFIED BY '123456'
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'usuario_db'@'localhost';

GRANT SELECT ON TP3.empleados_sin_sueldo TO 'usuario_db'@'localhost';
GRANT SELECT ON TP3.vehiculos_de_empleados TO 'usuario_db'@'localhost';
GRANT SELECT ON TP3.personas_no_empleadas TO 'usuario_db'@'localhost';
GRANT SELECT ON TP3.empleados_10_octubre TO 'usuario_db'@'localhost';
GRANT SELECT ON TP3.producto_comprado_persona TO 'usuario_db'@'localhost';
GRANT SELECT ON TP3.monto_total_venta TO 'usuario_db'@'localhost';

SHOW GRANTS FOR 'usuario_db'@'localhost';



