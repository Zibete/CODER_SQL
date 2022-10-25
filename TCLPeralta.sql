-- 1. Tabla tbl_horarios: eliminar algunos registros iniciando previamente una transacción. Utilizar rollback y commit y dejar comentados.

-- START TRANSACTION;

DELETE FROM tbl_horarios WHERE id_tbl_hor = 1;
DELETE FROM tbl_horarios WHERE id_tbl_hor = 2;

-- COMMIT;
-- ROLLBACK;

-- 2. Tabla tbl_novedades: insertar 8 registros iniciando una transacción. Agregar savepoint después del registro 4 y otro después del 8. Comentar eliminacióin del 1er savepoint

START TRANSACTION;

INSERT INTO tbl_novedades VALUES(null, 6, '4401', '2022-10-25', 'Exámen de biología');
INSERT INTO tbl_novedades VALUES(null, 1, '4500', '2022-10-02', '20 min');
INSERT INTO tbl_novedades VALUES(null, 1, '29601664', '2022-09-30', '5 min');
INSERT INTO tbl_novedades VALUES(null, 2, '29603025', '2022-10-03', 'Reposo 48hs');

SAVEPOINT lote1;

INSERT INTO tbl_novedades VALUES(null, 4, '4294', '2022-10-20', 'Cajero');
INSERT INTO tbl_novedades VALUES(null, 4, '4294', '2022-10-21', 'Cajero');
INSERT INTO tbl_novedades VALUES(null, 1, '4308', '2022-10-01', '45 min');
INSERT INTO tbl_novedades VALUES(null, 1, '4303', '2022-09-24', '10 min');

SAVEPOINT lote2;

-- RELEASE SAVEPOINT lote1;

COMMIT;




