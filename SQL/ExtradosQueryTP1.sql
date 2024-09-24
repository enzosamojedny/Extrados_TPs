--1
select * from locaciones where ID_PAIS LIKE'%US%'

--2
select ID_DEPARTAMENTO,NOMBRE,DIRECCION,CIUDAD,ID_PAIS from departamentos 
INNER JOIN locaciones
ON locaciones.ID_LOCACION = departamentos.ID_LOCACION
WHERE ID_PAIS LIKE'%US%';

--3
--elegi hacer este sin subquery porque
--me senté a programar y razonando, salió así
SELECT CONCAT (e.NOMBRE,e.APELLIDO)
AS 'Nombre_Completo',e.ID_EMPLEADO,e.ID_TRABAJO,e.ID_MANAGER, l.ESTADO_PROVINCIA,l.ID_PAIS
FROM empleados e
INNER JOIN departamentos d
ON e.ID_MANAGER = d.ID_MANAGER
INNER JOIN locaciones l
ON l.ID_LOCACION = d.ID_LOCACION
WHERE l.ID_PAIS LIKE'%US%'
ORDER BY ID_MANAGER ASC;

--4
SELECT e.email AS 'Usuarios' FROM empleados e --todos los usuarios
WHERE e.ID_MANAGER IN -- que tengan un manager
(SELECT d.ID_MANAGER from departamentos d  -- unir a los departamentos con empleados por id
INNER JOIN locaciones l
ON d.ID_LOCACION = l.ID_LOCACION  --subquery con locaciones
AND l.ID_PAIS LIKE'%US%');


