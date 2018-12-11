-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema SAE_DB
-- -----------------------------------------------------
-- Base de Datos para el Sistema de Administración de Espectaculares SAE
DROP SCHEMA IF EXISTS `SAE_DB` ;

-- -----------------------------------------------------
-- Schema SAE_DB
--
-- Base de Datos para el Sistema de Administración de Espectaculares SAE
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SAE_DB` DEFAULT CHARACTER SET big5 ;
USE `SAE_DB` ;

-- -----------------------------------------------------
-- Table `SAE_DB`.`CatNivelImpacto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`CatNivelImpacto` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`CatNivelImpacto` (
  `CatNivelImpactoId` INT NOT NULL,
  `CatNivelImpactoDesc` VARCHAR(45) NOT NULL,
  `CatNivelImpactoStatus` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`CatNivelImpactoId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`CatPerfil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`CatPerfil` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`CatPerfil` (
  `CatPerfilId` INT NOT NULL,
  `CatPerfilDesc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CatPerfilId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`CatCliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`CatCliente` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`CatCliente` (
  `CatClienteId` INT NOT NULL,
  `CatClienteNombres` VARCHAR(45) NOT NULL,
  `CatClienteApPat` VARCHAR(45) NOT NULL,
  `CatClienteApMAt` VARCHAR(45) NULL,
  `CatClienteCE` VARCHAR(45) NULL,
  `CatClienteTel` VARCHAR(45) NULL,
  PRIMARY KEY (`CatClienteId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`Tblventa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`Tblventa` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`Tblventa` (
  `TblventaId` INT NOT NULL,
  `TblventaFecha` DATE NULL,
  `TblventaCantidad` INT NULL,
  `CatCliente_CatClienteId` INT NOT NULL,
  PRIMARY KEY (`TblventaId`, `CatCliente_CatClienteId`),
  INDEX `fk_Tblventa_CatCliente1_idx` (`CatCliente_CatClienteId` ASC),
  CONSTRAINT `fk_Tblventa_CatCliente1`
    FOREIGN KEY (`CatCliente_CatClienteId`)
    REFERENCES `SAE_DB`.`CatCliente` (`CatClienteId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`TblUsuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`TblUsuario` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`TblUsuario` (
  `TblUsuarioCURP` VARCHAR(18) NOT NULL,
  `TblUsuarioNombres` VARCHAR(45) NOT NULL,
  `TblUsuarioApPat` VARCHAR(45) NOT NULL,
  `TblUsuarioApMat` VARCHAR(45) NULL,
  `TblUsuarioFNac` DATE NOT NULL,
  `TblUsuarioCE` VARCHAR(45) NOT NULL,
  `TblUsuarioName` VARCHAR(45) NOT NULL,
  `TblUsuarioPass` VARCHAR(128) NOT NULL,
  `TblUsuarioStatus` TINYINT(1) NULL DEFAULT 1,
  `CatPerfil_CatPerfilId` INT NOT NULL,
  `Tblventa_TblventaId` INT NOT NULL,
  `Tblventa_CatCliente_CatClienteId` INT NOT NULL,
  PRIMARY KEY (`TblUsuarioCURP`, `CatPerfil_CatPerfilId`, `Tblventa_TblventaId`, `Tblventa_CatCliente_CatClienteId`),
  INDEX `fk_TblUsuario_CatPerfil1_idx` (`CatPerfil_CatPerfilId` ASC),
  INDEX `fk_TblUsuario_Tblventa1_idx` (`Tblventa_TblventaId` ASC, `Tblventa_CatCliente_CatClienteId` ASC),
  CONSTRAINT `fk_TblUsuario_CatPerfil1`
    FOREIGN KEY (`CatPerfil_CatPerfilId`)
    REFERENCES `SAE_DB`.`CatPerfil` (`CatPerfilId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TblUsuario_Tblventa1`
    FOREIGN KEY (`Tblventa_TblventaId` , `Tblventa_CatCliente_CatClienteId`)
    REFERENCES `SAE_DB`.`Tblventa` (`TblventaId` , `CatCliente_CatClienteId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`CatAseguradora`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`CatAseguradora` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`CatAseguradora` (
  `CatAseguradoraId` INT NOT NULL,
  `CatAseguradoraDesc` VARCHAR(45) NOT NULL,
  `CatAseguradoraTelefono` VARCHAR(15) NOT NULL,
  `CatAseguradoraDireccion` VARCHAR(45) NULL,
  `CatAseguradoraContacto` VARCHAR(45) NULL,
  `CatAseguradoraStatus` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`CatAseguradoraId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`CatZona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`CatZona` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`CatZona` (
  `CatZonaId` INT NOT NULL,
  `CatZonaDesc` VARCHAR(45) NOT NULL,
  `CatZonaStatus` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`CatZonaId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`CatTipoEsp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`CatTipoEsp` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`CatTipoEsp` (
  `CatTipoEspId` INT NOT NULL,
  `CatTipoEspDesc` VARCHAR(45) NOT NULL,
  `CatTipoEspStatus` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`CatTipoEspId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`TblEspectacular`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`TblEspectacular` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`TblEspectacular` (
  `TblEspectacularId` INT NOT NULL,
  `TblEspectacularDesc` VARCHAR(45) NOT NULL,
  `TblEspectacularAlto` FLOAT NOT NULL,
  `TblEspectacularAncho` FLOAT NULL,
  `TblEspectacularLat` VARCHAR(45) NULL,
  `TblEspectacularLong` VARCHAR(45) NULL,
  `TblEspectacularCostMin` FLOAT NULL,
  `TblEspectacularImagen` BLOB NULL,
  `TblCatZona_CatZonaId` INT NOT NULL,
  `TblCatTipoEsp_CatTipoEspId` INT NOT NULL,
  `TblCatNivelImpacto_CatNivelImpactoId` INT NOT NULL,
  `TblEspectacularStatus` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`TblEspectacularId`, `TblCatZona_CatZonaId`, `TblCatTipoEsp_CatTipoEspId`, `TblCatNivelImpacto_CatNivelImpactoId`),
  INDEX `fk_Espectacular_CatZona_idx` (`TblCatZona_CatZonaId` ASC),
  INDEX `fk_Espectacular_CatTipoEsp1_idx` (`TblCatTipoEsp_CatTipoEspId` ASC),
  INDEX `fk_Espectacular_CatNivelImpacto1_idx` (`TblCatNivelImpacto_CatNivelImpactoId` ASC),
  CONSTRAINT `fk_Espectacular_CatZona`
    FOREIGN KEY (`TblCatZona_CatZonaId`)
    REFERENCES `SAE_DB`.`CatZona` (`CatZonaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Espectacular_CatTipoEsp1`
    FOREIGN KEY (`TblCatTipoEsp_CatTipoEspId`)
    REFERENCES `SAE_DB`.`CatTipoEsp` (`CatTipoEspId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Espectacular_CatNivelImpacto1`
    FOREIGN KEY (`TblCatNivelImpacto_CatNivelImpactoId`)
    REFERENCES `SAE_DB`.`CatNivelImpacto` (`CatNivelImpactoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`TblPermiso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`TblPermiso` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`TblPermiso` (
  `TblPermiso` INT NOT NULL,
  `TblPermisoDesc` VARCHAR(45) NOT NULL,
  `TblPermisocolVigencia` DATE NOT NULL,
  PRIMARY KEY (`TblPermiso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`RelEspPer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`RelEspPer` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`RelEspPer` (
  `RelEspPerId` INT NOT NULL,
  `TblEspectacular_TblEspectacularId` INT NOT NULL,
  `TblPermiso_TblPermiso` INT NOT NULL,
  PRIMARY KEY (`RelEspPerId`, `TblEspectacular_TblEspectacularId`, `TblPermiso_TblPermiso`),
  INDEX `fk_RelEspPer_TblEspectacular1_idx` (`TblEspectacular_TblEspectacularId` ASC),
  INDEX `fk_RelEspPer_TblPermiso1_idx` (`TblPermiso_TblPermiso` ASC),
  CONSTRAINT `fk_RelEspPer_TblEspectacular1`
    FOREIGN KEY (`TblEspectacular_TblEspectacularId`)
    REFERENCES `SAE_DB`.`TblEspectacular` (`TblEspectacularId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RelEspPer_TblPermiso1`
    FOREIGN KEY (`TblPermiso_TblPermiso`)
    REFERENCES `SAE_DB`.`TblPermiso` (`TblPermiso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`TblSeguro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`TblSeguro` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`TblSeguro` (
  `TblSeguroId` INT NOT NULL,
  `TblSeguroDesc` VARCHAR(45) NOT NULL,
  `TblSeguroVigencia` DATE NOT NULL,
  `TblSeguroCobertura` VARCHAR(45) NULL,
  `CatAseguradora_CatAseguradoraId` INT NOT NULL,
  PRIMARY KEY (`TblSeguroId`, `CatAseguradora_CatAseguradoraId`),
  INDEX `fk_TblSeguro_CatAseguradora1_idx` (`CatAseguradora_CatAseguradoraId` ASC),
  CONSTRAINT `fk_TblSeguro_CatAseguradora1`
    FOREIGN KEY (`CatAseguradora_CatAseguradoraId`)
    REFERENCES `SAE_DB`.`CatAseguradora` (`CatAseguradoraId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`RelEspSeg`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`RelEspSeg` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`RelEspSeg` (
  `RelEspSegId` INT NOT NULL,
  `TblEspectacular_TblEspectacularId` INT NOT NULL,
  `TblSeguro_TblSeguroId` INT NOT NULL,
  PRIMARY KEY (`RelEspSegId`, `TblEspectacular_TblEspectacularId`, `TblSeguro_TblSeguroId`),
  INDEX `fk_RelEspSeg_TblEspectacular1_idx` (`TblEspectacular_TblEspectacularId` ASC),
  INDEX `fk_RelEspSeg_TblSeguro1_idx` (`TblSeguro_TblSeguroId` ASC),
  CONSTRAINT `fk_RelEspSeg_TblEspectacular1`
    FOREIGN KEY (`TblEspectacular_TblEspectacularId`)
    REFERENCES `SAE_DB`.`TblEspectacular` (`TblEspectacularId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RelEspSeg_TblSeguro1`
    FOREIGN KEY (`TblSeguro_TblSeguroId`)
    REFERENCES `SAE_DB`.`TblSeguro` (`TblSeguroId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`TblLog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`TblLog` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`TblLog` (
  `TblLog` INT NOT NULL,
  `TblLogFechaHora` DATETIME NOT NULL DEFAULT now(),
  `TblLogTabla` VARCHAR(45) NULL,
  `TblLogOperacion` VARCHAR(45) NULL,
  `TblLogCon` VARCHAR(180) NULL,
  `TblUsuario_TblUsuarioCURP` VARCHAR(18) NOT NULL,
  PRIMARY KEY (`TblLog`, `TblUsuario_TblUsuarioCURP`),
  INDEX `fk_TblLog_TblUsuario1_idx` (`TblUsuario_TblUsuarioCURP` ASC),
  CONSTRAINT `fk_TblLog_TblUsuario1`
    FOREIGN KEY (`TblUsuario_TblUsuarioCURP`)
    REFERENCES `SAE_DB`.`TblUsuario` (`TblUsuarioCURP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`TblManto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`TblManto` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`TblManto` (
  `TblMantoId` INT NOT NULL,
  `TblMantoFecha` DATE NULL,
  `TblMantoDesc` VARCHAR(45) NULL,
  PRIMARY KEY (`TblMantoId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`RelMantoEsp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`RelMantoEsp` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`RelMantoEsp` (
  `RelMantoEspId` INT NOT NULL,
  `TblEspectacular_TblEspectacularId` INT NOT NULL,
  `TblManto_TblMantoId` INT NOT NULL,
  PRIMARY KEY (`RelMantoEspId`, `TblEspectacular_TblEspectacularId`, `TblManto_TblMantoId`),
  INDEX `fk_RelMantoEsp_TblEspectacular1_idx` (`TblEspectacular_TblEspectacularId` ASC),
  INDEX `fk_RelMantoEsp_TblManto1_idx` (`TblManto_TblMantoId` ASC),
  CONSTRAINT `fk_RelMantoEsp_TblEspectacular1`
    FOREIGN KEY (`TblEspectacular_TblEspectacularId`)
    REFERENCES `SAE_DB`.`TblEspectacular` (`TblEspectacularId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RelMantoEsp_TblManto1`
    FOREIGN KEY (`TblManto_TblMantoId`)
    REFERENCES `SAE_DB`.`TblManto` (`TblMantoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`RelMantoUsr`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`RelMantoUsr` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`RelMantoUsr` (
  `RelMantoUsrId` INT NOT NULL,
  `TblManto_TblMantoId` INT NOT NULL,
  `TblUsuario_TblUsuarioCURP` VARCHAR(18) NOT NULL,
  `RelMantoUsrRoll` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`RelMantoUsrId`, `TblManto_TblMantoId`, `TblUsuario_TblUsuarioCURP`),
  INDEX `fk_RelMantoUsr_TblManto1_idx` (`TblManto_TblMantoId` ASC),
  INDEX `fk_RelMantoUsr_TblUsuario1_idx` (`TblUsuario_TblUsuarioCURP` ASC),
  CONSTRAINT `fk_RelMantoUsr_TblManto1`
    FOREIGN KEY (`TblManto_TblMantoId`)
    REFERENCES `SAE_DB`.`TblManto` (`TblMantoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RelMantoUsr_TblUsuario1`
    FOREIGN KEY (`TblUsuario_TblUsuarioCURP`)
    REFERENCES `SAE_DB`.`TblUsuario` (`TblUsuarioCURP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`TblClases`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`TblClases` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`TblClases` (
  `TblClasesId` INT NOT NULL,
  `TblClasesDesc` VARCHAR(45) NOT NULL,
  `TblClasesUrl` VARCHAR(45) NULL,
  PRIMARY KEY (`TblClasesId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`RelPerfilClases`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`RelPerfilClases` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`RelPerfilClases` (
  `RelPerfilClasesId` INT NOT NULL,
  `CatPerfil_CatPerfilId` INT NOT NULL,
  `TblClases_TblClasesId` INT NOT NULL,
  PRIMARY KEY (`RelPerfilClasesId`, `CatPerfil_CatPerfilId`, `TblClases_TblClasesId`),
  INDEX `fk_RelPerfilClases_CatPerfil1_idx` (`CatPerfil_CatPerfilId` ASC),
  INDEX `fk_RelPerfilClases_TblClases1_idx` (`TblClases_TblClasesId` ASC),
  CONSTRAINT `fk_RelPerfilClases_CatPerfil1`
    FOREIGN KEY (`CatPerfil_CatPerfilId`)
    REFERENCES `SAE_DB`.`CatPerfil` (`CatPerfilId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RelPerfilClases_TblClases1`
    FOREIGN KEY (`TblClases_TblClasesId`)
    REFERENCES `SAE_DB`.`TblClases` (`TblClasesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE_DB`.`RelEspVenta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SAE_DB`.`RelEspVenta` ;

CREATE TABLE IF NOT EXISTS `SAE_DB`.`RelEspVenta` (
  `RelEspVentaId` INT NOT NULL,
  `TblEspectacular_TblEspectacularId` INT NOT NULL,
  `Tblventa_TblventaId` INT NOT NULL,
  `Tblventa_CatCliente_CatClienteId` INT NOT NULL,
  PRIMARY KEY (`RelEspVentaId`, `TblEspectacular_TblEspectacularId`, `Tblventa_TblventaId`, `Tblventa_CatCliente_CatClienteId`),
  INDEX `fk_RelEspVenta_TblEspectacular1_idx` (`TblEspectacular_TblEspectacularId` ASC),
  INDEX `fk_RelEspVenta_Tblventa1_idx` (`Tblventa_TblventaId` ASC, `Tblventa_CatCliente_CatClienteId` ASC),
  CONSTRAINT `fk_RelEspVenta_TblEspectacular1`
    FOREIGN KEY (`TblEspectacular_TblEspectacularId`)
    REFERENCES `SAE_DB`.`TblEspectacular` (`TblEspectacularId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RelEspVenta_Tblventa1`
    FOREIGN KEY (`Tblventa_TblventaId` , `Tblventa_CatCliente_CatClienteId`)
    REFERENCES `SAE_DB`.`Tblventa` (`TblventaId` , `CatCliente_CatClienteId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
