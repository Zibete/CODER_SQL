-- PRIMER STORED PROCEDURE: Ordenamiento de tabla pasando como parámetro la columna y si es ascendente o descendente
DELIMITER $$
CREATE PROCEDURE sp_listado_empleados_ordenado (IN p_order_column VARCHAR(100), IN p_order_type VARCHAR(4))
BEGIN
	-- Creamos la variable y le asignamos los valores como strings
	SET @ordenar = CONCAT(' ORDER BY ', p_order_column, ' ', p_order_type);
    SET @clausula = CONCAT('SELECT id_estado, legajo, nombre, apellido, puesto, fecha_ingreso FROM tbl_personal', @ordenar);
    -- Preparamos y ejecutamos
    PREPARE mi_clausula FROM @clausula;
    EXECUTE mi_clausula;
    -- Limpiamos la memoria
    DEALLOCATE PREPARE mi_clausula;
    
END$$
DELIMITER ;

-- SEGUNDO STORED PROCEDURE: Inserción de un nuevo empleado pasando como parámetro: Legajo, Nombre, Apellido, CUIL, Género (ID), Puesto (ID) y Fecha de ingreso
DELIMITER $$
CREATE PROCEDURE sp_insertar_nuevo_empleado (IN p_legajo INT, IN p_nombre VARCHAR(70), IN p_apellido VARCHAR(70), 
IN p_cuil VARCHAR(13), IN p_genero TINYINT, IN p_puesto TINYINT, IN p_fecha_ingreso DATE)
BEGIN

	DECLARE v_legajo INT;
	DECLARE v_nombre VARCHAR(70);

	-- Validamos si el número de legajo ya existe

	SELECT legajo
	INTO v_legajo
	FROM tbl_personal
	WHERE legajo = p_legajo;

	-- Si es nulo, entonces no existe en la base de datos:
	IF v_legajo <=> NULL THEN

		-- Validamos que no haya un empleado con el mismo nombre
		
		SELECT nombre
		INTO v_nombre
		FROM tbl_personal
		WHERE nombre = p_nombre;
		
		-- Si es nulo, entonces no existe en la base de datos:
		IF v_nombre <=> NULL THEN
			
			-- Verificamos que el cuil ingresado tenga 13 caracteres
			IF LENGTH(p_cuil) <> 13 THEN
				-- Mensaje de error
				SELECT 'El CUIL debe contener 13 caracteres (Utilice el formato XX-XXXXXXXX-X)' AS error_msg;
				
			ELSE
				-- Insertamos los datos en la tabla
				INSERT INTO tbl_personal (id_estado, legajo, nombre, apellido, cuil, genero, puesto, fecha_ingreso)
				VALUES 	(1, -- Por defecto está 'Activo'
						p_legajo, 
						p_nombre,
						p_apellido,
						p_cuil,
						p_genero,
						p_puesto,
						p_fecha_ingreso);
                        -- Mensaje de éxito
                        SELECT 'Nuevo empleado ingresado correctamente' AS msg;
			
			END IF;
		ELSE
			-- Mensaje de error
			SELECT 'Ya hay un empleado con ese nombre en la base de datos' AS error_msg;
		END IF;
	ELSE
		-- Mensaje de error
		SELECT 'Ya hay un empleado con ese legajo en la base de datos' AS error_msg;
	END IF;
END$$
DELIMITER ;





