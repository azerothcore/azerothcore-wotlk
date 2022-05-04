-- DB update 2022_02_20_00 -> 2022_02_22_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_20_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_20_00 2022_02_22_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645476483912365838'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645476483912365838');

-- Smolderthorn Berserker guid 43101
-- adjust npc to use waypoints
UPDATE `creature` SET `MovementType`='2' WHERE  `guid`=43101;

-- link guid to waypoint
DELETE FROM `creature_addon` WHERE `guid`=43101;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES 
(43101, 926800, 0, 0, 0, 0, 3, NULL);

-- waypoints are transferred to waypoint_data
DELETE FROM `waypoint_data` WHERE `id`=926800;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(926800, 0, -53.6383, -442.827, 78.2854, 0, 0, 0, 0, 100, 0),
(926800, 1, -53.2897, -405.473, 77.7616, 0, 0, 0, 0, 100, 0),
(926800, 2, -52.7996, -389.966, 77.7702, 0, 0, 0, 0, 100, 0);

-- delete troublesome smart scripts
DELETE FROM `smart_scripts` WHERE  `entryorguid`=-43101;

-- delete exsisting waypoints
DELETE FROM `waypoints` WHERE `entry`=926800;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_22_00' WHERE sql_rev = '1645476483912365838';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
