-- Creación de usuario 1

CREATE USER xasr04@localhost IDENTIFIED BY 'admin1234';

-- Creación de usuario 2

CREATE USER xgas07@localhost IDENTIFIED BY 'admin1234';


-- Asignación a xgas07 permisos de solo lectura sobre todas las tablas

GRANT SELECT ON horarios.* TO xgas07@localhost;

-- Asignación a xasr04 permisos de lectura, inserción y modificación de datos a todas las tablas

GRANT SELECT, INSERT, UPDATE ON horarios.* TO xasr04@localhost;

