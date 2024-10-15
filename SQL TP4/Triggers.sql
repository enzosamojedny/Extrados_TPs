DELIMITER //
CREATE TRIGGER auditoria_insert_recepcionistas
AFTER INSERT ON recepcionistas
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER, 'INSERT', 'recepcionistas', CONCAT('Se ha creado un nuevo recepcionista: ', NEW.nombre));
END; //
DELIMITER ;

DELIMITER //
CREATE TRIGGER auditoria_update_recepcionistas
AFTER UPDATE ON recepcionistas
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER, 'UPDATE', 'recepcionistas', CONCAT('Se ha actualizado el recepcionista: ', NEW.nombre));
END; //
DELIMITER ;

DELIMITER //
CREATE TRIGGER auditoria_delete_recepcionistas
BEFORE DELETE ON recepcionistas
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER, 'DELETE', 'recepcionistas', CONCAT('Se ha eliminado el recepcionista: ', OLD.nombre));
END; //
DELIMITER ;

DELIMITER //
CREATE TRIGGER auditoria_insert_cuartos
AFTER INSERT ON cuartos
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER, 'INSERT', 'cuartos', CONCAT('Se ha creado un nuevo cuarto: ', NEW.numero_cuarto));
END; //
DELIMITER ;

DELIMITER //
CREATE TRIGGER auditoria_update_cuartos
AFTER UPDATE ON cuartos
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER, 'UPDATE', 'cuartos', CONCAT('Se ha actualizado el cuarto: ', NEW.numero_cuarto));
END; //
DELIMITER ;

DELIMITER //
CREATE TRIGGER auditoria_delete_cuartos
BEFORE DELETE ON cuartos
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER, 'DELETE', 'cuartos', CONCAT('Se ha eliminado el cuarto: ', OLD.numero_cuarto));
END; //
DELIMITER ;

DELIMITER //
CREATE TRIGGER auditoria_insert_estacionamiento
AFTER INSERT ON estacionamiento
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER(), 'INSERT', 'estacionamiento', CONCAT('Se ha creado un nuevo lote de estacionamiento: ', NEW.numero_lote));
END; //

CREATE TRIGGER auditoria_update_estacionamiento
AFTER UPDATE ON estacionamiento
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER(), 'UPDATE', 'estacionamiento', CONCAT('Se ha actualizado el lote de estacionamiento: ', NEW.numero_lote));
END; //

CREATE TRIGGER auditoria_delete_estacionamiento
BEFORE DELETE ON estacionamiento
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER(), 'DELETE', 'estacionamiento', CONCAT('Se ha eliminado el lote de estacionamiento: ', OLD.numero_lote));
END; //


CREATE TRIGGER auditoria_insert_clientes
AFTER INSERT ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (NEW.id_creador, 'INSERT', 'clientes', CONCAT('Se ha registrado un nuevo cliente: ', NEW.DNI));
END; //

CREATE TRIGGER auditoria_update_clientes
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER(), 'UPDATE', 'clientes', CONCAT('Se ha actualizado la información del cliente: ', NEW.DNI));
END; //

CREATE TRIGGER auditoria_delete_clientes
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER(), 'DELETE', 'clientes', CONCAT('Se ha eliminado el cliente: ', OLD.DNI));
END; //

CREATE TRIGGER auditoria_insert_registros_estadia
AFTER INSERT ON registros_estadia
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER(), 'INSERT', 'registros_estadia', CONCAT('Se ha registrado una nueva estadía para el cliente: ', NEW.DNI_cliente));
END; //

CREATE TRIGGER auditoria_update_registros_estadia
AFTER UPDATE ON registros_estadia
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER(), 'UPDATE', 'registros_estadia', CONCAT('Se ha actualizado el registro de estadía del cliente: ', NEW.DNI_cliente));
END; //

CREATE TRIGGER auditoria_delete_registros_estadia
BEFORE DELETE ON registros_estadia
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER(), 'DELETE', 'registros_estadia', CONCAT('Se ha eliminado el registro de estadía del cliente: ', OLD.DNI_cliente));
END; //

CREATE TRIGGER auditoria_insert_registros_limpieza
AFTER INSERT ON registros_limpieza
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (NEW.id_recepcionista, 'INSERT', 'registros_limpieza', CONCAT('Se ha registrado una nueva limpieza para el cuarto: ', NEW.numero_cuarto));
END; //

CREATE TRIGGER auditoria_update_registros_limpieza
AFTER UPDATE ON registros_limpieza
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER(), 'UPDATE', 'registros_limpieza', CONCAT('Se ha actualizado el registro de limpieza del cuarto: ', NEW.numero_cuarto));
END; //

CREATE TRIGGER auditoria_delete_registros_limpieza
BEFORE DELETE ON registros_limpieza
FOR EACH ROW
BEGIN
    INSERT INTO logs_auditoria (id_usuario, accion, tabla_afectada, mensaje)
    VALUES (CURRENT_USER(), 'DELETE', 'registros_limpieza', CONCAT('Se ha eliminado el registro de limpieza del cuarto: ', OLD.numero_cuarto));
END; //
DELIMITER ;