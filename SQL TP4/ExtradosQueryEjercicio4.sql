CREATE TABLE administradores (
    DNI VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    fecha_creacion DATE NOT NULL DEFAULT (CURRENT_DATE),
    fecha_baja DATE DEFAULT NULL,
    CHECK (LENGTH(DNI) <= 15),
    CHECK (LENGTH(nombre) >= 2),
    CHECK (LENGTH(nombre_usuario) >= 5),
    CHECK (LENGTH(contraseña) >= 8),
    CHECK (fecha_baja IS NULL OR fecha_baja > fecha_creacion)
);

CREATE TABLE recepcionistas (
    DNI VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    fecha_alta DATE NOT NULL DEFAULT (CURRENT_DATE),
    fecha_baja DATE DEFAULT NULL,
    id_creador VARCHAR(20),
	CHECK (LENGTH(DNI) <= 15),
    CHECK (LENGTH(nombre) >= 2),
    CHECK (LENGTH(nombre_usuario) >= 5),
    CHECK (LENGTH(contraseña) >= 8),
    CHECK (fecha_baja IS NULL OR fecha_baja > fecha_creacion),
    FOREIGN KEY (id_creador) REFERENCES administradores(DNI)
);

CREATE TABLE cuartos (
    numero_cuarto INT PRIMARY KEY,
    disponible BIT NOT NULL
);

CREATE TABLE estacionamiento (
    numero_lote INT PRIMARY KEY,
    disponible BIT NOT NULL
);

CREATE TABLE clientes (
    DNI VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_alta DATE NOT NULL DEFAULT (CURRENT_DATE),
    id_creador VARCHAR(20),
	CHECK (LENGTH(DNI) <= 15),
    CHECK (LENGTH(nombre) >= 2),
    FOREIGN KEY (id_creador) REFERENCES recepcionistas(DNI)
);

-- registros de entrada y salida
CREATE TABLE registros_estadia (
    registro_id INT AUTO_INCREMENT PRIMARY KEY,
    DNI_cliente VARCHAR(20) NOT NULL,
    numero_cuarto INT NOT NULL,
    numero_lote_estacionamiento INT,
    fecha_hora_entrada DATETIME NOT NULL,
    fecha_hora_salida DATETIME,
    FOREIGN KEY (DNI_cliente) REFERENCES clientes(DNI),
    FOREIGN KEY (numero_cuarto) REFERENCES cuartos(numero_cuarto),
    FOREIGN KEY (numero_lote_estacionamiento) REFERENCES estacionamiento(numero_lote)
);

-- Tabla de logs de acciones
CREATE TABLE logs_auditoria (
    auditoria_id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario VARCHAR(20) NOT NULL,
    accion ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    tabla_afectada VARCHAR(50) NOT NULL,
    mensaje VARCHAR(255),
    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de registros de limpieza
CREATE TABLE registros_limpieza (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registro_estadia_id INT,
    id_creador VARCHAR(20),
    FOREIGN KEY (id_creador) REFERENCES recepcionistas (DNI), -- quien mando a que se haga la limpieza
    FOREIGN KEY (registro_estadia_id) REFERENCES registros_estadia(registro_id)
);

CREATE USER 'administrador'@'localhost' IDENTIFIED BY 'admin';
CREATE USER 'recepcionista'@'localhost' IDENTIFIED BY 'recepcionista_password';

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'administrador'@'localhost';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'recepcionista'@'localhost';

GRANT ALL PRIVILEGES ON TP4.* TO 'administrador'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE ON TP4.recepcionistas TO 'recepcionista'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON TP4.cuartos TO 'recepcionista'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON TP4.estacionamiento TO 'recepcionista'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON TP4.clientes TO 'recepcionista'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON TP4.registros_estadia TO 'recepcionista'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON TP4.registros_limpieza TO 'recepcionista'@'localhost';

GRANT EXECUTE ON TP4.* TO 'administrador'@'localhost';
GRANT EXECUTE ON TP4.* TO 'recepcionista'@'localhost';

FLUSH PRIVILEGES;

 -- ACTIVIDAD 1
CREATE VIEW registrar_movimientos_clientes AS
SELECT reg.DNI_cliente, c.nombre AS nombre_cliente, reg.numero_cuarto, reg.fecha_hora_entrada, reg.fecha_hora_salida,
TIMESTAMPDIFF(HOUR, fecha_hora_entrada, fecha_hora_salida) AS horas_de_diferencia
FROM registros_estadia reg
INNER JOIN clientes c ON c.DNI = reg.DNI_cliente;

-- ACTIVIDAD 3
-- view
CREATE VIEW limpieza_cuarto AS
SELECT r.numero_cuarto AS Numero_Cuarto,
       r.DNI_cliente AS DNI_Cliente,
       c.nombre AS Nombre_Cliente,
       r.fecha_hora_salida AS Checkout_Cliente,
       r.fecha_hora_salida + INTERVAL 30 MINUTE AS Inicio_Limpieza,
       r.fecha_hora_salida + INTERVAL 120 MINUTE AS Fin_Limpieza,
       l.id_creador AS DNI_Recepcionista,
       rec.nombre as Nombre_Recepcionista
FROM registros_limpieza l
INNER JOIN registros_estadia r 
ON l.registro_estadia_id = r.registro_id
INNER JOIN recepcionistas rec
ON l.id_creador = rec.DNI
INNER JOIN clientes c
ON r.DNI_cliente = c.DNI;

-- stored procedure (la recepcionista lo ejecuta para ordenar una limpieza)
DELIMITER //
CREATE PROCEDURE ordenar_limpieza (
  IN input_usuario_recepcionista VARCHAR(50),
  IN input_numero_cuarto INT,
  IN datetime_checkout_cliente DATETIME
)
BEGIN
  DECLARE limpieza_hora DATETIME;

  -- Isi se le envia un NULL como fecha, setea la fecha_hora a la actual
  IF datetime_checkout_cliente IS NULL THEN
    SET datetime_checkout_cliente = CURRENT_TIMESTAMP;
  END IF;
  -- 2 horas de limpieza, ponele
  SET limpieza_hora = datetime_checkout_cliente + INTERVAL 120 MINUTE;

  UPDATE cuartos
  SET disponible = 1 -- el cuarto se setea como disponible cuando termina la limpieza
  WHERE numero_cuarto = input_numero_cuarto;

  SELECT c.numero_cuarto, rec.nombre AS nombre_recepcionista, limpieza_hora AS fecha_hora_limpieza
  FROM recepcionistas rec
  INNER JOIN cuartos c ON input_numero_cuarto = c.numero_cuarto
  WHERE rec.nombre_usuario = input_usuario_recepcionista;
END //
DELIMITER ;

-- ejecucion del _sp
CALL ordenar_limpieza('laura.fernandez', 101, NULL);

-- ACTIVIDAD 4
-- -> que estacionamiento utilizo X cliente cuando visito las instalaciones





