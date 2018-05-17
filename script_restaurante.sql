SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `T1` ;
CREATE SCHEMA `T1` ;

GRANT ALL PRIVILEGES ON T1.* TO radames@localhost IDENTIFIED BY 'lageado' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON T1.* TO radames@'%' IDENTIFIED BY 'lageado' WITH GRANT OPTION;
FLUSH PRIVILEGES;

USE T1;


-- -----------------------------------------------------
-- Table `unidade_de_medida`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidade_de_medida` ;

CREATE  TABLE IF NOT EXISTS `unidade_de_medida` (
  `id_unidade_de_medida` VARCHAR(2) NOT NULL ,
  `nome_unidade_de_medida` VARCHAR(50) NULL ,
  PRIMARY KEY (`id_unidade_de_medida`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `produto` ;

CREATE  TABLE IF NOT EXISTS `produto` (
  `id_produto` INT NOT NULL AUTO_INCREMENT ,
  `nome_produto` VARCHAR(100) NULL DEFAULT NULL ,
  `unidade_de_medida_id_unidade_de_medida` VARCHAR(2) NOT NULL ,
  `quantidade_produto` DOUBLE NULL ,
  `preco_unitario_produto` DOUBLE NULL ,
  PRIMARY KEY (`id_produto`) ,
  INDEX `fk_produto_unidade_de_medida1` (`unidade_de_medida_id_unidade_de_medida` ASC) ,
  CONSTRAINT `fk_produto_unidade_de_medida1`
    FOREIGN KEY (`unidade_de_medida_id_unidade_de_medida` )
    REFERENCES `unidade_de_medida` (`id_unidade_de_medida` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4;


-- -----------------------------------------------------
-- Table `sub_produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sub_produto` ;

CREATE  TABLE IF NOT EXISTS `sub_produto` (
  `id_sub_produto` INT NOT NULL ,
  `nome_sub_produto` VARCHAR(45) NULL ,
  `unidade_de_medida_id_unidade_de_medida` VARCHAR(2) NOT NULL ,
  `quantidade_sub_produto` DOUBLE NULL ,
  `preco_sub_produto` DOUBLE NULL ,
  PRIMARY KEY (`id_sub_produto`) ,
  INDEX `fk_sub_produto_unidade_de_medida1` (`unidade_de_medida_id_unidade_de_medida` ASC) ,
  CONSTRAINT `fk_sub_produto_unidade_de_medida1`
    FOREIGN KEY (`unidade_de_medida_id_unidade_de_medida` )
    REFERENCES `unidade_de_medida` (`id_unidade_de_medida` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `produto_has_sub_produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `produto_has_sub_produto` ;

CREATE  TABLE IF NOT EXISTS `produto_has_sub_produto` (
  `produto_id_produto` INT NOT NULL ,
  `sub_produto_id_sub_produto` INT NOT NULL ,
  `quantidade` DOUBLE NULL ,
  PRIMARY KEY (`produto_id_produto`, `sub_produto_id_sub_produto`) ,
  INDEX `fk_produto_has_sub_produto_produto1` (`produto_id_produto` ASC) ,
  CONSTRAINT `fk_produto_has_sub_produto_sub_produto1`
    FOREIGN KEY (`sub_produto_id_sub_produto` )
    REFERENCES `sub_produto` (`id_sub_produto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_has_sub_produto_produto1`
    FOREIGN KEY (`produto_id_produto` )
    REFERENCES `produto` (`id_produto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `produto_has_sub_produto_modo_de_preparo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `produto_has_sub_produto_modo_de_preparo` ;

CREATE  TABLE IF NOT EXISTS `produto_has_sub_produto_modo_de_preparo` (
  `produto_id_produto` INT NOT NULL ,
  `sub_produto_id_sub_produto` INT NOT NULL ,
  `modo_de_preparo` VARCHAR(255) NULL ,
  PRIMARY KEY (`produto_id_produto`, `sub_produto_id_sub_produto`) ,
  INDEX `fk_produto_has_sub_produto1_sub_produto1` (`sub_produto_id_sub_produto` ASC) ,
  INDEX `fk_produto_has_sub_produto1_produto1` (`produto_id_produto` ASC) ,
  CONSTRAINT `fk_produto_has_sub_produto1_produto1`
    FOREIGN KEY (`produto_id_produto` )
    REFERENCES `produto` (`id_produto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_has_sub_produto1_sub_produto1`
    FOREIGN KEY (`sub_produto_id_sub_produto` )
    REFERENCES `sub_produto` (`id_sub_produto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pessoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pessoa` ;

CREATE  TABLE IF NOT EXISTS `pessoa` (
  `id_pessoa` INT NOT NULL ,
  `nome_pessoa` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id_pessoa`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `usuario` ;

CREATE  TABLE IF NOT EXISTS `usuario` (
  `pessoa_id_pessoa` INT NOT NULL ,
  `senha_usuario` VARCHAR(45) NULL ,
  INDEX `fk_usuario_pessoa1` (`pessoa_id_pessoa` ASC) ,
  PRIMARY KEY (`pessoa_id_pessoa`) ,
  CONSTRAINT `fk_usuario_pessoa1`
    FOREIGN KEY (`pessoa_id_pessoa` )
    REFERENCES `pessoa` (`id_pessoa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `modulo` ;

CREATE  TABLE IF NOT EXISTS `modulo` (
  `id_modulo` INT NOT NULL ,
  `nome_modulo` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_modulo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `usuario_has_modulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `usuario_has_modulo` ;

CREATE  TABLE IF NOT EXISTS `usuario_has_modulo` (
  `usuario_pessoa_id_pessoa` INT NOT NULL ,
  `modulo_id_modulo` INT NOT NULL ,
  PRIMARY KEY (`usuario_pessoa_id_pessoa`, `modulo_id_modulo`) ,
  INDEX `fk_usuario_has_modulo_modulo1` (`modulo_id_modulo` ASC) ,
  INDEX `fk_usuario_has_modulo_usuario1` (`usuario_pessoa_id_pessoa` ASC) ,
  CONSTRAINT `fk_usuario_has_modulo_usuario1`
    FOREIGN KEY (`usuario_pessoa_id_pessoa` )
    REFERENCES `usuario` (`pessoa_id_pessoa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_modulo_modulo1`
    FOREIGN KEY (`modulo_id_modulo` )
    REFERENCES `modulo` (`id_modulo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

