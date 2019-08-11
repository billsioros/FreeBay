-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema freebay
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `freebay` ;

-- -----------------------------------------------------
-- Schema freebay
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `freebay` DEFAULT CHARACTER SET utf8 ;
USE `freebay` ;

-- -----------------------------------------------------
-- Table `freebay`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `freebay`.`User` ;

CREATE TABLE IF NOT EXISTS `freebay`.`User` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Username` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = dec8;


-- -----------------------------------------------------
-- Table `freebay`.`Admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `freebay`.`Admin` ;

CREATE TABLE IF NOT EXISTS `freebay`.`Admin` (
  `User_Id` INT NOT NULL,
  PRIMARY KEY (`User_Id`),
  INDEX `fk_Admin_User_idx` (`User_Id` ASC),
  CONSTRAINT `fk_Admin_User`
    FOREIGN KEY (`User_Id`)
    REFERENCES `freebay`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `freebay`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `freebay`.`Address` ;

CREATE TABLE IF NOT EXISTS `freebay`.`Address` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Street` VARCHAR(45) NULL,
  `Number` INT NULL,
  `ZipCode` VARCHAR(45) NULL,
  `Country` VARCHAR(45) NULL,
  `City` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `freebay`.`General_User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `freebay`.`General_User` ;

CREATE TABLE IF NOT EXISTS `freebay`.`General_User` (
  `User_Id` INT NOT NULL,
  `Seller_Rating` DECIMAL(4,1) NOT NULL,
  `Bidder_Rating` DECIMAL(4,1) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Surname` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  `Address_Id` INT NOT NULL,
  `Validated` BINARY(1) NOT NULL,
  PRIMARY KEY (`User_Id`),
  INDEX `fk_General_User_Address1_idx` (`Address_Id` ASC),
  CONSTRAINT `fk_General_User_User1`
    FOREIGN KEY (`User_Id`)
    REFERENCES `freebay`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_General_User_Address1`
    FOREIGN KEY (`Address_Id`)
    REFERENCES `freebay`.`Address` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `freebay`.`Auction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `freebay`.`Auction` ;

CREATE TABLE IF NOT EXISTS `freebay`.`Auction` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Seller_Id` INT NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Currently` DECIMAL NOT NULL,
  `First_Bid` DECIMAL NOT NULL,
  `Buy_Price` DECIMAL NULL,
  `Location` VARCHAR(45) NOT NULL,
  `Latitude` DECIMAL NULL,
  `Longitude` DECIMAL NULL,
  `Started` DATETIME NOT NULL,
  `Ends` DATETIME NOT NULL,
  `Description` TEXT(500) NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Auction_General_User1_idx` (`Seller_Id` ASC),
  CONSTRAINT `fk_Auction_General_User1`
    FOREIGN KEY (`Seller_Id`)
    REFERENCES `freebay`.`General_User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `freebay`.`Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `freebay`.`Category` ;

CREATE TABLE IF NOT EXISTS `freebay`.`Category` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `freebay`.`Item_has_CategoryA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `freebay`.`Item_has_CategoryA` ;

CREATE TABLE IF NOT EXISTS `freebay`.`Item_has_CategoryA` (
  `Item_Id` INT NOT NULL,
  `CategoryA_Id` INT NOT NULL,
  PRIMARY KEY (`Item_Id`, `CategoryA_Id`),
  INDEX `fk_Item_has_CategoryA_CategoryA1_idx` (`CategoryA_Id` ASC),
  CONSTRAINT `fk_Item_has_CategoryA_CategoryA1`
    FOREIGN KEY (`CategoryA_Id`)
    REFERENCES `freebay`.`Category` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `freebay`.`Auction_has_Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `freebay`.`Auction_has_Category` ;

CREATE TABLE IF NOT EXISTS `freebay`.`Auction_has_Category` (
  `Auction_Id` INT NOT NULL,
  `Category_Id` INT NOT NULL,
  PRIMARY KEY (`Auction_Id`, `Category_Id`),
  INDEX `fk_Auction_has_Category_Category1_idx` (`Category_Id` ASC),
  INDEX `fk_Auction_has_Category_Auction1_idx` (`Auction_Id` ASC),
  CONSTRAINT `fk_Auction_has_Category_Auction1`
    FOREIGN KEY (`Auction_Id`)
    REFERENCES `freebay`.`Auction` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Auction_has_Category_Category1`
    FOREIGN KEY (`Category_Id`)
    REFERENCES `freebay`.`Category` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `freebay`.`Bid`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `freebay`.`Bid` ;

CREATE TABLE IF NOT EXISTS `freebay`.`Bid` (
  `Id` INT NOT NULL,
  `User_id` INT NOT NULL,
  `Auction_Id` INT NOT NULL,
  `Amount` DECIMAL NOT NULL,
  `Time` DATETIME NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Bid_General_User1_idx` (`User_id` ASC),
  INDEX `fk_Bid_Auction1_idx` (`Auction_Id` ASC),
  CONSTRAINT `fk_Bid_General_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `freebay`.`General_User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bid_Auction1`
    FOREIGN KEY (`Auction_Id`)
    REFERENCES `freebay`.`Auction` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `freebay`.`Image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `freebay`.`Image` ;

CREATE TABLE IF NOT EXISTS `freebay`.`Image` (
  `Id` INT NOT NULL,
  `Path` VARCHAR(256) NOT NULL,
  `Auction_Id` INT NOT NULL,
  PRIMARY KEY (`Id`, `Auction_Id`),
  INDEX `fk_Image_Auction1_idx` (`Auction_Id` ASC),
  CONSTRAINT `fk_Image_Auction1`
    FOREIGN KEY (`Auction_Id`)
    REFERENCES `freebay`.`Auction` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `freebay`.`Message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `freebay`.`Message` ;

CREATE TABLE IF NOT EXISTS `freebay`.`Message` (
  `Auction_Id` INT NOT NULL,
  `Sender_Id` INT NOT NULL,
  `Receiver_Id` INT NOT NULL,
  `Body` TEXT(500) NOT NULL,
  `Time` DATETIME NOT NULL,
  PRIMARY KEY (`Auction_Id`),
  INDEX `fk_Message_Auction1_idx` (`Auction_Id` ASC),
  INDEX `fk_Message_User1_idx` (`Sender_Id` ASC),
  INDEX `fk_Message_User2_idx` (`Receiver_Id` ASC),
  CONSTRAINT `fk_Message_Auction1`
    FOREIGN KEY (`Auction_Id`)
    REFERENCES `freebay`.`Auction` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Message_User1`
    FOREIGN KEY (`Sender_Id`)
    REFERENCES `freebay`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Message_User2`
    FOREIGN KEY (`Receiver_Id`)
    REFERENCES `freebay`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `freebay`.`Tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `freebay`.`Tag` ;

CREATE TABLE IF NOT EXISTS `freebay`.`Tag` (
  `Id` INT NOT NULL,
  `Word` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `freebay`.`Auction_has_Tags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `freebay`.`Auction_has_Tags` ;

CREATE TABLE IF NOT EXISTS `freebay`.`Auction_has_Tags` (
  `Auction_Id` INT NOT NULL,
  `Tag_Id` INT NOT NULL,
  PRIMARY KEY (`Auction_Id`, `Tag_Id`),
  INDEX `fk_Auction_has_Tags_Tags1_idx` (`Tag_Id` ASC),
  INDEX `fk_Auction_has_Tags_Auction1_idx` (`Auction_Id` ASC),
  CONSTRAINT `fk_Auction_has_Tags_Auction1`
    FOREIGN KEY (`Auction_Id`)
    REFERENCES `freebay`.`Auction` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Auction_has_Tags_Tags1`
    FOREIGN KEY (`Tag_Id`)
    REFERENCES `freebay`.`Tag` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `freebay`.`Views`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `freebay`.`Views` ;

CREATE TABLE IF NOT EXISTS `freebay`.`Views` (
  `User_Id` INT NOT NULL,
  `Auction_Id` INT NOT NULL,
  `Time` DATETIME NOT NULL,
  PRIMARY KEY (`User_Id`, `Auction_Id`),
  INDEX `fk_General_User_has_Auction_Auction1_idx` (`Auction_Id` ASC),
  INDEX `fk_General_User_has_Auction_General_User1_idx` (`User_Id` ASC),
  CONSTRAINT `fk_General_User_has_Auction_General_User1`
    FOREIGN KEY (`User_Id`)
    REFERENCES `freebay`.`General_User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_General_User_has_Auction_Auction1`
    FOREIGN KEY (`Auction_Id`)
    REFERENCES `freebay`.`Auction` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
