-- usé un cursor, porque necesitaba una forma de loop que iterara row por row para ir
-- sumando 200 por cada empleado... 
-- un while loop insertaba todos a la vez
DELIMITER //
CREATE PROCEDURE CrearEmpleado()
BEGIN
DECLARE salarioInicial int DEFAULT 3000;
DECLARE cantidadPersonas int DEFAULT 1;
DECLARE salarioAumentado int DEFAULT 0;
DECLARE terminado bool DEFAULT FALSE;

    DECLARE personaId INT;
    DECLARE personaNombre VARCHAR(50);
    DECLARE personaEmail VARCHAR(50);
    DECLARE empleadoSalario INT;
    DECLARE empleadoPosicion VARCHAR(10);
    
DECLARE empleado_cursor CURSOR FOR

        -- esta query te trae personas que no son empleados
			SELECT p.id, p.nombre, p.email,e.salario,e.posicion
			FROM personas p
			LEFT JOIN empleados e
			ON p.id = e.id_persona 
			WHERE e.id_persona IS NULL
            LIMIT 40; -- o setea el limite a lo que quieras, para que no inserte todas las personas
DECLARE CONTINUE HANDLER FOR NOT FOUND 
SET terminado = TRUE; 

OPEN empleado_cursor;
read_loop: LOOP
		FETCH empleado_cursor INTO personaId, personaNombre, personaEmail,empleadoSalario, empleadoPosicion; -- campos que quiero en las tablas
		IF terminado THEN
			LEAVE read_loop; -- cuando llegue al final del row, terminado se setea a true y se sale del loop
		END IF;
        INSERT INTO empleados (id_persona, posicion, salario, fecha_baja)
        VALUES (personaId, 'op' , salarioInicial + salarioAumentado ,NULL);
	    SET cantidadPersonas = cantidadPersonas+1; -- hasta llegar a 40, condicion de corte
        SET salarioAumentado = salarioAumentado + 200; -- aumenta en 200 por cada row
        END LOOP;
        CLOSE empleado_cursor;
END //
DELIMITER ;

CALL CrearEmpleado(); -- ejecuto el _sp

-- query para traer las personas que SI SON empleados
   SELECT p.id,p.nombre,p.email, e.posicion,e.id_persona,e.salario,e.fecha_baja
    FROM personas p
    LEFT JOIN empleados e
    ON p.id = e.id_persona 

-- inserts
INSERT INTO personas VALUES(1, 'Pedro Lopez', 'pedro.lopez1@gmail.com');
INSERT INTO personas VALUES(2, 'Juan Perez', 'juan.perez2@gmail.com');
INSERT INTO personas VALUES(3, 'Luis Garcia', 'luis.garcia3@gmail.com');
INSERT INTO personas VALUES(4, 'Carlos Sanchez', 'carlos.sanchez4@gmail.com');
INSERT INTO personas VALUES(5, 'Miguel Fernandez', 'miguel.fernandez5@gmail.com');
INSERT INTO personas VALUES(6, 'Jose Martinez', 'jose.martinez6@gmail.com');
INSERT INTO personas VALUES(7, 'Manuel Diaz', 'manuel.diaz7@gmail.com');
INSERT INTO personas VALUES(8, 'Antonio Torres', 'antonio.torres8@gmail.com');
INSERT INTO personas VALUES(9, 'Jorge Ramirez', 'jorge.ramirez9@gmail.com');
INSERT INTO personas VALUES(10, 'Andres Gomez', 'andres.gomez10@gmail.com');
INSERT INTO personas VALUES(11, 'Pedro Lopez', 'pedro.lopez11@gmail.com');
INSERT INTO personas VALUES(12, 'Juan Perez', 'juan.perez12@gmail.com');
INSERT INTO personas VALUES(13, 'Luis Garcia', 'luis.garcia13@gmail.com');
INSERT INTO personas VALUES(14, 'Carlos Sanchez', 'carlos.sanchez14@gmail.com');
INSERT INTO personas VALUES(15, 'Miguel Fernandez', 'miguel.fernandez15@gmail.com');
INSERT INTO personas VALUES(16, 'Jose Martinez', 'jose.martinez16@gmail.com');
INSERT INTO personas VALUES(17, 'Manuel Diaz', 'manuel.diaz17@gmail.com');
INSERT INTO personas VALUES(18, 'Antonio Torres', 'antonio.torres18@gmail.com');
INSERT INTO personas VALUES(19, 'Jorge Ramirez', 'jorge.ramirez19@gmail.com');
INSERT INTO personas VALUES(20, 'Andres Gomez', 'andres.gomez20@gmail.com');
INSERT INTO personas VALUES(21, 'Pedro Lopez', 'pedro.lopez21@gmail.com');
INSERT INTO personas VALUES(22, 'Juan Perez', 'juan.perez22@gmail.com');
INSERT INTO personas VALUES(23, 'Luis Garcia', 'luis.garcia23@gmail.com');
INSERT INTO personas VALUES(24, 'Carlos Sanchez', 'carlos.sanchez24@gmail.com');
INSERT INTO personas VALUES(25, 'Miguel Fernandez', 'miguel.fernandez25@gmail.com');
INSERT INTO personas VALUES(26, 'Jose Martinez', 'jose.martinez26@gmail.com');
INSERT INTO personas VALUES(27, 'Manuel Diaz', 'manuel.diaz27@gmail.com');
INSERT INTO personas VALUES(28, 'Antonio Torres', 'antonio.torres28@gmail.com');
INSERT INTO personas VALUES(29, 'Jorge Ramirez', 'jorge.ramirez29@gmail.com');
INSERT INTO personas VALUES(30, 'Andres Gomez', 'andres.gomez30@gmail.com');
INSERT INTO personas VALUES(31, 'Pedro Lopez', 'pedro.lopez31@gmail.com');
INSERT INTO personas VALUES(32, 'Juan Perez', 'juan.perez32@gmail.com');
INSERT INTO personas VALUES(33, 'Luis Garcia', 'luis.garcia33@gmail.com');
INSERT INTO personas VALUES(34, 'Carlos Sanchez', 'carlos.sanchez34@gmail.com');
INSERT INTO personas VALUES(35, 'Miguel Fernandez', 'miguel.fernandez35@gmail.com');
INSERT INTO personas VALUES(36, 'Jose Martinez', 'jose.martinez36@gmail.com');
INSERT INTO personas VALUES(37, 'Manuel Diaz', 'manuel.diaz37@gmail.com');
INSERT INTO personas VALUES(38, 'Antonio Torres', 'antonio.torres38@gmail.com');
INSERT INTO personas VALUES(39, 'Jorge Ramirez', 'jorge.ramirez39@gmail.com');
INSERT INTO personas VALUES(40, 'Andres Gomez', 'andres.gomez40@gmail.com');