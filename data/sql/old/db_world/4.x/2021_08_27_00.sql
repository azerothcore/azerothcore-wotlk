-- DB update 2021_08_26_07 -> 2021_08_27_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_26_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_26_07 2021_08_27_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629745042472693409'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629745042472693409');

-- respwan time

UPDATE `creature` SET `spawntimesecs` = 21600 WHERE `guid` = 15973;

-- Added patrolling

UPDATE `creature_template` SET `MovementType` = 2 WHERE (`entry` = 14278);

-- Updated the movement on his spawn
UPDATE `creature` SET `MovementType` = 2 WHERE (`id` = 14278) AND (`guid` = 15973);

-- Delete previous routes
DELETE FROM `creature_addon` WHERE (`guid` = 15973);

-- Add new routes
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(15973, 159730, 0, 0, 0, 0, 0, NULL);

-- Delete all waypoints routes
DELETE FROM `waypoint_data` WHERE `id` = 159730;

-- Waypoint route Dalsons tears near cauldron (GUID: 45454)
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(159730, 1, -880.30  , -1032.42 , 30.34578, 0, 0, 0, 0,100,0),
(159730, 2, -885.70  , -1040.68 , 30.34578, 0, 0, 0, 0,100,0),
(159730, 3, -898.923 , -1050.920, 30.34578, 0, 0, 0, 0,100,0),
(159730, 4, -908.335 , -1055.722, 30.34595, 0, 0, 0, 0,100,0),
(159730, 5, -912.035 , -1055.486, 30.34595, 0, 0, 0, 0,100,0),
(159730, 6, -919.614 , -1051.208, 30.34595, 0, 0, 0, 0,100,0),
(159730, 7, -924.325 , -1047.562, 30.34595, 0, 0, 0, 0,100,0),
(159730, 8, -929.031 , -1043.921, 30.35560, 0, 0, 0, 0,100,0),
(159730, 9, -938.372 , -1035.547, 30.39772, 0, 0, 0, 0,100,0),
(159730, 10, -946.259, -1026.183, 30.34911, 0, 0, 0, 0,100,0),
(159730, 11, -951.212, -1018.694, 30.34911, 0, 0, 0, 0,100,0),
(159730, 12, -954.386, -1009.925, 30.45613, 0, 0, 0, 0,100,0),
(159730, 13, -956.031, -998.758 , 30.37342, 0, 0, 0, 0,100,0),
(159730, 14, -955.722, -983.045 , 30.34802, 0, 0, 0, 0,100,0),
(159730, 15, -952.334, -969.990 , 30.34802, 0, 0, 0, 0,100,0),
(159730, 16, -947.107, -962.829 , 30.34802, 0, 0, 0, 0,100,0),
(159730, 17, -940.456, -956.618 , 30.34802, 0, 0, 0, 0,100,0),
(159730, 18, -932.542, -948.591 , 30.56252, 0, 0, 0, 0,100,0),
(159730, 19, -924.466, -941.975 , 30.85870, 0, 0, 0, 0,100,0),
(159730, 20, -909.822, -944.424 , 30.79283, 0, 0, 0, 0,100,0),
(159730, 21, -896.085, -957.336 , 30.34636, 0, 0, 0, 0,100,0),
(159730, 22, -884.526, -961.853 , 30.39329, 0, 0, 0, 0,100,0),
(159730, 23, -874.028, -972.279 , 30.36785, 0, 0, 0, 0,100,0),
(159730, 24, -865.245, -980.257 , 30.34796, 0, 0, 0, 0,100,0),
(159730, 25, -857.588, -989.615 , 30.34796, 0, 0, 0, 0,100,0),
(159730, 26, -860.608, -999.514 , 30.34797, 0, 0, 0, 0,100,0),
(159730, 27, -868.656, -1016.163, 30.35438, 0, 0, 0, 0,100,0),
(159730, 28, -874.132, -1025.667, 30.34858, 0, 0, 0, 0,100,0),
(159730, 29, -875.823, -1028.603, 30.34858, 0, 0, 0, 0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_27_00' WHERE sql_rev = '1629745042472693409';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
