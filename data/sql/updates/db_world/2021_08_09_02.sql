-- DB update 2021_08_09_01 -> 2021_08_09_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_09_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_09_01 2021_08_09_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1628080294513744600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628080294513744600');

-- Set the Creature Anathemus a patrol route movement
UPDATE `creature` SET  `MovementType` = 2  WHERE (`id` = 2754) AND (`guid` = 27567);

-- Changed his movement from 2,17 to 1 so he dont speedwalk.
UPDATE `creature_template` SET `MovementType` = 2, `speed_walk` = 1 WHERE (`entry` = 2754);

-- Delete previous routes
DELETE FROM `creature_addon` WHERE (`guid` = 27567);

-- Routes
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(27567, 275670, 0, 0, 0, 0, 0, NULL);

-- Delete all waypoints routes
DELETE FROM `waypoint_data` WHERE `id` IN (275670);

-- Waypoint route 1 (GUID: 27567)
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(275670,1,-7075.337,-2746.77,242.38,0,0,0,0,100,0),
(275670,2,-6998.37,-2935.20,242.85,0,0,0,0,100,0),
(275670,3,-7095.14,-3233.39,241.97,0,0,0,0,100,0),
(275670,4,-7004-02,-3492.03,241.91,0,0,0,0,100,0),
(275670,5,-6804.23,-3549.75,244.50,0,0,0,0,100,0),
(275670,6,-6690-48,-3309.44,240.95,0,0,0,0,100,0),
(275670,7,-6773,-3163.26,240.74,0,0,0,0,100,0),
(275670,8,-6843.23,-3050.88,241.66,0,0,0,0,100,0),
(275670,9,-6879.76,-2928.77,243.70,0,0,0,0,100,0),
(275670,10,-6833.49,-2687.53,241.71,0,0,0,0,100,0),
(275670,11,-6819.16,-2597.03,241.05,0,0,0,0,100,0),
(275670,12,-6942.75,-2481.17,240.74,0,0,0,0,100,0),
(275670,13,-7033.93,-2392.77,240.57,0,0,0,0,100,0),
(275670,14,-7115.22,-2400.27,241.66,0,0,0,0,100,0),
(275670,15,-7179.15,-2409.38,240.94,0,0,0,0,100,0),
(275670,16,-7196.16,-2514.99,248.71,0,0,0,0,100,0),
(275670,17,-7171.79,-2652.01,243.47,0,0,0,0,100,0),
(275670,18,-7119.41, -2668.77, 241.7,0,0,0,0,100,0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_09_02' WHERE sql_rev = '1628080294513744600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
