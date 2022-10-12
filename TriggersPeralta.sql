-- Creación de tabla de logs para registrar las modificaciones realizadas en tbl_horarios

CREATE TABLE logs_horarios (
	id_logs_horarios INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
	hora TIME NOT NULL,
	usuario VARCHAR(45) NOT NULL,
	detalle varchar(150) NOT NULL
    
)ENGINE=InnoDB;
    
-- Creación de tabla de logs para registrar las modificaciones realizadas en tbl_personal    
    
CREATE TABLE logs_personal (
	id_logs_personal INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
	hora TIME NOT NULL,
	usuario VARCHAR(45) NOT NULL,
    datos_viejos VARCHAR(350) NOT NULL,
    datos_nuevos VARCHAR(350) NOT NULL,
	detalle varchar(150) NOT NULL
    
)ENGINE=InnoDB;



-- TRIGGERS

-- 1. Después de instertar un nuevo horario se inserta un registro en la tabla de logs

DELIMITER $$
CREATE TRIGGER logs_insert_horario
AFTER INSERT ON tbl_horarios
FOR EACH ROW 
BEGIN

	INSERT INTO logs_horarios VALUES(NULL, CURDATE(), CURTIME(), USER(), CONCAT('Asignó el turno ', NEW.id_turno, ' a ', NEW.legajo));

END$$

DELIMITER ;

-- 2. Antes de eliminar un horario se inserga un registro en la tabla de logs con los anteriores datos

DELIMITER $$
CREATE TRIGGER logs_delete_horario
BEFORE DELETE ON tbl_horarios
FOR EACH ROW 
BEGIN

	INSERT INTO logs_horarios VALUES(NULL, CURDATE(), CURTIME(), USER(), CONCAT('Eliminó el turno ', OLD.id_turno, ' a ', OLD.legajo));

END$$

DELIMITER ;

-- 3. Antes de actualizar los datos de un empleado se inserta un registro en la tabla de logs con los anteriores datos

DELIMITER $$
CREATE TRIGGER logs_update_empleado
BEFORE UPDATE ON tbl_personal
FOR EACH ROW 
BEGIN

	INSERT INTO logs_personal VALUES(NULL, CURDATE(), CURTIME(), USER(), 
    CONCAT('Estado: ',OLD.id_estado, '. Legajo: ', OLD.legajo, '. Nombre: ', OLD.nombre, '. Apellido: ', OLD.apellido,
    '. CUIL: ', OLD.cuil, '. Género: ', OLD.genero, '. Puesto: ', OLD.puesto, '. Fecha de ingreso: ', OLD.fecha_ingreso),
    CONCAT('Estado: ',NEW.id_estado, '. Legajo: ', NEW.legajo, '. Nombre: ', NEW.nombre, '. Apellido: ', NEW.apellido,
    '. CUIL: ', NEW.cuil, '. Género: ', NEW.genero, '. Puesto: ', NEW.puesto, '. Fecha de ingreso: ', NEW.fecha_ingreso),
    CONCAT('Actualizó los datos del registro ', OLD.id_personal));

END$$

DELIMITER ;

-- 4. Después de insertar un nuevo empleado se inserta un registro en la tabla logs con los datos ingresados


DELIMITER $$
CREATE TRIGGER logs_insert_empleado
BEFORE INSERT ON tbl_personal
FOR EACH ROW 
BEGIN

	INSERT INTO logs_personal VALUES(NULL, CURDATE(), CURTIME(), USER(), 
    '',
    CONCAT('Estado: ',NEW.id_estado, '. Legajo: ', NEW.legajo, '. Nombre: ', NEW.nombre, '. Apellido: ', NEW.apellido,
    '. CUIL: ', NEW.cuil, '. Género: ', NEW.genero, '. Puesto: ', NEW.puesto, '. Fecha de ingreso: ', NEW.fecha_ingreso),
    CONCAT('Agregó un nuevo empleado bajo el registro ', NEW.id_personal));

END$$

DELIMITER ;