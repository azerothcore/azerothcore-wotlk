-- DB update 2021_09_01_14 -> 2021_09_01_15
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_14';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_14 2021_09_01_15 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630158070330132264'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630158070330132264');

-- Added movement for The Husk
DELETE FROM `creature` WHERE (`id` = 1851) AND (`guid` IN (53933));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(53933, 1851, 0, 0, 0, 1, 1, 0, 0, 2325.76, -2255.95, 47.0159, 1.90398, 72000, 5, 0, 4370, 0, 1, 0, 0, 0, '', 0);

-- Set The Husk respawn to 32 hours
UPDATE `creature` SET `spawntimesecs` = 115200 WHERE `id` = 1851 AND `guid` = 53933;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_15' WHERE sql_rev = '1630158070330132264';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
