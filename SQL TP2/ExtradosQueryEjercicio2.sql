DELIMITER //
CREATE PROCEDURE ObtenerSalario(IN valor_a_superar INT)
BEGIN
DECLARE monto_acumulado int DEFAULT 0; -- sumatoria de los salarios
DECLARE contador int DEFAULT 1; -- voy sumando el contador, aumentando el LIMIT dinamicamente, quizas
DECLARE current_salario INT; -- salario actual del row

WHILE monto_acumulado <  valor_a_superar DO -- condicion de corte del loop

	SELECT salario INTO current_salario
    FROM empleados
	ORDER BY salario ASC
    LIMIT contador, 1;-- trae el valor de la columna en la posicion actual
    
    SET monto_acumulado = monto_acumulado + current_salario;
    SET contador = contador + 1; 
    -- este _sp devuelve estos values
    SELECT monto_acumulado as total_acumulado, contador AS sueldos_necesarios; 
END WHILE;
END //
DELIMITER ;

CALL ObtenerSalario(100000);