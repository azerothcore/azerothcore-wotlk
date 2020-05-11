-- DB update 2020_03_30_00 -> 2020_04_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_03_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_03_30_00 2020_04_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1582810463583691504'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1582810463583691504');

ALTER TABLE `battleground_template`
CHANGE `Comment` `Comment` char(38) COLLATE 'utf8_general_ci' NOT NULL AFTER `ScriptName`;

UPDATE `battleground_template` SET `Comment` = 'Alterac Valley (battleground)' WHERE `ID` = '1';
UPDATE `battleground_template` SET `Comment` = 'Warsong Gulch (battleground)' WHERE `ID` = '2';
UPDATE `battleground_template` SET `Comment` = 'Arathi Basin (battleground)' WHERE `ID` = '3';
UPDATE `battleground_template` SET `Comment` = 'Nagrand Arena / Ring of Trials (arena)' WHERE `ID` = '4';
UPDATE `battleground_template` SET `Comment` = 'Blades''s Edge Arena (arena)' WHERE `ID` = '5';
UPDATE `battleground_template` SET `Comment` = 'All Arenas (arena)' WHERE `ID` = '6';
UPDATE `battleground_template` SET `Comment` = 'Eye of The Storm (battleground)' WHERE `ID` = '7';
UPDATE `battleground_template` SET `Comment` = 'Ruins of Lordaeron (arena)' WHERE `ID` = '8';
UPDATE `battleground_template` SET `Comment` = 'Strand of the Ancients (battleground)' WHERE `ID` = '9';
UPDATE `battleground_template` SET `Comment` = 'Dalaran Sewers (arena)' WHERE `ID` = '10';
UPDATE `battleground_template` SET `Comment` = 'The Ring of Valor (arena)' WHERE `ID` = '11';
UPDATE `battleground_template` SET `Comment` = 'Isle of Conquest (battleground)' WHERE `ID` = '30';
UPDATE `battleground_template` SET `Comment` = 'Random Battleground (battleground)' WHERE `ID` = '32';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
