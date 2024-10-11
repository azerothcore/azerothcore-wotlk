-- DB update 2021_08_03_02 -> 2021_08_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_03_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_03_02 2021_08_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627308091046661200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627308091046661200');

-- Added patrolling movement and fixed his movement speed
UPDATE `creature_template` SET `speed_walk` = 1, `MovementType` = 2 WHERE (`entry` = 8201);

DELETE FROM `creature` WHERE (`id` = 8201) AND (`guid` IN (51831, 152280, 152281));

-- Added 2 more spawn points to Omgorn the Lost. One near Eastmoon Ruins and other near Southmoon ruins. Changed the spawn timer to 12h
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(51831, 8201, 1, 0, 0, 1, 1, 0, 1, -8431.95, -2890.55, 8.62454, 4.42492, 43200, 0, 0, 2769, 0, 2, 0, 0, 0, '', 0), -- Dunemaul Compound
(152280, 8201, 0, 0, 0, 1, 1, 0, 0, -8990.43, -3435.19, 24.91, 0, 43200, 0, 0, 1, 0, 2, 0, 0, 0, '', 0), --  Eastmoon Ruins
(152281, 8201, 0, 0, 0, 1, 1, 0, 0, -9307.09, -2989.11, 9.249, 0, 43200, 0, 0, 1, 0, 2, 0, 0, 0, '', 0); -- Southmoon Ruins

-- Added his 3 spawn points to the pool creature and added those 3 to a common pool template (366), with a max of 1 spawn at the same time
DELETE FROM `pool_template` WHERE `entry` = 366;

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)  VALUES (366, 1, "Omgorn the Lost Spawns");

DELETE FROM `pool_creature` WHERE `guid` IN (51831, 152280, 152281);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(51831, 366, 0, "Omgorn the Lost Dunemaul Compound Spawn"),
(152280, 366, 0, "Omgorn the Lost Eastmoon Ruins Spawn"),
(152281, 366, 0, "Omgorn the Lost Southmoon Ruins Spawn");

-- Delete previous routes
DELETE FROM `creature_addon` WHERE (`guid` IN (51831, 152280, 152281));

-- Add new routes
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(51831, 518310, 0, 0, 0, 0, 0, NULL),
(152280, 1522800, 0, 0, 0, 0, 0, NULL),
(152281, 1522810, 0, 0, 0, 0, 0, NULL);

-- Delete all waypoints routes
DELETE FROM `waypoint_data` WHERE `id` IN (518310, 1522800, 1522810);

-- Waypoint route Dunemaul Compound (GUID: 51831)
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(518310,1,-8495.70,-2931.99,8.71,0,0,0,0,100,0),
(518310,2,-8502.15,-2967.93,10.5,0,0,0,0,100,0),
(518310,3,-8462.07,-3062.26,9.79,0,0,0,0,100,0),
(518310,4,-8371.06,-3188.28,9.99,0,0,0,0,100,0),
(518310,5,-8287.775,-3176.50,18.68,0,0,0,0,100,0),
(518310,6,-8189.05,-3044.80,14.31,0,0,0,0,100,0),
(518310,7,-8209.79,-2950.67,17.10,0,0,0,0,100,0),
(518310,8,-8402.98,-2887.02,8.887,0,0,0,0,100,0),
(518310,9,-8431.95,-2890.55,8.62454,0,5000,0,0,100,0),
-- Waypoint route Eastmoon Ruins (GUID: 152280)
(1522800,1,-8971.64,-3539.97,15.39,0,0,0,0,100,0),
(1522800,2,-8963.56,-3546.34,15.100,0,0,0,0,100,0),
(1522800,3,-8813.38,-3539.072,9.411,0,0,0,0,100,0),
(1522800,4,-8810.405,-3367.46,10.92,0,0,0,0,100,0),
(1522800,5,-8828.79,-3337.46,8.735,0,0,0,0,100,0),
(1522800,6,-8850.57,-3337.23,9.390,0,0,0,0,100,0),
(1522800,7,-8905.34,-3401.42,13.47,0,0,0,0,100,0),
(1522800,8, 8990.43,-3435.19,24.91,0,0,0,0,100,0),
-- Waypoint route Southmoon Ruins (GUID: 152281)
(1522810,1,-9294.27,-2931.240,9.141,0,0,0,0,100,0),
(1522810,2,-9282.229,-2922.29,10.919,0,0,0,0,100,0),
(1522810,3,-9208.737,-2928.27,16.89,0,0,0,0,100,0),
(1522810,4,-9126.367,-2982.45,40.41,0,0,0,0,100,0),
(1522810,5,-9126.31,-3046.110,42.49,0,0,0,0,100,0),
(1522810,6,-9226.81,-3128.54,22.490,0,0,0,0,100,0),
(1522810,7,-9301.125,-3099.55,11.65,0,0,0,0,100,0),
(1522810,8,-9307.09,-2989.11,9.249,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_04_00' WHERE sql_rev = '1627308091046661200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
