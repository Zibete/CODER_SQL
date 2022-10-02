-- Obtener el turno pasando como parámetros día y legajo de empleado
DELIMITER $$
CREATE FUNCTION ver_turno (fecha DATE, legajo INT) RETURNS VARCHAR(3) 
READS SQL DATA
BEGIN
	
    DECLARE horario_int INT;
    DECLARE horario_txt VARCHAR(3);
    
    SELECT id_turno 
    INTO horario_int
    FROM tbl_horarios
    WHERE tbl_horarios.legajo = legajo 
    AND tbl_horarios.fecha = fecha;
    
    SELECT turno
    INTO horario_txt
    FROM lst_turnos
    WHERE lst_turnos.id_turno = horario_int;
    
	RETURN horario_txt;

END$$
DELIMITER ;

-- Obtener la antiguedad en años de un empleado pasando el legajo como parámetro 
DELIMITER $$
CREATE FUNCTION ver_antiguedad (legajo INT) RETURNS INT 
READS SQL DATA
BEGIN
	
    DECLARE fecha_ingreso DATE;
    DECLARE antiguedad INT;
    
    SELECT tbl_personal.fecha_ingreso
    INTO fecha_ingreso
    FROM tbl_personal
    WHERE tbl_personal.legajo = legajo;
    
    SET antiguedad = TIMESTAMPDIFF(YEAR,fecha_ingreso,CURDATE());
    
	RETURN antiguedad;

END$$
DELIMITER ;


