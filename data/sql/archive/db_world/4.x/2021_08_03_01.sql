-- DB update 2021_08_03_00 -> 2021_08_03_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_03_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_03_00 2021_08_03_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627307634943513800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627307634943513800');

-- Updated movement of Dart to patrol
UPDATE `creature_template` SET `MovementType` = 2 WHERE (`entry` = 14232);
-- Changed his spawn time from 5 minutes to 5 hours
UPDATE `creature` SET  `MovementType` = 2, `spawntimesecs` = 18000   WHERE (`id` = 14232) AND (`guid` = 200145);

-- Delete previous routes
DELETE FROM `creature_addon` WHERE (`guid` = 200145);

-- Add new route
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(200145, 2001450, 0, 0, 0, 0, 0, NULL);

-- Delete all waypoints routes
DELETE FROM `waypoint_data` WHERE `id` = 2001450;

-- Waypoint route 1 (GUID: 200145)
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(2001450,1,-2719.64,-3532.514,34.06,0,0,0,0,100,0),
(2001450,2,-2706.71,-3550.284,34.34,0,0,0,0,100,0),
(2001450,3,-2688.80,-3562.42,35.34,0,0,0,0,100,0),
(2001450,4,-2664.38,-3546.15,33.94,0,0,0,0,100,0),
(2001450,5,-2651.111,-3457.66,34.61,0,0,0,0,100,0),
(2001450,6,-2694.37,-3460.22,34.09,0,0,0,0,100,0),
(2001450,7,-2714.64,-3489.85,34.85,0,0,0,0,100,0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_03_01' WHERE sql_rev = '1627307634943513800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
