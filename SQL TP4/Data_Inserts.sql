-- REGISTRO DE ADMINISTRADORES
INSERT INTO administradores (DNI, nombre, nombre_usuario, contrase�a,  fecha_baja)
VALUES ('43.123.432', 'Juan P�rez', 'juan.perez', 'contrase�aSegura123', NULL);
INSERT INTO administradores (DNI, nombre, nombre_usuario, contrase�a, fecha_baja)
VALUES ('21.563.213', 'Ana Garc�a', 'ana.garcia', 'otraContrase�aSegura456', NULL);

-- REGISTRO DE RECEPCIONISTAS
INSERT INTO recepcionistas (DNI, nombre, nombre_usuario, contrase�a, id_creador)
VALUES ('23.432.123', 'Carlos L�pez', 'carlos.lopez', 'password123', '21.563.213');
INSERT INTO recepcionistas (DNI, nombre, nombre_usuario, contrase�a, id_creador)
VALUES ('56.453.213', 'Mar�a Fern�ndez', 'maria.fernandez', 'securePass456', '43.123.432');
INSERT INTO recepcionistas (DNI, nombre, nombre_usuario, contrase�a, id_creador)
VALUES ('13.632.113', 'Jose Passerini', 'jose.passerini', 'password123', '21.563.213');

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
INSERT INTO clientes (DNI, nombre, id_creador) VALUES ('12.345.678', 'Juan P�rez', '23.432.123');
INSERT INTO clientes (DNI, nombre, id_creador) VALUES ('98.765.432', 'Ana Mart�nez', '23.432.123');
INSERT INTO clientes (DNI, nombre, id_creador) VALUES ('87.654.321', 'Luis G�mez', '56.453.213');
INSERT INTO clientes (DNI, nombre, id_creador) VALUES ('65.432.109', 'Claudia Rodr�guez', '56.453.213');
INSERT INTO clientes (DNI, nombre, id_creador) VALUES ('54.321.098', 'Miguel Ram�rez', '56.453.213');

-- REGISTRO DE ESTADIA
-- registro de estad�a Juan P�rez en el cuarto 101 y el lote 132
INSERT INTO registros_estadia (DNI_cliente, numero_cuarto, numero_lote_estacionamiento, fecha_hora_entrada, fecha_hora_salida) VALUES ('12.345.678', 101, 132, '2024-10-12 14:00:00', '2024-10-13 11:00:00');
-- registro de estad�a Ana Mart�nez en el cuarto 102 y el lote 245
INSERT INTO registros_estadia (DNI_cliente, numero_cuarto, numero_lote_estacionamiento, fecha_hora_entrada, fecha_hora_salida) VALUES ('98.765.432', 102, 245, '2024-10-11 16:30:00', '2024-10-12 10:00:00');
-- registro de estad�a Luis G�mez en el cuarto 103 y el lote 321
INSERT INTO registros_estadia (DNI_cliente, numero_cuarto, numero_lote_estacionamiento, fecha_hora_entrada, fecha_hora_salida) VALUES ('87.654.321', 103, 321, '2024-10-13 15:00:00', '2024-10-14 09:30:00');
-- registro de estad�a Claudia Rodr�guez en el cuarto 104 sin uso de estacionamiento
INSERT INTO registros_estadia (DNI_cliente, numero_cuarto, numero_lote_estacionamiento, fecha_hora_entrada, fecha_hora_salida) VALUES ('65.432.109', 104, NULL, '2024-10-10 12:00:00', '2024-10-11 10:00:00');
-- registro de estad�a Miguel Ram�rez en el cuarto 105 y el lote 423
INSERT INTO registros_estadia (DNI_cliente, numero_cuarto, numero_lote_estacionamiento, fecha_hora_entrada, fecha_hora_salida) VALUES ('54.321.098', 105, 423, '2024-10-14 18:00:00', NULL);

-- REGISTRO DE LIMPIEZA
-- limpieza cuarto 101 supervisado por Carlos L�pez (DNI: '23.432.123')
INSERT INTO registros_limpieza (numero_cuarto, fecha_hora_inicio, fecha_hora_fin, id_recepcionista) VALUES (101, '2024-10-12 08:00:00', '2024-10-12 09:30:00', '23.432.123');
-- limpieza cuarto 102 supervisado por Mar�a Fern�ndez (DNI: '56.453.213')
INSERT INTO registros_limpieza (numero_cuarto, fecha_hora_inicio, fecha_hora_fin, id_recepcionista) VALUES (102, '2024-10-13 10:00:00', '2024-10-13 11:45:00', '56.453.213');
-- limpieza cuarto 103 supervisado por Carlos L�pez
INSERT INTO registros_limpieza (numero_cuarto, fecha_hora_inicio, fecha_hora_fin, id_recepcionista) VALUES (103, '2024-10-14 07:30:00', '2024-10-14 09:00:00', '23.432.123');
-- limpieza cuarto 104 supervisado por Mar�a Fern�ndez
INSERT INTO registros_limpieza (numero_cuarto, fecha_hora_inicio, fecha_hora_fin, id_recepcionista) VALUES (104, '2024-10-14 08:00:00', '2024-10-14 09:20:00', '56.453.213');
-- limpieza cuarto 105 supervisado por Carlos L�pez (limpieza en curso)
INSERT INTO registros_limpieza (numero_cuarto, fecha_hora_inicio, fecha_hora_fin, id_recepcionista) VALUES (105, '2024-10-14 09:00:00', NULL, '23.432.123');