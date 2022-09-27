
-- 1. Vista que muestra cuantos cajeros hay que estén activos actualmente
SELECT * FROM tbl_personal 
WHERE puesto = 1 
AND id_estado = 1;

-- 2. Vista que muestra cuantos empleados ingresaron a la compañía en 2021
SELECT * FROM tbl_personal 
WHERE fecha_ingreso >= '2021-01-01' 
AND fecha_ingreso <= '2021-12-31';

-- 3. Vista que muestra solo las mujeres y las ordena por fecha de ingreso
SELECT * FROM tbl_personal 
WHERE genero = 2
ORDER BY fecha_ingreso;

-- 4. Vista que muestra los empleados que ya no trabajan más en la compañía
SELECT * FROM tbl_personal 
WHERE id_estado = 4;

-- 5. Vista que muestra los empleados activos que sean vendedores de playa y que hayan ingresado a la compañía hace más de dos años
SELECT * FROM tbl_personal 
WHERE id_estado = 1 
AND puesto = 3 
AND fecha_ingreso <= DATE_SUB(CURDATE(),INTERVAL 2 YEAR);

