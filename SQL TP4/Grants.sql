CREATE USER 'administrador'@'localhost' IDENTIFIED BY 'admin';
CREATE USER 'recepcionista'@'localhost' IDENTIFIED BY 'recep';

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