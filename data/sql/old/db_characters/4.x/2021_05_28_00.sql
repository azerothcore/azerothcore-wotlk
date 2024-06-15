-- DB update 2021_04_29_00 -> 2021_05_28_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_characters' AND COLUMN_NAME = '2021_04_29_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_characters CHANGE COLUMN 2021_04_29_00 2021_05_28_00 bit;
SELECT sql_rev INTO OK FROM version_db_characters WHERE sql_rev = '1622121508190340200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1622121508190340200');

-- Set fist weapon skill equal to current unarmed skill value
UPDATE `character_skills` `cs_unarmed` INNER JOIN `character_skills` `cs_fist` ON `cs_unarmed`.`guid` = `cs_fist`.`guid`
SET `cs_fist`.`value` = `cs_unarmed`.`value`, `cs_fist`.`max` = `cs_unarmed`.`max`
WHERE `cs_unarmed`.`skill` = 162 AND `cs_fist`.`skill` = 473;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
