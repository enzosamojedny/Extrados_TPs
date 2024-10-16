-- REGISTRO DE ADMINISTRADORES
INSERT INTO administradores (DNI, nombre, nombre_usuario, contraseña,  fecha_baja)
VALUES ('43.123.432', 'Juan Pérez', 'juan.perez', 'contraseñaSegura123', NULL);
INSERT INTO administradores (DNI, nombre, nombre_usuario, contraseña, fecha_baja)
VALUES ('21.563.213', 'Ana García', 'ana.garcia', 'otraContraseñaSegura456', NULL);

-- REGISTRO DE RECEPCIONISTAS
INSERT INTO recepcionistas (DNI, nombre, nombre_usuario, contraseña, id_creador)
VALUES ('33.456.789', 'Carlos López', 'carlos.lopez', 'miClaveSegura789', '43.123.432');
INSERT INTO recepcionistas (DNI, nombre, nombre_usuario, contraseña, id_creador)
VALUES ('27.890.123', 'Laura Fernández', 'laura.fernandez', 'otraClaveSegura123', '21.563.213');

-- REGISTRO DE CUARTOS
INSERT INTO cuartos (numero_cuarto, disponible) VALUES (101, 1);
INSERT INTO cuartos (numero_cuarto, disponible) VALUES (102, 1);
INSERT INTO cuartos (numero_cuarto, disponible) VALUES (103, 1);
INSERT INTO cuartos (numero_cuarto, disponible) VALUES (104, 1);
INSERT INTO cuartos (numero_cuarto, disponible) VALUES (105, 1);

-- REGISTRO DE ESTACIONAMIENTO
INSERT INTO estacionamiento (numero_lote, disponible) VALUES (132, 1);
INSERT INTO estacionamiento (numero_lote, disponible) VALUES (245, 1);
INSERT INTO estacionamiento (numero_lote, disponible) VALUES (321, 1);
INSERT INTO estacionamiento (numero_lote, disponible) VALUES (423, 1);
INSERT INTO estacionamiento (numero_lote, disponible) VALUES (556, 1);

-- REGISTRO DE CLIENTES
INSERT INTO clientes (DNI, nombre, id_creador) VALUES ('12.345.678', 'Juan Pérez', '33.456.789');
INSERT INTO clientes (DNI, nombre, id_creador) VALUES ('98.765.432', 'Ana Martínez', '33.456.789');

INSERT INTO clientes (DNI, nombre, id_creador) VALUES ('87.654.321', 'Luis Gómez', '27.890.123');
INSERT INTO clientes (DNI, nombre, id_creador) VALUES ('65.432.109', 'Claudia Rodríguez', '27.890.123');
INSERT INTO clientes (DNI, nombre, id_creador) VALUES ('54.321.098', 'Miguel Ramírez', '27.890.123');

-- REGISTRO_ESTADIA
INSERT INTO registros_estadia (DNI_cliente, numero_cuarto, numero_lote_estacionamiento, fecha_hora_entrada, fecha_hora_salida)
VALUES ('12.345.678', 101, 132, '2024-10-10 14:00:00', '2024-10-15 12:00:00');
INSERT INTO registros_estadia (DNI_cliente, numero_cuarto, numero_lote_estacionamiento, fecha_hora_entrada, fecha_hora_salida)
VALUES ('98.765.432', 102, 245, '2024-10-11 15:00:00', '2024-10-16 11:00:00');
INSERT INTO registros_estadia (DNI_cliente, numero_cuarto, numero_lote_estacionamiento, fecha_hora_entrada, fecha_hora_salida)
VALUES ('87.654.321', 103, 321, '2024-10-12 16:00:00', NULL);
INSERT INTO registros_estadia (DNI_cliente, numero_cuarto, numero_lote_estacionamiento, fecha_hora_entrada, fecha_hora_salida)
VALUES ('65.432.109', 104, 423, '2024-10-13 17:00:00', '2024-10-15 10:00:00');
INSERT INTO registros_estadia (DNI_cliente, numero_cuarto, numero_lote_estacionamiento, fecha_hora_entrada, fecha_hora_salida)
VALUES ('54.321.098', 105, 556, '2024-10-14 18:00:00', '2024-10-17 09:00:00');

-- REGISTRO_LIMPIEZA
INSERT INTO registros_limpieza (registro_estadia_id, id_creador)
VALUES (1, '33.456.789');
INSERT INTO registros_limpieza (registro_estadia_id, id_creador)
VALUES (2, '33.456.789');
INSERT INTO registros_limpieza (registro_estadia_id, id_creador)
VALUES (3, '27.890.123');
INSERT INTO registros_limpieza (registro_estadia_id, id_creador)
VALUES (4, '27.890.123');
INSERT INTO registros_limpieza (registro_estadia_id, id_creador)
VALUES (5, '33.456.789');
