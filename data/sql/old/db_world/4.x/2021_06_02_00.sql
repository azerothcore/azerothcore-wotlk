-- DB update 2021_06_01_03 -> 2021_06_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_01_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_01_03 2021_06_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1621946683156041900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621946683156041900');

DELETE FROM `conditions` WHERE `ConditionValue2` IN (12296, 12298);
INSERT INTO `conditions` VALUES
(17, 0, 19512, 0, 0, 31, 1, 3, 12296, 0, 0, 0, 0,'', 'Sickly Gazelle'),
(17, 0, 19512, 0, 1, 31, 1, 3, 12298, 0, 0, 0, 0,'', 'Sickly Deer');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12298;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 12298);
INSERT INTO `smart_scripts` VALUES
(12298, 0, 0, 1, 8, 0, 100, 0, 19512, 0, 15000, 15000, 0, 3, 12299, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sickly Deer - On Spellhit \'Apply Salve\' - Morph To Creature Cured Deer'),
(12298, 0, 1, 0, 61, 0, 100, 0, 19512, 0, 15000, 15000, 0, 18, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sickly Deer - On Spellhit \'Apply Salve\' - Set Flags Not Attackable'),
(12298, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 19, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sickly Deer - On Respawn - Remove Flags Not Attackable');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_02_00' WHERE sql_rev = '1621946683156041900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
