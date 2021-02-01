-- DB update 2017_01_24_04 -> 2017_01_24_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_01_24_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_01_24_04 2017_01_24_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1483918476110152000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1483918476110152000');

DELETE FROM `disables` WHERE `entry` = "532";
DELETE FROM `creature` WHERE `guid` = "135921";
DELETE FROM `creature` WHERE `ID` = "17644";

UPDATE `creature_template` SET `ScriptName` = "prince_axes" WHERE `entry` = "17650";

INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (30843, 41624, 0, 'Prince Enfeelble');

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
 (135921, 17645, 532, 1, 1, 11686, 0, -10935.6, -2043.06, 324.012, 2.17745, 604800, 0, 0, 42, 0, 0, 0, 0, 0);
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
