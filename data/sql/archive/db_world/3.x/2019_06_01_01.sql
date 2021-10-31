-- DB update 2019_06_01_00 -> 2019_06_01_01

-- Define helper functions

DROP FUNCTION IF EXISTS InsertLoiteringMiner;
DROP FUNCTION IF EXISTS InsertMiningMiner;
DROP FUNCTION IF EXISTS InsertLookoutDefender;
DROP FUNCTION IF EXISTS InsertPatrollingDefender;
DROP FUNCTION IF EXISTS InsertPatrollingDefenderWaypoint;

DELIMITER $$

CREATE FUNCTION InsertLoiteringMiner(modelid integer, position_x double, position_y double, position_z double, orientation double)
RETURNS decimal
DETERMINISTIC
BEGIN

	INSERT INTO `creature`(`id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
	(27401, 571, 0, 0, 1, 1, modelid, 1, position_x, position_y, position_z, orientation, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0);

	SET @NEW_GUID := LAST_INSERT_ID();

	RETURN @NEW_GUID;
END $$

DELIMITER $$

CREATE FUNCTION InsertMiningMiner(modelid integer, position_x double, position_y double, position_z double, orientation double)
RETURNS decimal
DETERMINISTIC
BEGIN

	INSERT INTO `creature`(`id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
	(27401, 571, 0, 0, 1, 1, modelid, 1, position_x, position_y, position_z, orientation, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);

	SET @NEW_GUID := LAST_INSERT_ID();

	INSERT INTO `creature_addon`(`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
	(@NEW_GUID, 0, 0, 0, 0, 173, NULL);

	RETURN @NEW_GUID;
END $$

DELIMITER $$

CREATE FUNCTION InsertLookoutDefender(modelid integer, position_x double, position_y double, position_z double, orientation double)
RETURNS decimal
DETERMINISTIC
BEGIN

	INSERT INTO `creature`(`id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
	(27284, 571, 0, 0, 1, 1, modelid, 1, position_x, position_y, position_z, orientation, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 0);

	SET @NEW_GUID := LAST_INSERT_ID();

	RETURN @NEW_GUID;
END $$

DELIMITER $$

CREATE FUNCTION InsertPatrollingDefender(modelid integer, position_x double, position_y double, position_z double, orientation double)
RETURNS decimal
DETERMINISTIC
BEGIN

	INSERT INTO `creature`(`id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
	(27284, 571, 0, 0, 1, 1, modelid, 1, position_x, position_y, position_z, orientation, 300, 2, 1, 1, 0, 2, 0, 0, 0, '', 0);

	SET @NEW_GUID := LAST_INSERT_ID();

	SELECT MAX(`id`) INTO @NEW_PATHID FROM `waypoint_data`;

	SET @NEW_PATHID := @NEW_PATHID + 1;

	INSERT INTO `creature_addon`(`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
	(@NEW_GUID, @NEW_PATHID, 0, 0, 1, 0, NULL);

	RETURN @NEW_PATHID;
END $$

DELIMITER $$

CREATE FUNCTION InsertPatrollingDefenderWaypoint(path_id integer, delay integer, position_x double, position_y double, position_z double, orientation double)
RETURNS decimal
DETERMINISTIC
BEGIN
	SELECT MAX(`point`) INTO @NEW_POINT FROM `waypoint_data` WHERE `id` = path_id;

	IF @NEW_POINT IS NULL THEN
		SET @NEW_POINT := 0;
	END IF;

	SET @NEW_POINT := @NEW_POINT + 1;

	INSERT INTO `waypoint_data`(`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
	(path_id, @NEW_POINT, position_x, position_y, position_z, orientation, delay, 0, 0, 100, 0);

	SET @NEW_ID := LAST_INSERT_ID();

	RETURN @NEW_ID;
END $$

DELIMITER ;

-- Begin update

DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_06_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_06_01_00 2019_06_01_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1558652459650339300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558652459650339300');

-- Remove old Risen Wintergarde Defender and Miner data

DELETE FROM `waypoint_data` WHERE `id` IN (SELECT `path_id` FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 27284));
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 27284);
DELETE FROM `creature` WHERE `id` = 27284;

DELETE FROM `waypoint_data` WHERE `id` IN (SELECT `path_id` FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 27401));
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 27401);
DELETE FROM `creature` WHERE `id` = 27401;


-- Insert Risen Wintergarde Miners who are loitering about

SET @rc := InsertLoiteringMiner(0, 3972.65, -818.15, 124.04, 0);
SET @rc := InsertLoiteringMiner(0, 4014.65, -809.00, 122.39, 0);
SET @rc := InsertLoiteringMiner(0, 4033.54, -842.57, 117.08, 0);
SET @rc := InsertLoiteringMiner(0, 4052.87, -879.22, 113.94, 0);
SET @rc := InsertLoiteringMiner(0, 4071.10, -909.27, 115.13, 0);

-- Insert Risen Wintergarde Miners who are actually working

SET @rc := InsertMiningMiner(0, 3897.89, -873.10, 109.21, 4.86);
SET @rc := InsertMiningMiner(0, 3910.60, -870.31, 107.37, 1.54);
SET @rc := InsertMiningMiner(0, 3938.72, -871.10, 103.57, 0.84);
SET @rc := InsertMiningMiner(0, 3971.04, -921.01, 106.30, 3.76);
SET @rc := InsertMiningMiner(0, 3998.63, -939.91, 105.56, 0.69);
SET @rc := InsertMiningMiner(0, 4001.73, -965.54, 104.77, 4.35);
SET @rc := InsertMiningMiner(0, 4009.08, -910.50, 106.71, 3.91);
SET @rc := InsertMiningMiner(0, 4077.82, -857.51, 111.64, 1.48);
SET @rc := InsertMiningMiner(0, 4102.12, -865.93, 112.80, 5.43);
SET @rc := InsertMiningMiner(0, 4108.65, -847.96, 115.29, 0.34);
SET @rc := InsertMiningMiner(0, 3979.84, -879.73, 118.40, 1.73);
SET @rc := InsertMiningMiner(0, 4037.43, -815.65, 122.41, 1.11);
SET @rc := InsertMiningMiner(0, 3957.36, -841.87, 121.36, 2.31);
SET @rc := InsertMiningMiner(0, 3925.18, -861.44, 121.77, 5.13);
SET @rc := InsertMiningMiner(0, 3924.98, -851.58, 122.35, 0.40);

-- Insert Risen Wintergarde Defenders who are on lookout

SET @rc := InsertLookoutDefender(0, 3878.03, -885.89, 119.57, 0);
SET @rc := InsertLookoutDefender(0, 3892.26, -901.20, 116.55, 0);
SET @rc := InsertLookoutDefender(0, 3998.27, -949.00, 105.44, 0);

-- Insert Risen Wintergarde Defenders who are on patrol

SET @NEW_PATHID := InsertPatrollingDefender(0, 3925.01, -855.59, 121.03, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 5000, 3925.01, -855.59, 121.03, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 3942.16, -854.97, 122.45, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 3958.25, -847.39, 120.89, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 5000, 3967.60, -836.33, 122.32, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 3958.25, -847.39, 120.89, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 3942.16, -854.97, 122.45, 0);

SET @NEW_PATHID := InsertPatrollingDefender(0, 3978.23, -805.63, 123.69, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 5000, 3978.23, -805.63, 123.69, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 3995.50, -797.23, 122.35, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 4006.58, -790.32, 118.38, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 5000, 4014.53, -772.76, 118.77, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 4006.58, -790.32, 118.38, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 3995.50, -797.23, 122.35, 0);

SET @NEW_PATHID := InsertPatrollingDefender(0, 4025.68, -843.86, 116.91, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 5000, 4025.68, -843.86, 116.91, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 4018.41, -854.82, 117.35, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 4007.88, -868.25, 117.17, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 5000, 3990.07, -879.86, 118.23, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 4007.88, -868.25, 117.17, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 4018.41, -854.82, 117.35, 0);

SET @NEW_PATHID := InsertPatrollingDefender(0, 4051.13, -866.23, 113.16, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 5000, 4051.13, -866.23, 113.16, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 4070.88, -860.97, 111.96, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 4084.76, -861.35, 111.93, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 5000, 4093.75, -857.18, 113.17, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 4084.76, -861.35, 111.93, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 4070.88, -860.97, 111.96, 0);

SET @NEW_PATHID := InsertPatrollingDefender(0, 3895.75, -869.76, 108.80, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 5000, 3895.75, -869.76, 108.80, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 3904.82, -871.95, 108.41, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 3922.05, -872.61, 105.45, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 3936.30, -870.95, 103.44, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 3951.62, -879.64, 104.64, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 5000, 3963.98, -868.77, 103.98, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 3951.62, -879.64, 104.64, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 3936.30, -870.95, 103.44, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 3922.05, -872.61, 105.45, 0);
SET @NEW_ID := InsertPatrollingDefenderWaypoint(@NEW_PATHID, 0, 3904.82, -871.95, 108.41, 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

-- Clean up helper functions

DROP FUNCTION IF EXISTS InsertLoiteringMiner;
DROP FUNCTION IF EXISTS InsertMiningMiner;
DROP FUNCTION IF EXISTS InsertLookoutDefender;
DROP FUNCTION IF EXISTS InsertPatrollingDefender;
DROP FUNCTION IF EXISTS InsertPatrollingDefenderWaypoint;
