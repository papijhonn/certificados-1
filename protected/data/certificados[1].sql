SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `CERTIFICADOS` ;
CREATE SCHEMA IF NOT EXISTS `CERTIFICADOS` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `CERTIFICADOS` ;

-- -----------------------------------------------------
-- Table `CERTIFICADOS`.`PROVEEDOR`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `CERTIFICADOS`.`PROVEEDOR` (
  `PROVEEDOR_ID` VARCHAR(25) NOT NULL ,
  `LOTE_ID` VARCHAR(25) NOT NULL ,
  `ARTICULO_ID` VARCHAR(25) NOT NULL ,
  `CANTIDAD` INT NULL ,
  `NOMBRE_ARTICULO_ID` VARCHAR(25) NOT NULL ,
  `TIMESTAMP` DATETIME NULL ,
  PRIMARY KEY (`PROVEEDOR_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CERTIFICADOS`.`CLIENTE`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `CERTIFICADOS`.`CLIENTE` (
  `CLIENTE_ID` VARCHAR(25) NOT NULL ,
  `RAZON_SOCIAL` VARCHAR(25) NOT NULL ,
  `DIRECCION_FACTURACION` VARCHAR(25) NOT NULL ,
  `SUCURSAL` VARCHAR(25) NOT NULL ,
  `GIRO` VARCHAR(25) NOT NULL ,
  `FONO` INT NOT NULL ,
  `MAIL` VARCHAR(25) NOT NULL ,
  `NOMBRE_CONTACTO` VARCHAR(25) NOT NULL ,
  `TIMESTAMP` DATETIME NOT NULL ,
  PRIMARY KEY (`CLIENTE_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CERTIFICADOS`.`USUARIO`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `CERTIFICADOS`.`USUARIO` (
  `USUARIO_ID` INT NOT NULL ,
  `NOMBRE_COMPLETO` VARCHAR(25) NOT NULL ,
  `PERFIL` VARCHAR(25) NOT NULL ,
  `USUARIO` VARCHAR(25) NOT NULL ,
  `PASS` VARCHAR(25) NOT NULL ,
  `CORREO` VARCHAR(25) NOT NULL ,
  `FONO` INT NOT NULL ,
  `TIMESTAMP` DATETIME NOT NULL ,
  `FACTURACION_NUMERO_FACTURA_ID` INT NOT NULL ,
  PRIMARY KEY (`USUARIO_ID`) ,
  CONSTRAINT `fk_USUARIO_FACTURACION1`
    FOREIGN KEY (`FACTURACION_NUMERO_FACTURA_ID` )
    REFERENCES `CERTIFICADOS`.`FACTURACION` (`NUMERO_FACTURA_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_USUARIO_FACTURACION1_idx` ON `CERTIFICADOS`.`USUARIO` (`FACTURACION_NUMERO_FACTURA_ID` ASC) ;


-- -----------------------------------------------------
-- Table `CERTIFICADOS`.`CERTIFICADO`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `CERTIFICADOS`.`CERTIFICADO` (
  `CERTIFICADO_ID` INT NOT NULL ,
  `ARTICULO_ID` VARCHAR(25) NOT NULL ,
  `TIPO_ARTICULO_ID` VARCHAR(25) NOT NULL ,
  `CLIENTE_ID` VARCHAR(25) NOT NULL ,
  `USUARIO_ID` VARCHAR(25) NOT NULL ,
  `TIMESTAMP` DATETIME NOT NULL ,
  `CLIENTE_CLIENTE_ID` VARCHAR(25) NOT NULL ,
  `PROVEEDOR_PROVEEDOR_ID` VARCHAR(25) NOT NULL ,
  `USUARIO_USUARIO_ID` INT NOT NULL ,
  PRIMARY KEY (`CERTIFICADO_ID`) ,
  CONSTRAINT `fk_CERTIFICADO_CLIENTE1`
    FOREIGN KEY (`CLIENTE_CLIENTE_ID` )
    REFERENCES `CERTIFICADOS`.`CLIENTE` (`CLIENTE_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CERTIFICADO_PROVEEDOR1`
    FOREIGN KEY (`PROVEEDOR_PROVEEDOR_ID` )
    REFERENCES `CERTIFICADOS`.`PROVEEDOR` (`PROVEEDOR_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CERTIFICADO_USUARIO1`
    FOREIGN KEY (`USUARIO_USUARIO_ID` )
    REFERENCES `CERTIFICADOS`.`USUARIO` (`USUARIO_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_CERTIFICADO_CLIENTE1_idx` ON `CERTIFICADOS`.`CERTIFICADO` (`CLIENTE_CLIENTE_ID` ASC) ;

CREATE INDEX `fk_CERTIFICADO_PROVEEDOR1_idx` ON `CERTIFICADOS`.`CERTIFICADO` (`PROVEEDOR_PROVEEDOR_ID` ASC) ;

CREATE INDEX `fk_CERTIFICADO_USUARIO1_idx` ON `CERTIFICADOS`.`CERTIFICADO` (`USUARIO_USUARIO_ID` ASC) ;


-- -----------------------------------------------------
-- Table `CERTIFICADOS`.`FACTURACION`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `CERTIFICADOS`.`FACTURACION` (
  `NUMERO_FACTURA_ID` INT NOT NULL ,
  `NOMBRE_ARTICULO_ID` VARCHAR(25) NOT NULL ,
  `TIPO_ARTICULO` VARCHAR(25) NOT NULL ,
  `MEDIDA_ID` VARCHAR(25) NOT NULL ,
  `CLIENTE_ID` VARCHAR(25) NOT NULL ,
  `TIMESTAMP` DATETIME NOT NULL ,
  `CERTIFICADO_CERTIFICADO_ID` INT NOT NULL ,
  `CLIENTE_CLIENTE_ID` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`NUMERO_FACTURA_ID`) ,
  CONSTRAINT `fk_FACTURACION_CERTIFICADO1`
    FOREIGN KEY (`CERTIFICADO_CERTIFICADO_ID` )
    REFERENCES `CERTIFICADOS`.`CERTIFICADO` (`CERTIFICADO_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTURACION_CLIENTE1`
    FOREIGN KEY (`CLIENTE_CLIENTE_ID` )
    REFERENCES `CERTIFICADOS`.`CLIENTE` (`CLIENTE_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_FACTURACION_CERTIFICADO1_idx` ON `CERTIFICADOS`.`FACTURACION` (`CERTIFICADO_CERTIFICADO_ID` ASC) ;

CREATE INDEX `fk_FACTURACION_CLIENTE1_idx` ON `CERTIFICADOS`.`FACTURACION` (`CLIENTE_CLIENTE_ID` ASC) ;


-- -----------------------------------------------------
-- Table `CERTIFICADOS`.`TIPO_ARTICULO`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `CERTIFICADOS`.`TIPO_ARTICULO` (
  `TIPO_ARTICULO_ID` INT NOT NULL ,
  `RECUBRIMIENTO` VARCHAR(25) NOT NULL ,
  `MEDIDA_ID` VARCHAR(5) NOT NULL ,
  `TIMESTAMP` DATETIME NOT NULL ,
  `FACTURACION_NUMERO_FACTURA_ID` INT NOT NULL ,
  PRIMARY KEY (`TIPO_ARTICULO_ID`) ,
  CONSTRAINT `fk_TIPO_ARTICULO_FACTURACION1`
    FOREIGN KEY (`FACTURACION_NUMERO_FACTURA_ID` )
    REFERENCES `CERTIFICADOS`.`FACTURACION` (`NUMERO_FACTURA_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_TIPO_ARTICULO_FACTURACION1_idx` ON `CERTIFICADOS`.`TIPO_ARTICULO` (`FACTURACION_NUMERO_FACTURA_ID` ASC) ;


-- -----------------------------------------------------
-- Table `CERTIFICADOS`.`ARTICULO`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `CERTIFICADOS`.`ARTICULO` (
  `ARTICULO_ID` VARCHAR(25) NOT NULL ,
  `NOMBRE_ARTICULO_ID` VARCHAR(25) NOT NULL ,
  `USUARIO_ID` VARCHAR(25) NOT NULL ,
  `PROVEEDOR_ID` VARCHAR(25) NOT NULL ,
  `TIMESTAMP` DATETIME NOT NULL ,
  `PROVEEDOR_PROVEEDOR_ID` VARCHAR(25) NOT NULL ,
  `TIPO_ARTICULO_TIPO_ARTICULO_ID` INT NOT NULL ,
  `FACTURACION_NUMERO_FACTURA_ID` INT NOT NULL ,
  `ARTICULOcol` VARCHAR(45) NULL ,
  `ARTICULOcol1` VARCHAR(45) NULL ,
  PRIMARY KEY (`ARTICULO_ID`) ,
  CONSTRAINT `fk_ARTICULO_PROVEEDOR`
    FOREIGN KEY (`PROVEEDOR_PROVEEDOR_ID` )
    REFERENCES `CERTIFICADOS`.`PROVEEDOR` (`PROVEEDOR_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ARTICULO_TIPO_ARTICULO1`
    FOREIGN KEY (`TIPO_ARTICULO_TIPO_ARTICULO_ID` )
    REFERENCES `CERTIFICADOS`.`TIPO_ARTICULO` (`TIPO_ARTICULO_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ARTICULO_FACTURACION1`
    FOREIGN KEY (`FACTURACION_NUMERO_FACTURA_ID` )
    REFERENCES `CERTIFICADOS`.`FACTURACION` (`NUMERO_FACTURA_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_ARTICULO_PROVEEDOR_idx` ON `CERTIFICADOS`.`ARTICULO` (`PROVEEDOR_PROVEEDOR_ID` ASC) ;

CREATE INDEX `fk_ARTICULO_TIPO_ARTICULO1_idx` ON `CERTIFICADOS`.`ARTICULO` (`TIPO_ARTICULO_TIPO_ARTICULO_ID` ASC) ;

CREATE INDEX `fk_ARTICULO_FACTURACION1_idx` ON `CERTIFICADOS`.`ARTICULO` (`FACTURACION_NUMERO_FACTURA_ID` ASC) ;


-- -----------------------------------------------------
-- Table `CERTIFICADOS`.`MEDIDA`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `CERTIFICADOS`.`MEDIDA` (
  `MEDIDA_ID` INT NOT NULL ,
  `DIAMETRO` VARCHAR(25) NOT NULL ,
  `LARGO` VARCHAR(25) NOT NULL ,
  `ALTURA` VARCHAR(5) NOT NULL ,
  `ENTRE_CARAS` VARCHAR(5) NOT NULL ,
  `NUMERO_DE_HILOS` VARCHAR(5) NOT NULL ,
  `TIPO_HILO` VARCHAR(5) NOT NULL ,
  `TIPO_ARTICULO_TIPO_ARTICULO_ID` INT NOT NULL ,
  `FACTURACION_NUMERO_FACTURA_ID` INT NOT NULL ,
  PRIMARY KEY (`MEDIDA_ID`) ,
  CONSTRAINT `fk_MEDIDA_TIPO_ARTICULO1`
    FOREIGN KEY (`TIPO_ARTICULO_TIPO_ARTICULO_ID` )
    REFERENCES `CERTIFICADOS`.`TIPO_ARTICULO` (`TIPO_ARTICULO_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MEDIDA_FACTURACION1`
    FOREIGN KEY (`FACTURACION_NUMERO_FACTURA_ID` )
    REFERENCES `CERTIFICADOS`.`FACTURACION` (`NUMERO_FACTURA_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_MEDIDA_TIPO_ARTICULO1_idx` ON `CERTIFICADOS`.`MEDIDA` (`TIPO_ARTICULO_TIPO_ARTICULO_ID` ASC) ;

CREATE INDEX `fk_MEDIDA_FACTURACION1_idx` ON `CERTIFICADOS`.`MEDIDA` (`FACTURACION_NUMERO_FACTURA_ID` ASC) ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
DROP SCHEMA IF EXISTS `CERTIFICADOS`
DROP SCHEMA IF EXISTS `CERTIFICADOS`