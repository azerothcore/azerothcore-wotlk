-- DB update 2021_07_25_00 -> 2021_07_25_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_25_00 2021_07_25_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626956389818224000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626956389818224000');

-- Set the Creature Shadowforge Commander a patrol route movement
UPDATE `creature` SET  `MovementType` = 2  WHERE (`id` = 2744) AND (`guid` IN (69114, 134453, 134454, 134455));

-- Changed his movement from 1.60 to 1 so he dont speedwalk.
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 2744);

-- Delete previous routes
DELETE FROM `creature_addon` WHERE (`guid` IN (69114, 134453, 134454, 134455));

-- Routes
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(69114, 691140, 0, 0, 0, 0, 0, NULL),
(134453, 1344530, 0, 0, 0, 0, 0, NULL),
(134454, 1344540, 0, 0, 0, 0, 0, NULL),
(134455, 1344550, 0, 0, 0, 0, 0, NULL);

-- Delete all waypoints routes
DELETE FROM `waypoint_data` WHERE `id` IN (691140, 1344530, 1344540, 1344550);

-- Waypoint route 1 (GUID: 69114)
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(691140,1,-6319.29,-3099.946,310.83,0,0,0,0,100,0),
(691140,2,-6314.27,-3100.05,310.83,0,0,0,0,100,0),
(691140,3,-6308.11,-3092.66,306.11,0,0,0,0,100,0),
(691140,4,-6316.33,-3085.37,301.11,0,0,0,0,100,0),
(691140,5,-6325.79,-3083.65,301.11,0,5000,0,0,100,0),
(691140,6,-6336.63,-3096.23,301.11,0,0,0,0,100,0),
(691140,7,-6325.79,-3083.65,301.11,0,0,0,0,100,0),
(691140,8,-6316.33,-3085.37,301.11,0,0,0,0,100,0),
(691140,9,-6308.11,-3092.66,306.11,0,0,0,0,100,0),
(691140,10,-6314.27,-3100.05,310.83,0,0,0,0,100,0),
(691140,11,-6319.29,-3099.946,310.83,0,5000,0,0,100,0);

-- Waypoint route 2 (GUID: 134453)
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(1344530,1,-6327,-3083.21,310.83,0,5000,0,0,100,0),
(1344530,2,-6347.46,-3067.35,310.83,0,0,0,0,100,0),
(1344530,3,-6380.88,-3108.326,310.83,0,0,0,0,100,0),
(1344530,4,-6347.46,-3067.35,310.83,0,0,0,0,100,0),
(1344530,5,-6351.39,-3072.01,310.83,0,0,0,0,100,0),
(1344530,6,-6355.699,-3068.182,310.83,0,0,0,0,100,0),
(1344530,7,-6348.079,-3059.071,306.111,0,0,0,0,100,0),
(1344530,8,-6339.79,-3066.189,301.111,0,0,0,0,100,0),
(1344530,9,-6335.71,-3074.572,301.111,0,5000,0,0,100,0),
(1344530,10,-6348.079,-3059.071,306.111,0,0,0,0,100,0),
(1344530,11,-6355.699,-3068.182,310.83,0,0,0,0,100,0),
(1344530,12,-6347.46,-3067.35,310.83,0,0,0,0,100,0),
(1344530,13,-6380.88,-3108.326,310.83,0,0,0,0,100,0),
(1344530,14,-6347.46,-3067.35,310.83,0,0,0,0,100,0),
(1344530,15,-6327,-3083.21,310.83,0,0,0,0,100,0);

-- Waypoint route 3 (GUID: 134454)
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(1344540,1,-6380.88,-3108.326,310.83,0,0,0,0,100,0),
(1344540,2,-6347.46,-3067.35,310.83,0,0,0,0,100,0),
(1344540,3,-6351.39,-3072.01,310.83,0,0,0,0,100,0),
(1344540,4,-6355.699,-3068.182,310.83,0,0,0,0,100,0),
(1344540,5,-6348.079,-3059.071,306.111,0,0,0,0,100,0),
(1344540,6,-6339.79,-3066.189,301.111,0,0,0,0,100,0),
(1344540,7,-6335.71,-3074.572,301.112,0,5000,0,0,100,0),
(1344540,8,-6348.08,-3059.071,306.111,0,0,0,0,100,0),
(1344540,9,-6348.079,-3059.071,306.111,0,0,0,0,100,0),
(1344540,10,-6355.699,-3068.182,310.83,0,0,0,0,100,0),
(1344540,11,-6351.39,-3072.01,310.83,0,0,0,0,100,0),
(1344540,12,-6347.46,-3067.35,310.83,0,0,0,0,100,0),
(1344540,13,-6380.88,-3108.326,310.83,0,0,0,0,100,0),
(1344540,14,-6347.46,-3067.35,310.83,0,0,0,0,100,0),
(1344540,15,-6327,-3083.21,310.83,0,5000,0,0,100,0);

-- Waypoint route 4 (GUID: 134455)
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(1344550,1,-6349.87,-3065.44,310.83,0,0,0,0,100,0),
(1344550,2,-6348.42,-3133.10,310.83,0,5000,0,0,100,0),
(1344550,3,-6349.87,-3065.44,310.83,0,0,0,0,100,0),
(1344550,4,-6347.683,-3067.48,310.83,0,0,0,0,100,0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_25_01' WHERE sql_rev = '1626956389818224000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
