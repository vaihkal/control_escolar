-- MySQL Script generated by MySQL Workbench
-- Sun Oct 14 18:43:26 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema control_escolar
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema control_escolar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `control_escolar` DEFAULT CHARACTER SET utf8 ;
USE `control_escolar` ;

-- -----------------------------------------------------
-- Table `control_escolar`.`Asignaturas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_escolar`.`Asignaturas` ;

CREATE TABLE IF NOT EXISTS `control_escolar`.`Asignaturas` (
  `IdAsignatura` BIGINT NOT NULL,
  `Codigo` NVARCHAR(10) NULL,
  `Nombre` NVARCHAR(50) NULL,
  `Descripcion` NVARCHAR(250) NULL,
  `FechaCreacion` DATETIME NULL,
  `Disponible` TINYINT NULL,
  UNIQUE INDEX `Codigo_UNIQUE` (`Codigo` ASC) VISIBLE,
  PRIMARY KEY (`IdAsignatura`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_escolar`.`Grados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_escolar`.`Grados` ;

CREATE TABLE IF NOT EXISTS `control_escolar`.`Grados` (
  `IdGrado` BIGINT NOT NULL,
  `Nombre` NVARCHAR(45) NULL,
  PRIMARY KEY (`IdGrado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_escolar`.`Docentes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_escolar`.`Docentes` ;

CREATE TABLE IF NOT EXISTS `control_escolar`.`Docentes` (
  `IdDocente` BIGINT NOT NULL,
  `FechaIngreso` DATETIME NULL,
  `Titulo` NVARCHAR(100) NULL,
  `Grados_IdGrado` BIGINT NOT NULL,
  PRIMARY KEY (`IdDocente`, `Grados_IdGrado`),
  INDEX `fk_Docentes_Grados_idx` (`Grados_IdGrado` ASC) VISIBLE,
  CONSTRAINT `fk_Docentes_Grados`
    FOREIGN KEY (`Grados_IdGrado`)
    REFERENCES `control_escolar`.`Grados` (`IdGrado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_escolar`.`Periodos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_escolar`.`Periodos` ;

CREATE TABLE IF NOT EXISTS `control_escolar`.`Periodos` (
  `IdPeriodo` BIGINT NOT NULL AUTO_INCREMENT,
  `Codigo` NVARCHAR(10) NULL,
  `Nombre` NVARCHAR(50) NULL,
  `Descripcion` NVARCHAR(250) NULL,
  PRIMARY KEY (`IdPeriodo`),
  UNIQUE INDEX `Codigo_UNIQUE` (`Codigo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_escolar`.`ProgramacionAcademica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_escolar`.`ProgramacionAcademica` ;

CREATE TABLE IF NOT EXISTS `control_escolar`.`ProgramacionAcademica` (
  `asignaturas_IdAsignatura` BIGINT NOT NULL,
  `Periodos_IdPeriodo` BIGINT NOT NULL,
  `Docentes_IdDocente` BIGINT NOT NULL,
  `Codigo` NVARCHAR(10) NOT NULL,
  `Master` TINYINT NULL,
  PRIMARY KEY (`asignaturas_IdAsignatura`, `Periodos_IdPeriodo`, `Docentes_IdDocente`),
  INDEX `fk_asignaturas_has_Periodos_Periodos1_idx` (`Periodos_IdPeriodo` ASC) VISIBLE,
  INDEX `fk_asignaturas_has_Periodos_asignaturas1_idx` (`asignaturas_IdAsignatura` ASC) VISIBLE,
  INDEX `fk_ProgramacionAcademica_Docentes1_idx` (`Docentes_IdDocente` ASC) VISIBLE,
  UNIQUE INDEX `AllUnique` (`asignaturas_IdAsignatura` ASC, `Periodos_IdPeriodo` ASC, `Docentes_IdDocente` ASC, `Codigo` ASC) VISIBLE,
  CONSTRAINT `fk_asignaturas_has_Periodos_asignaturas1`
    FOREIGN KEY (`asignaturas_IdAsignatura`)
    REFERENCES `control_escolar`.`Asignaturas` (`IdAsignatura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asignaturas_has_Periodos_Periodos1`
    FOREIGN KEY (`Periodos_IdPeriodo`)
    REFERENCES `control_escolar`.`Periodos` (`IdPeriodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProgramacionAcademica_Docentes1`
    FOREIGN KEY (`Docentes_IdDocente`)
    REFERENCES `control_escolar`.`Docentes` (`IdDocente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_escolar`.`Aulas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_escolar`.`Aulas` ;

CREATE TABLE IF NOT EXISTS `control_escolar`.`Aulas` (
  `IdAula` BIGINT NOT NULL,
  `Codigo` NVARCHAR(10) NULL,
  `Nombre` NVARCHAR(50) NULL,
  PRIMARY KEY (`IdAula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_escolar`.`Horarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_escolar`.`Horarios` ;

CREATE TABLE IF NOT EXISTS `control_escolar`.`Horarios` (
  `IdHorario` BIGINT NOT NULL AUTO_INCREMENT,
  `Dia` INT NOT NULL,
  `HoraInicio` TIME NOT NULL,
  `HoraFin` TIME NOT NULL,
  `Disponible` TINYINT NULL DEFAULT 0,
  `FechaCreacion` DATETIME NULL DEFAULT NOW(),
  `CodigoPA` NVARCHAR(10) NULL,
  `Aulas_IdAula` BIGINT NOT NULL,
  INDEX `FK_PA_idx` (`CodigoPA` ASC) VISIBLE,
  PRIMARY KEY (`IdHorario`),
  CONSTRAINT `FK_PA`
    FOREIGN KEY (`CodigoPA`)
    REFERENCES `control_escolar`.`ProgramacionAcademica` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Horarios_Aulas1`
    FOREIGN KEY (`Aulas_IdAula`)
    REFERENCES `control_escolar`.`Aulas` (`IdAula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_escolar`.`Alumnos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_escolar`.`Alumnos` ;

CREATE TABLE IF NOT EXISTS `control_escolar`.`Alumnos` (
  `IdAlumno` BIGINT NOT NULL,
  `Grupo` NVARCHAR(10) NULL,
  PRIMARY KEY (`IdAlumno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_escolar`.`MateriasInscritas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_escolar`.`MateriasInscritas` ;

CREATE TABLE IF NOT EXISTS `control_escolar`.`MateriasInscritas` (
  `IdMateriaInscrita` BIGINT NOT NULL,
  `Alumnos_IdAlumno` BIGINT NOT NULL,
  `CodigoPA` NVARCHAR(10) NULL,
  PRIMARY KEY (`IdMateriaInscrita`),
  INDEX `fk_Alumnos_has_ProgramacionAcademica_Alumnos1_idx` (`Alumnos_IdAlumno` ASC) VISIBLE,
  INDEX `FK_PA_idx` (`CodigoPA` ASC) VISIBLE,
  CONSTRAINT `fk_Alumnos_has_ProgramacionAcademica_Alumnos1`
    FOREIGN KEY (`Alumnos_IdAlumno`)
    REFERENCES `control_escolar`.`Alumnos` (`IdAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PA`
    FOREIGN KEY (`CodigoPA`)
    REFERENCES `control_escolar`.`ProgramacionAcademica` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_escolar`.`Asistencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_escolar`.`Asistencia` ;

CREATE TABLE IF NOT EXISTS `control_escolar`.`Asistencia` (
  `MateriasInscritas_IdMateriaInscrita` BIGINT NOT NULL,
  `Horarios_IdHorario` BIGINT NOT NULL,
  `Fecha` DATE NOT NULL,
  `Asistencia` TINYINT NULL DEFAULT 0,
  `Justificante` TINYINT NULL DEFAULT 0,
  `FechaCreacion` DATETIME NULL DEFAULT NOW(),
  PRIMARY KEY (`MateriasInscritas_IdMateriaInscrita`, `Horarios_IdHorario`, `Fecha`),
  INDEX `fk_MateriasInscritas_has_Horarios_Horarios3_idx` (`Horarios_IdHorario` ASC) VISIBLE,
  INDEX `fk_MateriasInscritas_has_Horarios_MateriasInscritas3_idx` (`MateriasInscritas_IdMateriaInscrita` ASC) VISIBLE,
  CONSTRAINT `fk_MateriasInscritas_has_Horarios_MateriasInscritas3`
    FOREIGN KEY (`MateriasInscritas_IdMateriaInscrita`)
    REFERENCES `control_escolar`.`MateriasInscritas` (`IdMateriaInscrita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MateriasInscritas_has_Horarios_Horarios3`
    FOREIGN KEY (`Horarios_IdHorario`)
    REFERENCES `control_escolar`.`Horarios` (`IdHorario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_escolar`.`Asistencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_escolar`.`Asistencia` ;

CREATE TABLE IF NOT EXISTS `control_escolar`.`Asistencia` (
  `MateriasInscritas_IdMateriaInscrita` BIGINT NOT NULL,
  `Horarios_IdHorario` BIGINT NOT NULL,
  `Fecha` DATE NOT NULL,
  `Asistencia` TINYINT NULL DEFAULT 0,
  `Justificante` TINYINT NULL DEFAULT 0,
  `FechaCreacion` DATETIME NULL DEFAULT NOW(),
  PRIMARY KEY (`MateriasInscritas_IdMateriaInscrita`, `Horarios_IdHorario`, `Fecha`),
  INDEX `fk_MateriasInscritas_has_Horarios_Horarios3_idx` (`Horarios_IdHorario` ASC) VISIBLE,
  INDEX `fk_MateriasInscritas_has_Horarios_MateriasInscritas3_idx` (`MateriasInscritas_IdMateriaInscrita` ASC) VISIBLE,
  CONSTRAINT `fk_MateriasInscritas_has_Horarios_MateriasInscritas3`
    FOREIGN KEY (`MateriasInscritas_IdMateriaInscrita`)
    REFERENCES `control_escolar`.`MateriasInscritas` (`IdMateriaInscrita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MateriasInscritas_has_Horarios_Horarios3`
    FOREIGN KEY (`Horarios_IdHorario`)
    REFERENCES `control_escolar`.`Horarios` (`IdHorario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_escolar`.`Asistencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_escolar`.`Asistencia` ;

CREATE TABLE IF NOT EXISTS `control_escolar`.`Asistencia` (
  `MateriasInscritas_IdMateriaInscrita` BIGINT NOT NULL,
  `Horarios_IdHorario` BIGINT NOT NULL,
  `Fecha` DATE NOT NULL,
  `Asistencia` TINYINT NULL DEFAULT 0,
  `Justificante` TINYINT NULL DEFAULT 0,
  `FechaCreacion` DATETIME NULL DEFAULT NOW(),
  PRIMARY KEY (`MateriasInscritas_IdMateriaInscrita`, `Horarios_IdHorario`, `Fecha`),
  INDEX `fk_MateriasInscritas_has_Horarios_Horarios3_idx` (`Horarios_IdHorario` ASC) VISIBLE,
  INDEX `fk_MateriasInscritas_has_Horarios_MateriasInscritas3_idx` (`MateriasInscritas_IdMateriaInscrita` ASC) VISIBLE,
  CONSTRAINT `fk_MateriasInscritas_has_Horarios_MateriasInscritas3`
    FOREIGN KEY (`MateriasInscritas_IdMateriaInscrita`)
    REFERENCES `control_escolar`.`MateriasInscritas` (`IdMateriaInscrita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MateriasInscritas_has_Horarios_Horarios3`
    FOREIGN KEY (`Horarios_IdHorario`)
    REFERENCES `control_escolar`.`Horarios` (`IdHorario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;