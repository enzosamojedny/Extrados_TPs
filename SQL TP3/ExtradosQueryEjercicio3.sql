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
CREATE TABLE venta_producto (
	dni VARCHAR(20),
    codigo_barra VARCHAR(20),
    cantidad INT,
    PRIMARY KEY (codigo_barra, dni),
    FOREIGN KEY (codigo_barra) REFERENCES productos(codigo_barra)
);

CREATE TABLE ventas (
    dni VARCHAR(20),
    id_empleado INT,
    codigo_barra VARCHAR(20),
    fecha_hora VARCHAR(20),
    PRIMARY KEY (dni, codigo_barra, fecha_hora),
    FOREIGN KEY (dni) REFERENCES empleado(dni),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (codigo_barra) REFERENCES productos(codigo_barra)
);
create USER 'usuario_db'@'localhost' IDENTIFIED BY '123456'

-- 1, 2
CREATE VIEW empleados_sin_sueldo AS 
SELECT e.dni, e.rol, e.fecha_ingreso, e.fecha_egreso 
FROM empleados e
INNER JOIN personas p ON
p.dni = e.dni
WHERE e.fecha_egreso IS NULL -- actuales empleados

-- 3
CREATE VIEW vehiculos_de_empleados AS
SELECT CONCAT(v.patente, v.modelo, v.color) AS Vehiculo, CONCAT(p.nombre+' '+ p.apellido) AS Propietario,
e.dni AS DNI, e.rol AS Rol, e.fecha_ingreso AS Ingreso, e.fecha_egreso AS Egreso
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
-- tomar aquellos que usaron estacionamiento como los que se presentaron a trabajar
CREATE VIEW empleados_10_octubre AS 
SELECT CONCAT(p.nombre,' ', p.apellido) AS NombreCompleto, p.email AS Email, 
e.dni AS DNI, e.rol AS Rol, est.fecha_ingreso AS IngresoEstacionamiento
FROM empleados e
INNER JOIN personas p ON p.dni = e.dni
INNER JOIN vehiculos v ON e.id_empleado = v.id_empleado
INNER JOIN estacionamiento est ON v.patente = est.patente
WHERE est.fecha_ingreso LIKE '10/10/2023'

-- 6
CREATE VIEW producto_comprado_36789111 AS
SELECT p.codigo_barra, p.descripcion, p.precio, vp.cantidad
FROM personas pe
INNER JOIN ventas v ON pe.dni = v.dni
INNER JOIN venta_producto vp ON v.codigo_barra = vp.codigo_barra
INNER JOIN productos p ON vp.codigo_barra = p.codigo_barra
WHERE pe.dni = '36789111';


