-- DB update 2025_12_29_11 -> 2025_12_29_12
--
-- Update to rehash for reapply
DROP TABLE IF EXISTS `trainer`;
CREATE TABLE `trainer` (
    `Id` INT UNSIGNED DEFAULT 0 NOT NULL,
    `Type` TINYINT UNSIGNED DEFAULT 2 NOT NULL,
    `Requirement` MEDIUMINT UNSIGNED DEFAULT 0 NOT NULL,
    `Greeting` MEDIUMTEXT NULL,
    `VerifiedBuild` INT DEFAULT 0 NULL,
    CONSTRAINT trainer_pk PRIMARY KEY (Id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `trainer_locale`;
CREATE TABLE `trainer_locale` (
    `Id` INT UNSIGNED NOT NULL DEFAULT 0,
    `locale` varchar(4) NOT NULL,
    `Greeting_lang` MEDIUMTEXT NULL,
    `VerifiedBuild` INT DEFAULT 0 NULL,
    CONSTRAINT `trainer_locale_pk` PRIMARY KEY (`Id`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `trainer_spell`;
CREATE TABLE `trainer_spell` (
    `TrainerId` int unsigned DEFAULT 0 NOT NULL,
    `SpellId` int unsigned DEFAULT 0 NOT NULL,
    `MoneyCost` int unsigned DEFAULT 0 NOT NULL,
    `ReqSkillLine` int unsigned DEFAULT 0 NOT NULL,
    `ReqSkillRank` int unsigned DEFAULT 0 NOT NULL,
    `ReqAbility1` int unsigned DEFAULT 0 NOT NULL,
    `ReqAbility2` int unsigned DEFAULT 0 NOT NULL,
    `ReqAbility3` int unsigned DEFAULT 0 NOT NULL,
    `ReqLevel` tinyint unsigned DEFAULT 0 NOT NULL,
    `VerifiedBuild` int DEFAULT 0 NULL,
    PRIMARY KEY (`TrainerId`, `SpellId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `creature_default_trainer`;
CREATE TABLE `creature_default_trainer` (
    `CreatureId` int unsigned NOT NULL,
    `TrainerId` int unsigned DEFAULT 0 NOT NULL,
    PRIMARY KEY (`CreatureId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Drop unused table
DROP TABLE IF EXISTS `npc_trainer`;

-- Drop removed columns
DELIMITER // 
CREATE PROCEDURE DropColumns() 
BEGIN
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'creature_template' AND COLUMN_NAME = 'trainer_type') THEN
    ALTER TABLE `creature_template` DROP `trainer_type`;
END IF;
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'creature_template' AND COLUMN_NAME = 'trainer_spell') THEN
    ALTER TABLE `creature_template` DROP `trainer_spell`;
END IF;
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'creature_template' AND COLUMN_NAME = 'trainer_class') THEN
    ALTER TABLE `creature_template` DROP `trainer_class`;
END IF;
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'creature_template' AND COLUMN_NAME = 'trainer_race') THEN
    ALTER TABLE `creature_template` DROP `trainer_race`;
END IF;
END //
DELIMITER ; -- 
CALL DropColumns();
DROP PROCEDURE DropColumns;
