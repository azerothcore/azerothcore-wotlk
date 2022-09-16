-- DB update 2021_07_30_02 -> 2021_07_30_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_30_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_30_02 2021_07_30_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627247672807799200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627247672807799200');

-- Set the Creature Alshirr Banebreath a patrol route movement
UPDATE `creature` SET  `MovementType` = 2  WHERE (`id` = 14340) AND (`guid` = 51894);

-- Changed his movement from 1.76 to 1 so he dont speedwalk.
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 14340);

-- Delete previous routes
DELETE FROM `creature_addon` WHERE (`guid` = 51894);

-- Routes
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(51894, 518940, 0, 0, 0, 0, 0, NULL);

-- Delete all waypoints routes
DELETE FROM `waypoint_data` WHERE `id` = 518940;

-- Waypoint route 1 (GUID: 51894)
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(518940,1,3866.84,-672.53,328.888,0,0,0,0,100,0),
(518940,2,3866.84,-672.534,328.888,0,0,0,0,100,0),
(518940,3,3818.17,-768.04,314.71,0,0,0,0,100,0),
(518940,4,3881.397,-769.048,311.51,0,0,0,0,100,0),
(518940,5,3892.74,-762.76,312.98,0,0,0,0,100,0),
(518940,6,3863.57,-759.42,312.95,0,0,0,0,100,0),
(518940,7,3844.86,-719.223,324.47,0,0,0,0,100,0),
(518940,8,3856.46,-673-884,328.53,0,0,0,0,100,0),
(518940,9,3894.64,-635.31,336.71,0,0,0,0,100,0),
(518940,10,3932.94,-611.101,340.266,0,0,0,0,100,0),
(518940,11,3981.27,-598.98,338.19,0,0,0,0,100,0),
(518940,12,3932.94,-611.101,340.266,0,0,0,0,100,0),
(518940,13,3894.64,-635.31,336.71,0,0,0,0,100,0),
(518940,14,3856.46,-673-884,328.53,0,0,0,0,100,0),
(518940,15,3844.86,-719.223,324.47,0,0,0,0,100,0),
(518940,16,3863.57,-759.42,312.95,0,0,0,0,100,0),
(518940,17,3892.74,-762.76,312.98,0,0,0,0,100,0),
(518940,18,3881.397,-769.048,311.51,0,0,0,0,100,0),
(518940,19,3818.17,-768.04,314.71,0,0,0,0,100,0),
(518940,20,3866.84,-672.534,328.888,0,0,0,0,100,0),
(518940,21,3866.84,-672.53,328.888,0,0,0,0,100,0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_30_03' WHERE sql_rev = '1627247672807799200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
