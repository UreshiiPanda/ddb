CREATE DATABASE IF NOT EXISTS ddb;
USE ddb;


SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;


-- -----------------------------------------------------
-- Table `Dungeons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Dungeons` ;

CREATE TABLE IF NOT EXISTS `Dungeons` (
  `dungeon_id` INT(11) AUTO_INCREMENT NOT NULL UNIQUE,
  `dungeon_name` VARCHAR(100) NOT NULL UNIQUE,
  `dungeon_type` VARCHAR(50) NOT NULL,
  `dungeon_description` VARCHAR(255) NULL,
  `damage_multiplier` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`dungeon_id`),
  UNIQUE INDEX `dungeon_id_UNIQUE` (`dungeon_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Abilities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Abilities` ;

CREATE TABLE IF NOT EXISTS `Abilities` (
  `ability_id` INT(11) NOT NULL AUTO_INCREMENT UNIQUE,
  `ability_name` VARCHAR(100) NOT NULL UNIQUE,
  `ability_damage` INT(11) NULL DEFAULT NULL,
  `Dungeons_dungeon_id` INT(11),
  PRIMARY KEY (`ability_id`),
  INDEX `fk_Abilities_Dungeons1_idx` (`Dungeons_dungeon_id` ASC) VISIBLE,
  UNIQUE INDEX `ability_id_UNIQUE` (`ability_id` ASC) VISIBLE,
  CONSTRAINT `fk_Abilities_Dungeons1`
    FOREIGN KEY (`Dungeons_dungeon_id`)
    REFERENCES `Dungeons` (`dungeon_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `User_Accounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `User_Accounts` ;

CREATE TABLE IF NOT EXISTS `User_Accounts` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT UNIQUE,
  `username` VARCHAR(50) NOT NULL UNIQUE,
  `password` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Characters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Characters` ;

CREATE TABLE IF NOT EXISTS `Characters` (
  `character_id` INT(11) NOT NULL AUTO_INCREMENT UNIQUE,
  `character_name` VARCHAR(100) NOT NULL UNIQUE,
  `race` VARCHAR(100) NULL DEFAULT NULL,
  `class` VARCHAR(100) NULL DEFAULT NULL,
  `creature_type` VARCHAR(100) NULL DEFAULT NULL,
  `alignment` VARCHAR(100) NULL DEFAULT NULL,
  `Users_user_id` INT(11) NOT NULL,
  PRIMARY KEY (`character_id`),
  INDEX `user_id_idx` (`Users_user_id` ASC) VISIBLE,
  UNIQUE INDEX `character_id_UNIQUE` (`character_id` ASC) VISIBLE,
  CONSTRAINT `character_name_cant_be_empty_string`
    CHECK (character_name <> ''),
  CONSTRAINT `user_id`
    FOREIGN KEY (`Users_user_id`)
    REFERENCES `User_Accounts` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spells`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Spells` ;

CREATE TABLE IF NOT EXISTS `Spells` (
  `spell_id` INT(11) NOT NULL AUTO_INCREMENT UNIQUE,
  `spell_name` VARCHAR(100) NOT NULL UNIQUE,
  `spell_damage` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`spell_id`),
  UNIQUE INDEX `spell_id_UNIQUE` (`spell_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Items` ;

CREATE TABLE IF NOT EXISTS `Items` (
  `item_id` INT(11) NOT NULL AUTO_INCREMENT UNIQUE,
  `item_name` VARCHAR(100) NOT NULL UNIQUE,
  `item_description` VARCHAR(255) NULL,
  `is_weapon` TINYINT(0) NOT NULL DEFAULT 0,
  PRIMARY KEY (`item_id`),
  UNIQUE INDEX `item_name_UNIQUE` (`item_name` ASC) VISIBLE,
  UNIQUE INDEX `item_id_UNIQUE` (`item_id` ASC) VISIBLE,
  CONSTRAINT `item_name_cant_be_empty_string`
    CHECK (item_name <> ''))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Inventory_Items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Inventory_Items` ;

CREATE TABLE IF NOT EXISTS `Inventory_Items` (
  `inventory_id` INT(11) NOT NULL AUTO_INCREMENT UNIQUE,
  `quantity` INT(11) NULL,
  `Items_item_id` INT(11) NULL,
  `Characters_character_id` INT(11) NOT NULL,
  PRIMARY KEY (`inventory_id`, `Characters_character_id`),
  INDEX `fk_item_id_idx` (`Items_item_id` ASC) VISIBLE,
  INDEX `fk_characters_idx` (`Characters_character_id` ASC) VISIBLE,
  UNIQUE INDEX `inventory_id_UNIQUE` (`inventory_id` ASC) VISIBLE,
  CONSTRAINT `item_id`
    FOREIGN KEY (`Items_item_id`)
    REFERENCES `Items` (`item_id`)
    ON DELETE CASCADE
    ON UPDATE SET NULL,
  CONSTRAINT `Characters_character_id`
    FOREIGN KEY (`Characters_character_id`)
    REFERENCES `Characters` (`character_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `single_stack_of_item_per_char`
    UNIQUE (`Items_item_id`, `Characters_character_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Characters_has_Abilities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Characters_has_Abilities` ;

CREATE TABLE IF NOT EXISTS `Characters_has_Abilities` (
  `Characters_character_id` INT(11) NOT NULL,
  `Abilities_ability_id` INT(11) NOT NULL,
  PRIMARY KEY (`Characters_character_id`, `Abilities_ability_id`),
  INDEX `fk_Characters_has_Abilities_Abilities1_idx` (`Abilities_ability_id` ASC) VISIBLE,
  INDEX `fk_Characters_has_Abilities_Characters1_idx` (`Characters_character_id` ASC) VISIBLE,
  CONSTRAINT `fk_Characters_has_Abilities_Characters1`
    FOREIGN KEY (`Characters_character_id`)
    REFERENCES `Characters` (`character_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Characters_has_Abilities_Abilities1`
    FOREIGN KEY (`Abilities_ability_id`)
    REFERENCES `Abilities` (`ability_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Characters_has_Spells`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Characters_has_Spells` ;

CREATE TABLE IF NOT EXISTS `Characters_has_Spells` (
  `Characters_character_id` INT(11) NOT NULL,
  `Spells_spell_id` INT(11) NOT NULL,
  PRIMARY KEY (`Characters_character_id`, `Spells_spell_id`),
  INDEX `fk_Characters_has_Spells_Spells1_idx` (`Spells_spell_id` ASC) VISIBLE,
  INDEX `fk_Characters_has_Spells_Characters1_idx` (`Characters_character_id` ASC) VISIBLE,
  CONSTRAINT `fk_Characters_has_Spells_Characters1`
    FOREIGN KEY (`Characters_character_id`)
    REFERENCES `Characters` (`character_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Characters_has_Spells_Spells1`
    FOREIGN KEY (`Spells_spell_id`)
    REFERENCES `Spells` (`spell_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- Insert test data into User_Accounts table
INSERT INTO User_Accounts (username, password, email)
VALUES
    ("Daniel", "Dragons", "dand@mail.com"),
    ("wdean123", "dean123", "deanw123@gmail.com"),
    ("joe_user5", "user123", "joe.user@yahoo.com"),
    ("new_user01", "newuserpw01", "random.person@mail.com")
    ;


-- Insert test data into Characters table
INSERT INTO Characters (character_name, race, class, creature_type, alignment, Users_user_id)
VALUES
    ("Bardy","Half-Elf","Bard","Humanoid", "Lawful Good",(SELECT User_Accounts.user_id FROM User_Accounts WHERE User_Accounts.username="Daniel")),
    ("Ranger_Rick","Elf","Ranger","Humanoid","Lawful Neutral",(SELECT User_Accounts.user_id FROM User_Accounts WHERE User_Accounts.username="Daniel")),
    ("evil_mage","Other","Magician","Demon","Chaotic Evil",(SELECT User_Accounts.user_id FROM User_Accounts WHERE User_Accounts.username="Daniel")),
    ("gollum","Other","Rogue","Fiend","Neutral Evil",(SELECT User_Accounts.user_id FROM User_Accounts WHERE User_Accounts.username="wdean123")	),
    ("fighter_orc","Orc","Fighter","Humanoid","True Neutral",(SELECT User_Accounts.user_id FROM User_Accounts WHERE User_Accounts.username="joe_user5"))
    ;


-- Insert test data into Items table
INSERT INTO Items (item_name, item_description, is_weapon)
VALUES
    ("Sword","A sharp sword",1),
    ("Stick","magical stick",1),
    ("Healing Potion","Heals 25 hit-points",0),
    ("Coins","Game Currency",0),
    ("Wooden Shield","Offers minimal protection",0)
    ;


-- Insert test data into Inventory_Items table
INSERT INTO Inventory_Items (quantity, Items_item_id, Characters_character_id)
VALUES
    (1,1,1),
    (2,2,1),
    (8,3,3),
    (10000,4,1),
    (1,2,2),
    (50,4,2),
    (1, 1, 5),
    (15, 4, 5)
    ;


-- Insert test data into Dungeons table
INSERT INTO Dungeons (dungeon_id, dungeon_name, dungeon_type, dungeon_description, damage_multiplier) 
VALUES 
    (1, "Zora's Domain", "Demon", "A cave with water and fountains", 2), 
    (2, "Temple of Time", "Fairy", "A temple with flute music", 1.5), 
    (3, "Bowser's Castle", "Monster", "A castle with piranha plants and evil mushrooms", 3)
    ; 
    

-- Insert test data into Abilities table
INSERT INTO Abilities (ability_id, ability_name, ability_damage, Dungeons_dungeon_id) 
VALUES 
    (1, "Charisma", 4, 1), 
    (2, "Hope", 2, 2), 
    (3, "Dread", 3, 2)
    ;
    

-- Insert test data into Characters_has_Abilities table
INSERT INTO Characters_has_Abilities (Characters_character_id, Abilities_ability_id) 
VALUES 
    (1, 1), 
    (2, 1), 
    (3, 2), 
    (3, 3)
    ;
    

-- Insert test data into Spells table
INSERT INTO Spells (spell_id, spell_name, spell_damage) 
VALUES 
    (1, "Elf Punch", 5), 
    (2, "Expelliarmus", 2), 
    (3, "Cruciatus", 8)
    ;
    

-- Insert test data into Characters_has_Spells table
INSERT INTO Characters_has_Spells (Characters_character_id, Spells_spell_id) 
VALUES 
    (3, 1), 
    (4, 1), 
    (5, 2), 
    (5, 3)
    ;


-- reset foreign key checks for proper sql db cascades
SET FOREIGN_KEY_CHECKS=1;
COMMIT;
