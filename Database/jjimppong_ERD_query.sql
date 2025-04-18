-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema jjimppong
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema jjimppong
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jjimppong` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `jjimppong` ;

-- -----------------------------------------------------
-- Table `jjimppong`.`email_auth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jjimppong`.`email_auth` (
  `user_email` VARCHAR(50) NOT NULL COMMENT '사용자 이메일',
  `auth_number` VARCHAR(4) NOT NULL COMMENT '이메일 인증 번호',
  PRIMARY KEY (`user_email`),
  UNIQUE INDEX `user_email_UNIQUE` (`user_email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `jjimppong`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jjimppong`.`user` (
  `user_id` VARCHAR(20) NOT NULL COMMENT '사용자 아이디',
  `user_nickname` VARCHAR(50) NOT NULL COMMENT '사용자 닉네임',
  `user_password` VARCHAR(255) NOT NULL COMMENT '사용자 비밀번호',
  `user_email` VARCHAR(50) NOT NULL COMMENT '사용자 이메일',
  `join_type` VARCHAR(6) NOT NULL COMMENT 'SNS 가입 타입 분류 NORMAL | KAKAO | NAVER',
  `name` VARCHAR(15) NOT NULL COMMENT '사용자 이름',
  `address` TEXT NOT NULL COMMENT '사용자 주소',
  `detail_address` TEXT NOT NULL COMMENT '사용자 상세주소',
  `user_level` INT NOT NULL COMMENT '사용자 회원 등급',
  `gender` VARCHAR(5) NOT NULL COMMENT '사용자 성별',
  `profile_image` TEXT NULL DEFAULT NULL COMMENT '사용자 프로필 사진',
  `sns_id` VARCHAR(100) NULL DEFAULT NULL COMMENT 'SNS 아이디',
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `user_email_UNIQUE` (`user_email` ASC) VISIBLE,
  UNIQUE INDEX `user_nickname_UNIQUE` (`user_nickname` ASC) VISIBLE,
  UNIQUE INDEX `sns_id_UNIQUE` (`sns_id` ASC) VISIBLE,
  CONSTRAINT `user_user_email_fk`
    FOREIGN KEY (`user_email`)
    REFERENCES `jjimppong`.`email_auth` (`user_email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `jjimppong`.`board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jjimppong`.`board` (
  `board_number` INT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(20) NOT NULL,
  `user_nickname` VARCHAR(50) NOT NULL COMMENT '작성자 닉네임',
  `user_level` INT NOT NULL,
  `board_content` TEXT NOT NULL,
  `board_title` TEXT NOT NULL,
  `board_address_category` TEXT NOT NULL,
  `board_detail_category` VARCHAR(15) NOT NULL,
  `board_write_date` VARCHAR(10) NOT NULL,
  `board_view_count` INT NOT NULL,
  `board_score` INT NOT NULL,
  `board_address` TEXT NULL DEFAULT NULL,
  `board_image` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`board_number`),
  INDEX `user_id_idx` (`user_id` ASC) INVISIBLE,
  CONSTRAINT `board_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `jjimppong`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `board_user_nickname_fk`
    FOREIGN KEY (`user_nickname`)
    REFERENCES `jjimppong`.`user` (`user_nickname`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `jjimppong`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jjimppong`.`comment` (
  `comment_number` INT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(20) NOT NULL,
  `board_number` INT NOT NULL,
  `comment_content` TEXT NOT NULL,
  `user_level` INT NOT NULL,
  `write_date` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`comment_number`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `board_number_UNIQUE` (`board_number` ASC) VISIBLE,
  CONSTRAINT `comment_board_number_fk`
    FOREIGN KEY (`board_number`)
    REFERENCES `jjimppong`.`board` (`board_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `comment_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `jjimppong`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `jjimppong`.`good`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jjimppong`.`good` (
  `user_id` VARCHAR(20) NOT NULL,
  `board_number` INT NOT NULL,
  PRIMARY KEY (`user_id`, `board_number`),
  CONSTRAINT `good_board_number_fk`
    FOREIGN KEY (`board_number`)
    REFERENCES `jjimppong`.`board` (`board_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `good_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `jjimppong`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `jjimppong`.`hate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jjimppong`.`hate` (
  `user_id` VARCHAR(20) NOT NULL,
  `board_number` INT NOT NULL,
  PRIMARY KEY (`user_id`, `board_number`),
  CONSTRAINT `hate_board_number_fk`
    FOREIGN KEY (`board_number`)
    REFERENCES `jjimppong`.`board` (`board_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `hate_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `jjimppong`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `jjimppong`.`local_festival`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jjimppong`.`local_festival` (
  `festival_number` INT NOT NULL AUTO_INCREMENT,
  `festival_date` VARCHAR(10) NOT NULL,
  `festival_name` TEXT NOT NULL,
  `festival_content` TEXT NOT NULL,
  `festival_image` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`festival_number`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `jjimppong`.`my_page`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jjimppong`.`my_page` (
  `user_id` VARCHAR(20) NOT NULL,
  `user_nickname` VARCHAR(50) NOT NULL,
  `board_number` INT NOT NULL,
  `user_level` INT NOT NULL,
  `user_score` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `user_nickname_UNIQUE` (`user_nickname` ASC) VISIBLE,
  UNIQUE INDEX `board_number_UNIQUE` (`board_number` ASC) VISIBLE,
  CONSTRAINT `my_page_board_number_fk`
    FOREIGN KEY (`board_number`)
    REFERENCES `jjimppong`.`board` (`board_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `my_page_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `jjimppong`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `my_page_user_nickname_fk`
    FOREIGN KEY (`user_nickname`)
    REFERENCES `jjimppong`.`user` (`user_nickname`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
