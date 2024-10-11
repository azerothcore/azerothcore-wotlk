-- DB update 2021_10_07_04 -> 2021_10_07_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_07_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_07_04 2021_10_07_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632680088118540400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632680088118540400');

DELETE FROM `creature` WHERE (`id` = 5930);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(16400, 5930, 1, 406, 465, 1, 1, 10875, 0, 684.793, 1458.34, -12.6599, 0.93, 43200, 10, 0, 2196, 1512, 1, 0, 0, 0, '', 0),
(29213, 5930, 1, 406, 465, 1, 1, 10875, 0, 657.605, 1796.68, -13.2473, 3.28, 43200, 20, 0, 2196, 1512, 1, 0, 0, 0, '', 0);

DELETE FROM `pool_creature` WHERE `guid` IN (16400, 29213);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(16400, 359, 0, 'Sister Riven Spawn 1'),
(29213, 359, 0, 'Sister Riven Spawn 2');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_07_05' WHERE sql_rev = '1632680088118540400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
