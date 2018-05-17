SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER SCHEMA `condominio`  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_general_ci ;

CREATE TABLE IF NOT EXISTS `condominio`.`condominio` (
  `id_condominio` INT(11) NOT NULL,
  `nm_condominio` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_condominio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `condominio`.`pessoa` (
  `id_pessoa` INT(11) NOT NULL,
  `nome_pessoa` VARCHAR(45) NULL DEFAULT NULL,
  `data_nascimento_pessoa` DATE NULL DEFAULT NULL,
  `cpf_pessoa` VARCHAR(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_pessoa`),
  UNIQUE INDEX `CPF_UNIQUE` (`cpf_pessoa` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `condominio`.`morador` (
  `id_morador` INT(11) NOT NULL,
  `pessoa_id_pessoa` INT(11) NOT NULL,
  `apartamento_id_apartamento` INT(11) NOT NULL,
  PRIMARY KEY (`id_morador`),
  INDEX `fk_morador_pessoa1_idx` (`pessoa_id_pessoa` ASC),
  INDEX `fk_morador_apartamento1_idx` (`apartamento_id_apartamento` ASC),
  CONSTRAINT `fk_morador_pessoa1`
    FOREIGN KEY (`pessoa_id_pessoa`)
    REFERENCES `condominio`.`pessoa` (`id_pessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_morador_apartamento1`
    FOREIGN KEY (`apartamento_id_apartamento`)
    REFERENCES `condominio`.`apartamento` (`id_apartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `condominio`.`bloco` (
  `id_bloco` INT(11) NOT NULL,
  `nome_bloco` VARCHAR(45) NULL DEFAULT NULL,
  `condominio_id_condominio` INT(11) NOT NULL,
  PRIMARY KEY (`id_bloco`),
  INDEX `fk_bloco_condominio1_idx` (`condominio_id_condominio` ASC),
  CONSTRAINT `fk_bloco_condominio1`
    FOREIGN KEY (`condominio_id_condominio`)
    REFERENCES `condominio`.`condominio` (`id_condominio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `condominio`.`apartamento` (
  `id_apartamento` INT(11) NOT NULL,
  `nome_apartamento` VARCHAR(45) NULL DEFAULT NULL,
  `bloco_id_bloco` INT(11) NOT NULL,
  PRIMARY KEY (`id_apartamento`),
  INDEX `fk_apartamento_bloco1_idx` (`bloco_id_bloco` ASC),
  CONSTRAINT `fk_apartamento_bloco1`
    FOREIGN KEY (`bloco_id_bloco`)
    REFERENCES `condominio`.`bloco` (`id_bloco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `condominio`.`tipo_contrato` (
  `id_tipo_contrato` INT(11) NOT NULL,
  `nome_tipo_contrato` VARCHAR(45) NOT NULL,
  `valor_salario_tipo_contrato` DOUBLE NULL DEFAULT 0,
  PRIMARY KEY (`id_tipo_contrato`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `condominio`.`funcionario` (
  `id_funcionario` INT(11) NOT NULL,
  `condominio_id_condominio` INT(11) NOT NULL,
  `pessoa_id_pessoa` INT(11) NOT NULL,
  PRIMARY KEY (`id_funcionario`),
  INDEX `fk_funcionario_condominio1_idx` (`condominio_id_condominio` ASC),
  INDEX `fk_funcionario_pessoa1_idx` (`pessoa_id_pessoa` ASC),
  CONSTRAINT `fk_funcionario_condominio1`
    FOREIGN KEY (`condominio_id_condominio`)
    REFERENCES `condominio`.`condominio` (`id_condominio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionario_pessoa1`
    FOREIGN KEY (`pessoa_id_pessoa`)
    REFERENCES `condominio`.`pessoa` (`id_pessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `condominio`.`contrato` (
  `data_inicio` DATE NOT NULL,
  `tipo_contrato_id_tipo_contrato` INT(11) NOT NULL,
  `funcionario_id_funcionario` INT(11) NOT NULL,
  `data_fim` DATE NULL DEFAULT NULL,
  `valor_salario_combinado` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`data_inicio`, `tipo_contrato_id_tipo_contrato`, `funcionario_id_funcionario`),
  INDEX `fk_contrato_tipo_contrato1_idx` (`tipo_contrato_id_tipo_contrato` ASC),
  INDEX `fk_contrato_funcionario1_idx` (`funcionario_id_funcionario` ASC),
  CONSTRAINT `fk_contrato_tipo_contrato1`
    FOREIGN KEY (`tipo_contrato_id_tipo_contrato`)
    REFERENCES `condominio`.`tipo_contrato` (`id_tipo_contrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contrato_funcionario1`
    FOREIGN KEY (`funcionario_id_funcionario`)
    REFERENCES `condominio`.`funcionario` (`id_funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `condominio`.`area_de_lazer` (
  `id_area_de_lazer` INT(11) NOT NULL,
  `descricao_area_lazer` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_area_de_lazer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `condominio`.`reserva` (
  `area_de_lazer_id_area_de_lazer` INT(11) NOT NULL,
  `data_reserva` DATE NOT NULL,
  `morador_id_morador` INT(11) NOT NULL,
  `obs` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`area_de_lazer_id_area_de_lazer`, `data_reserva`, `morador_id_morador`),
  INDEX `fk_reserva_area_de_lazer1_idx` (`area_de_lazer_id_area_de_lazer` ASC),
  INDEX `fk_reserva_morador1_idx` (`morador_id_morador` ASC),
  CONSTRAINT `fk_reserva_area_de_lazer1`
    FOREIGN KEY (`area_de_lazer_id_area_de_lazer`)
    REFERENCES `condominio`.`area_de_lazer` (`id_area_de_lazer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_morador1`
    FOREIGN KEY (`morador_id_morador`)
    REFERENCES `condominio`.`morador` (`id_morador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `condominio`.`horario` (
  `idHorario` INT(11) NOT NULL,
  `hora_inicio` TIME NULL DEFAULT NULL,
  `hora_fim` TIME NULL DEFAULT NULL,
  PRIMARY KEY (`idHorario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `condominio`.`reserva_has_horario` (
  `reserva_area_de_lazer_id_area_de_lazer` INT(11) NOT NULL,
  `reserva_data_reserva` DATE NOT NULL,
  `reserva_morador_id_morador` INT(11) NOT NULL,
  `horario_idHorario` INT(11) NOT NULL,
  PRIMARY KEY (`reserva_area_de_lazer_id_area_de_lazer`, `reserva_data_reserva`, `reserva_morador_id_morador`, `horario_idHorario`),
  INDEX `fk_reserva_has_horario_reserva1_idx` (`reserva_area_de_lazer_id_area_de_lazer` ASC, `reserva_data_reserva` ASC, `reserva_morador_id_morador` ASC),
  INDEX `fk_reserva_has_horario_horario1_idx` (`horario_idHorario` ASC),
  CONSTRAINT `fk_reserva_has_horario_reserva1`
    FOREIGN KEY (`reserva_area_de_lazer_id_area_de_lazer` , `reserva_data_reserva` , `reserva_morador_id_morador`)
    REFERENCES `condominio`.`reserva` (`area_de_lazer_id_area_de_lazer` , `data_reserva` , `morador_id_morador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_has_horario_horario1`
    FOREIGN KEY (`horario_idHorario`)
    REFERENCES `condominio`.`horario` (`idHorario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
