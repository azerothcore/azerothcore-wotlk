-- DB update 2021_09_20_04 -> 2021_09_20_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_20_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_20_04 2021_09_20_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631708024134357951'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631708024134357951');

-- Adds movement to Stonewing Slayer's
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 16324 AND `guid` IN (82484, 82485, 82486, 82489, 82498, 82503, 82504);

-- Adds movement to Phantasmal Seeker's
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 16323 AND `guid` IN (82493, 82494, 82496, 82497, 82495, 82351, 82491, 82349);
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 1 WHERE `id` = 16323 AND `guid` IN (82350, 82328, 82492, 82490);

-- Slightly change position to prevent clipping for two Phantasmal Seeker's
UPDATE `creature` SET `position_x` = 7311.9, `position_y` = -5832.2, `position_z` = 15.45 WHERE `id` = 16323 AND `guid` = 82328;
UPDATE `creature` SET `position_x` = 7216.3, `position_y` = -5979.4, `position_z` = 19.68 WHERE `id` = 16323 AND `guid` = 82490;

-- Set one Phantasmal Seeker to patrolling 
UPDATE `creature` SET `MovementType` = 2 WHERE `id` = 16323 AND `guid` = 82487;

-- Adds a route for the Phantasmal Seeker
DELETE FROM `creature_addon` WHERE `guid` = 82487;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(82487, 824870, 0, 0, 0, 0, 0, NULL);

-- Add waypoints for the Phantasmal Seeker
DELETE FROM `waypoint_data` WHERE `id` = 824870;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES
(824870, 1,	7286.73,	-5964.22, 15.4202),
(824870, 2,	7293.21,	-5959.94, 15.1773),
(824870, 3,	7299.08,	-5956.65, 15.0248),
(824870, 4,	7304.33,	-5953.7, 14.6213),
(824870, 5,	7308.65,	-5950.88, 14.1004),
(824870, 6,	7310.65,	-5948.25, 13.8296),
(824870, 7,	7311.53,	-5945.37, 13.7021),
(824870, 8,	7311.24,	-5941.79, 13.6582),
(824870, 9,	7309.27,	-5935.17, 13.8332),
(824870, 10, 7307.3,	-5928.76, 14.1482),
(824870, 11, 7303.95, -5921.62, 14.307),
(824870, 12, 7299.56, -5914.15, 14.5982),
(824870, 13, 7294.26, -5905.56, 14.3212),
(824870, 14, 7289.68, -5898.28, 13.9821),
(824870, 15, 7287.58, -5895.17, 13.8603),
(824870, 16, 7284.34, -5893.74, 13.7864),
(824870, 17, 7279.11, -5893.12, 13.8361),
(824870, 18, 7271.35, -5894.16, 14.3568),
(824870, 19, 7263.86, -5896.11, 14.8053),
(824870, 20, 7254.53, -5900.68, 15.4498),
(824870, 21, 7249.57, -5904.94, 15.823),
(824870, 22, 7246.04, -5910.05, 16.2925),
(824870, 23, 7243.84, -5916.22, 16.5462),
(824870, 24, 7241.87, -5926.04, 16.998),
(824870, 25, 7241.01, -5933.38, 17.3221),
(824870, 26, 7241.26, -5941.87, 17.5516),
(824870, 27, 7243.9, -5950.12, 17.8846),
(824870, 28, 7246.6, -5956.61, 18.0386),
(824870, 29, 7251.13, -5962.84, 17.9534),
(824870, 30, 7258.5, -5969.97, 17.5446),
(824870, 31, 7264.38, -5973.02, 17.1572),
(824870, 32, 7268.8,	-5974.18, 16.9677),
(824870, 33, 7273.13, -5973.39, 16.5934),
(824870, 34, 7277.34, -5971.04, 16.1648),
(824870, 35, 7282.69, -5967, 15.6897);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_20_05' WHERE sql_rev = '1631708024134357951';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
