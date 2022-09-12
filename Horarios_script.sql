
DROP DATABASE IF EXISTS `horarios`;

CREATE DATABASE `horarios`;
USE `horarios`;


CREATE TABLE `lst_estados` (
	`id_estado` tinyint unsigned unique auto_increment primary key,
	`estado` varchar(150) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE `lst_generos` (
	`id_genero` tinyint unsigned unique auto_increment primary key,
	`genero` varchar(150) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE `lst_puestos` (
	`id_puesto` tinyint unsigned unique auto_increment primary key,
	`puesto` varchar(150) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE `lst_novedades` (
	`id_novedad` tinyint unsigned unique auto_increment primary key,
	`novedad` varchar(150) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE `lst_turnos` (
	`id_turno` tinyint unsigned unique auto_increment primary key,
	`turno` varchar(150) NOT NULL
)ENGINE=InnoDB;



CREATE TABLE `tbl_personal` (
	`id_estado` tinyint unsigned unique NOT NULL,
	`legajo` mediumint NOT NULL UNIQUE PRIMARY KEY,
	`nombre` varchar(70) NOT NULL,
	`apellido` varchar(70) NOT NULL,
	`cuil` int DEFAULT NULL,
	`genero` tinyint unsigned unique NOT NULL,
	`puesto` tinyint unsigned unique NOT NULL,
	`fecha_ingreso` date DEFAULT NULL,
    CONSTRAINT fk_estado FOREIGN KEY (id_estado) REFERENCES lst_estados (id_estado),
	CONSTRAINT fk_genero FOREIGN KEY (genero) REFERENCES lst_generos (id_genero),
    CONSTRAINT fk_puesto FOREIGN KEY (puesto) REFERENCES lst_puestos (id_puesto)
)ENGINE=InnoDB;

CREATE TABLE `tbl_horarios` (
	`id_tbl_hor` serial,
    `id_turno` tinyint unsigned unique NOT NULL,
	`legajo` mediumint NOT NULL,
	`fecha` date NOT NULL,
	`detalle` varchar(150) DEFAULT NULL,
	CONSTRAINT fk_legajo_hor FOREIGN KEY (legajo) REFERENCES tbl_personal (legajo),
    CONSTRAINT fk_turno FOREIGN KEY (id_turno) REFERENCES lst_turnos (ID_turno)
    
)ENGINE=InnoDB;


CREATE TABLE `tbl_novedades` (
	`id_tbl_nov` serial,
	`id_novedad` tinyint unsigned unique NOT NULL,
	`legajo` mediumint NOT NULL,
	`fecha` date NOT NULL,
	`detalle` varchar(150) DEFAULT NULL,
	CONSTRAINT fk_legajo_nov FOREIGN KEY (legajo) REFERENCES tbl_personal (legajo),
    CONSTRAINT fk_novedad FOREIGN KEY (id_novedad) REFERENCES lst_novedades (ID_novedad)
    
)ENGINE=InnoDB;
