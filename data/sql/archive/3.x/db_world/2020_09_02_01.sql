-- DB update 2020_09_02_00 -> 2020_09_02_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_09_02_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_09_02_00 2020_09_02_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1597612448272232200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1597612448272232200');

UPDATE `gameobject_template` SET `ScriptName` = 'go_brewfest_music' WHERE `entry` = 186221;
UPDATE `gameobject_template` SET `ScriptName` = 'go_pirate_day_music' WHERE `entry` = 190363;
UPDATE `gameobject_template` SET `ScriptName` = 'go_darkmoon_faire_music' WHERE `entry` = 180335;
UPDATE `gameobject_template` SET `ScriptName` = 'go_midsummer_music' WHERE `entry` = 188174;

SET @LASTGUID = 4718; 
DELETE FROM `gameobject` WHERE `guid` BETWEEN @LASTGUID+1 AND @LASTGUID+2;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@LASTGUID+1 , 186221, 530, 1, 1, -1897.498, 5560.614, -12.34483, 4.363323, 0, 0, 0, 0, 120, 255, 1),
(@LASTGUID+2 , 186221, 530, 1, 1, 9325.442, -7276.318, 13.34217, 4.363323, 0, 0, 0, 0, 120, 255, 1);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (@LASTGUID+1,@LASTGUID+2);
INSERT INTO `game_event_gameobject` VALUES (24, @LASTGUID+1);
INSERT INTO `game_event_gameobject` VALUES (24, @LASTGUID+2);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
