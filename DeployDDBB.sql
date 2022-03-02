-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `client_pk` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NULL,
  `Cognoms` VARCHAR(45) NULL,
  `DNI` VARCHAR(45) NULL,
  `Mitja_pagament` VARCHAR(45) NULL,
  PRIMARY KEY (`client_pk`),
  UNIQUE INDEX `client_pk_UNIQUE` (`client_pk` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Establiment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Establiment` (
  `establiment_pk` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `localitzacio` VARCHAR(45) NULL,
  `superficie` VARCHAR(45) NULL,
  PRIMARY KEY (`establiment_pk`),
  INDEX `establiment_pk_UNIQUE` (`establiment_pk` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Treballador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Treballador` (
  `treballador_pk` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NULL,
  `Cognoms` VARCHAR(45) NULL,
  `establiment_fk` INT NULL,
  PRIMARY KEY (`treballador_pk`),
  UNIQUE INDEX `treballador_pk_UNIQUE` (`treballador_pk` ASC) VISIBLE,
  INDEX `establiment_fk_2_idx` (`establiment_fk` ASC) VISIBLE,
  CONSTRAINT `establiment_fk`
    FOREIGN KEY (`establiment_fk`)
    REFERENCES `mydb`.`Establiment` (`establiment_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Transaccio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Transaccio` (
  `client_fk` INT NOT NULL,
  `establiment_fk` INT NOT NULL,
  `treballador_fk` INT NOT NULL,
  `trans_pk` INT NOT NULL AUTO_INCREMENT,
  `total_trans` INT NULL,
  UNIQUE INDEX `Trans_pk_UNIQUE` (`client_fk` ASC, `establiment_fk` ASC, `treballador_fk` ASC) VISIBLE,
  INDEX `client_fk_idx` (`client_fk` ASC) VISIBLE,
  INDEX `establiment_fk_idx` (`establiment_fk` ASC) VISIBLE,
  INDEX `treballador_fk_idx` (`treballador_fk` ASC) VISIBLE,
  PRIMARY KEY (`trans_pk`),
  CONSTRAINT `client_fk`
    FOREIGN KEY (`client_fk`)
    REFERENCES `mydb`.`Client` (`client_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `establiment_fk_2`
    FOREIGN KEY (`establiment_fk`)
    REFERENCES `mydb`.`Establiment` (`establiment_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `treballador_fk`
    FOREIGN KEY (`treballador_fk`)
    REFERENCES `mydb`.`Treballador` (`treballador_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producte` (
  `product_pk` INT NOT NULL AUTO_INCREMENT,
  `tipus_fk` INT NULL,
  `descripcio` VARCHAR(45) NULL,
  `Preu` VARCHAR(45) NULL,
  PRIMARY KEY (`product_pk`),
  UNIQUE INDEX `product_pk_UNIQUE` (`product_pk` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Transaccio_Detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Transaccio_Detail` (
  `transdet_pk` INT NOT NULL AUTO_INCREMENT,
  `trans_fk` INT NOT NULL,
  `product_fk` INT NOT NULL,
  `Qty` INT NULL,
  `total_detail` VARCHAR(45) NULL,
  PRIMARY KEY (`transdet_pk`, `trans_fk`, `product_fk`),
  UNIQUE INDEX `transdet_pk_UNIQUE` (`transdet_pk` ASC) VISIBLE,
  INDEX `product_fk_idx` (`product_fk` ASC) VISIBLE,
  INDEX `trans_fk_idx` (`trans_fk` ASC) VISIBLE,
  CONSTRAINT `product_fk`
    FOREIGN KEY (`product_fk`)
    REFERENCES `mydb`.`Producte` (`product_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `trans_fk`
    FOREIGN KEY (`trans_fk`)
    REFERENCES `mydb`.`Transaccio` (`trans_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tipus_Producte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tipus_Producte` (
  `tipus_pk` INT NOT NULL AUTO_INCREMENT,
  `desc_tipus` VARCHAR(45) NULL,
  PRIMARY KEY (`tipus_pk`),
  UNIQUE INDEX `tipus_pk_UNIQUE` (`tipus_pk` ASC) VISIBLE,
  CONSTRAINT `tipus_fk`
    FOREIGN KEY (`tipus_pk`)
    REFERENCES `mydb`.`Producte` (`product_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
