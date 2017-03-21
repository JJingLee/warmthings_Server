-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema warmdb_CRM
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema warmdb_CRM
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `warmdb_CRM` DEFAULT CHARACTER SET utf8 ;
USE `warmdb_CRM` ;

-- -----------------------------------------------------
-- Table `warmdb_CRM`.`user_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`user_type` (
  `id` INT NOT NULL,
  `name` ENUM('staff', 'vendor', 'patient', 'care', 'admin') NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`user_member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`user_member` (
  `id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `type` INT NULL,
  `birth` DATE NULL,
  `blood` ENUM('A', 'B', 'AB', 'O') NULL,
  `address` VARCHAR(254) NULL,
  `default_delivery_address_id` VARCHAR(254) NULL,
  `tel` VARCHAR(45) NULL,
  `mobile` VARCHAR(45) NULL,
  `des` VARCHAR(254) NULL,
  `current_used_goods_list` VARCHAR(45) NULL,
  `enable` TINYINT(1) NULL,
  `login_time` DATETIME NULL,
  `create_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_member_user_type_idx` (`type` ASC),
  CONSTRAINT `fk_user_member_user_type`
    FOREIGN KEY (`type`)
    REFERENCES `warmdb_CRM`.`user_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`user_delivery_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`user_delivery_address` (
  `id` INT NOT NULL,
  `user_id` VARCHAR(45) NOT NULL,
  `address` VARCHAR(254) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_delivery_address_user_mmember_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_delivery_address_user_mmember`
    FOREIGN KEY (`user_id`)
    REFERENCES `warmdb_CRM`.`user_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`user_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`user_log` (
  `id` INT NOT NULL,
  `user_id` VARCHAR(45) NOT NULL,
  `action` ENUM('a', 'b', 'c') NOT NULL,
  `item` VARCHAR(45) NOT NULL,
  `value` VARCHAR(45) NOT NULL,
  `comment` VARCHAR(45) NULL,
  `update_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fK_user_log_usermember_idx` (`user_id` ASC),
  CONSTRAINT `fK_user_log_usermember`
    FOREIGN KEY (`user_id`)
    REFERENCES `warmdb_CRM`.`user_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`user_favorite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`user_favorite` (
  `id` INT NOT NULL,
  `favorite_supplier_id` VARCHAR(254) NULL,
  `favorite_goods_id` VARCHAR(254) NULL,
  `favorite_careunit_id` VARCHAR(254) NULL,
  `user_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_user_favorite_user_member_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_favorite_user_member`
    FOREIGN KEY (`user_id`)
    REFERENCES `warmdb_CRM`.`user_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`supplier_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`supplier_type` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`goods_branding`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`goods_branding` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`supplier` (
  `id` INT NOT NULL,
  `user_id` VARCHAR(45) NOT NULL,
  `branding_id` INT NULL,
  `name` VARCHAR(45) NULL,
  `short_name` VARCHAR(45) NULL,
  `type_id` INT NOT NULL,
  `serial_numbers` VARCHAR(45) NULL,
  `title` VARCHAR(45) NULL,
  `contactor` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `tel` VARCHAR(45) NULL,
  `mobile` VARCHAR(45) NULL,
  `fax` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `goods_status_list` VARCHAR(254) NULL,
  `goods_branding_id` INT NOT NULL,
  `note` VARCHAR(45) NULL,
  `company_create_time` DATETIME NULL,
  `create_time` DATETIME NULL,
  `update_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_supplier_user_member_idx` (`user_id` ASC),
  INDEX `fk_supplier_supplier_type_idx` (`type_id` ASC),
  INDEX `fk_supplier_goods_branding_idx` (`goods_branding_id` ASC),
  CONSTRAINT `fk_supplier_user_member`
    FOREIGN KEY (`user_id`)
    REFERENCES `warmdb_CRM`.`user_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_supplier_supplier_type`
    FOREIGN KEY (`type_id`)
    REFERENCES `warmdb_CRM`.`supplier_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_supplier_goods_branding`
    FOREIGN KEY (`goods_branding_id`)
    REFERENCES `warmdb_CRM`.`goods_branding` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`appraisal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`appraisal` (
  `id` INT NOT NULL,
  `question_list` VARCHAR(45) NULL,
  `answer_list` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`user_medical_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`user_medical_record` (
  `record_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  `accompanist` VARCHAR(45) NULL,
  `buying_goods_id` VARCHAR(45) NULL,
  `appraisal_id` INT NOT NULL,
  `date` DATETIME NULL,
  `update_time` DATETIME NULL,
  PRIMARY KEY (`record_id`),
  INDEX `fk_user_medical_record_appraisal_idx` (`appraisal_id` ASC),
  INDEX `fk_user_medical_record_patient_idx` (`patient_id` ASC),
  CONSTRAINT `fk_user_medical_record_appraisal`
    FOREIGN KEY (`appraisal_id`)
    REFERENCES `warmdb_CRM`.`appraisal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_medical_record_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `warmdb_CRM`.`patient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`careunit_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`careunit_type` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`careunit_class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`careunit_class` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`careunit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`careunit` (
  `id` INT NOT NULL,
  `user_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  `short_name` VARCHAR(45) NULL,
  `type_id` INT NULL,
  `class_id` INT NULL,
  `serial_numbers` VARCHAR(45) NULL,
  `contactor` VARCHAR(45) NULL,
  `services` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `tel` VARCHAR(45) NULL,
  `mobile` VARCHAR(45) NULL,
  `fax` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `note` VARCHAR(45) NULL,
  `company_create_time` DATETIME NULL,
  `create_time` DATETIME NULL,
  `update_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_careunit_user_member_idx` (`user_id` ASC),
  INDEX `fk_careunit_careunit_type_idx` (`type_id` ASC),
  INDEX `fk_careunit_careunit_class_idx` (`class_id` ASC),
  CONSTRAINT `fk_careunit_user_member`
    FOREIGN KEY (`user_id`)
    REFERENCES `warmdb_CRM`.`user_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_careunit_careunit_type`
    FOREIGN KEY (`type_id`)
    REFERENCES `warmdb_CRM`.`careunit_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_careunit_careunit_class`
    FOREIGN KEY (`class_id`)
    REFERENCES `warmdb_CRM`.`careunit_class` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`patient` (
  `id` INT NOT NULL,
  `user_id` VARCHAR(45) NOT NULL,
  `identity` VARCHAR(45) NULL,
  `urgent_contactor` VARCHAR(45) NULL,
  `urgent_contactor_rela` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `address_habitation` VARCHAR(45) NULL,
  `habitation_des` VARCHAR(45) NULL,
  `habitation_des_from_careman` VARCHAR(45) NULL,
  `live_with` VARCHAR(45) NULL,
  `accompanist` VARCHAR(45) NULL,
  `accompanist_id` INT NULL,
  `careunit_id` INT NULL,
  `careman_id` VARCHAR(45) NULL,
  `patientcol` VARCHAR(45) NULL,
  `request_comment` VARCHAR(45) NULL,
  `request_comment_from_careman` VARCHAR(45) NULL,
  `economy_status` VARCHAR(45) NULL,
  `hold_goods_id_list` VARCHAR(45) NULL,
  `create_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_patient_user_member_idx` (`user_id` ASC),
  INDEX `fk_patient_user_medical_record_idx` (`accompanist_id` ASC),
  INDEX `fk_patient_careunit_idx` (`careunit_id` ASC),
  INDEX `fk_patient_user_member_careman_idx` (`careman_id` ASC),
  CONSTRAINT `fk_patient_user_member`
    FOREIGN KEY (`user_id`)
    REFERENCES `warmdb_CRM`.`user_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_user_medical_record`
    FOREIGN KEY (`accompanist_id`)
    REFERENCES `warmdb_CRM`.`user_medical_record` (`appraisal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_careunit`
    FOREIGN KEY (`careunit_id`)
    REFERENCES `warmdb_CRM`.`careunit` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_user_member_careman`
    FOREIGN KEY (`careman_id`)
    REFERENCES `warmdb_CRM`.`user_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`user_cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`user_cart` (
  `id` INT NOT NULL,
  `goods_id_list` VARCHAR(45) NULL,
  `user_id` VARCHAR(45) NOT NULL,
  `update_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_cart_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_cart`
    FOREIGN KEY (`user_id`)
    REFERENCES `warmdb_CRM`.`user_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`user_credit_card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`user_credit_card` (
  `id` INT NOT NULL,
  `user_id` VARCHAR(45) NOT NULL,
  `number` VARCHAR(16) NOT NULL,
  `type` ENUM('VISA', 'MASTER') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_credit_card_user_member_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_credit_card_user_member`
    FOREIGN KEY (`user_id`)
    REFERENCES `warmdb_CRM`.`user_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`user_recommendation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`user_recommendation` (
  `id` INT NOT NULL,
  `user_id` VARCHAR(45) NOT NULL,
  `goods_id` VARCHAR(45) NULL,
  `recommender` VARCHAR(45) NULL,
  `system_recommend` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_recommandation_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_recommandation`
    FOREIGN KEY (`user_id`)
    REFERENCES `warmdb_CRM`.`user_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`user_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`user_order` (
  `id` INT NOT NULL,
  `user_id` VARCHAR(45) NOT NULL,
  `payingby` ENUM('a', 'b', 'c') NOT NULL,
  `status` ENUM('a', 'b', 'c') NOT NULL,
  `is_paid` TINYINT(1) NOT NULL,
  `credit_card_id` INT NULL,
  `receiver` VARCHAR(45) NULL,
  `delivery_address` VARCHAR(45) NULL,
  `order_time` DATETIME NULL,
  `create_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_order_user_member_idx` (`user_id` ASC),
  INDEX `fk_user_order_user_credit_card_idx` (`credit_card_id` ASC),
  CONSTRAINT `fk_user_order_user_member`
    FOREIGN KEY (`user_id`)
    REFERENCES `warmdb_CRM`.`user_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_order_user_credit_card`
    FOREIGN KEY (`credit_card_id`)
    REFERENCES `warmdb_CRM`.`user_credit_card` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`goods_class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`goods_class` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`goods_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`goods_type` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`goods_minor_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`goods_minor_category` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `parent_category_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`goods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`goods` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `category_id` INT NOT NULL,
  `branding_id` INT NOT NULL,
  `type_id` INT NULL,
  `class_id` INT NULL,
  `style` VARCHAR(45) NULL,
  `price` DOUBLE NULL,
  `original_price` DOUBLE NULL,
  `list_price` DOUBLE NULL,
  `preferential_rate` DOUBLE NULL,
  `description` VARCHAR(45) NULL,
  `picture_h` VARCHAR(254) NULL,
  `picture_m` VARCHAR(254) NULL,
  `picture_s` VARCHAR(254) NULL,
  `enable` TINYINT(1) NULL,
  `update_time` DATETIME NULL,
  `create_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_goods_goods_class_idx` (`class_id` ASC),
  INDEX `fk_goods_goods_type_idx` (`type_id` ASC),
  INDEX `fk_goods_goods_branding_idx` (`branding_id` ASC),
  INDEX `fk_goods_goods_minor_category_idx` (`category_id` ASC),
  CONSTRAINT `fk_goods_goods_class`
    FOREIGN KEY (`class_id`)
    REFERENCES `warmdb_CRM`.`goods_class` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_goods_goods_type`
    FOREIGN KEY (`type_id`)
    REFERENCES `warmdb_CRM`.`goods_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_goods_goods_branding`
    FOREIGN KEY (`branding_id`)
    REFERENCES `warmdb_CRM`.`goods_branding` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_goods_goods_minor_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `warmdb_CRM`.`goods_minor_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`goods_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`goods_status` (
  `id` INT NOT NULL,
  `goods_id` INT NOT NULL,
  `number` INT NOT NULL,
  `status` ENUM('a', 'b', 'c') NULL,
  `price` DOUBLE NULL,
  `create_time` DATETIME NULL,
  `update_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_goods_status_goods_idx` (`goods_id` ASC),
  CONSTRAINT `fk_goods_status_goods`
    FOREIGN KEY (`goods_id`)
    REFERENCES `warmdb_CRM`.`goods` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`order_goods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`order_goods` (
  `id` INT NOT NULL,
  `user_order_id` INT NOT NULL,
  `goods_status_id` INT NOT NULL,
  `update_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_goods_user_order_idx` (`user_order_id` ASC),
  INDEX `fk_order_goods_goods_status_idx` (`goods_status_id` ASC),
  CONSTRAINT `fk_order_goods_user_order`
    FOREIGN KEY (`user_order_id`)
    REFERENCES `warmdb_CRM`.`user_order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_goods_goods_status`
    FOREIGN KEY (`goods_status_id`)
    REFERENCES `warmdb_CRM`.`goods_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`goods_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`goods_details` (
  `id` INT NOT NULL,
  `goods_id` INT NOT NULL,
  `content` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_goods_details_goods_idx` (`goods_id` ASC),
  CONSTRAINT `fk_goods_details_goods`
    FOREIGN KEY (`goods_id`)
    REFERENCES `warmdb_CRM`.`goods` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`goods_comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`goods_comment` (
  `id` INT NOT NULL,
  `goods_id` INT NOT NULL,
  `title` VARCHAR(45) NULL,
  `content` VARCHAR(254) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_goods_comment_goods_idx` (`goods_id` ASC),
  CONSTRAINT `fk_goods_comment_goods`
    FOREIGN KEY (`goods_id`)
    REFERENCES `warmdb_CRM`.`goods` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warmdb_CRM`.`appraisal_question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warmdb_CRM`.`appraisal_question` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
