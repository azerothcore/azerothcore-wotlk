-- DB update 2022_03_06_13 -> 2022_03_06_14
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_06_13';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_06_13 2022_03_06_14 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646089487915555800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646089487915555800');

SET @NPC := 849;
SET @PATH := @NPC * 10;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -12378.6, -963.559, 15.3825, 0, 0),
(@PATH, 2, -12389.1, -960.663, 19.123, 0, 0),
(@PATH, 3, -12402, -953.174, 24.9704, 0, 0),
(@PATH, 4, -12410.9, -950.4, 28.0988, 0, 0),
(@PATH, 5, -12415.9, -942.535, 28.7172, 0, 0),
(@PATH, 6, -12422.5, -930.758, 30.8608, 0, 0),
(@PATH, 7, -12434.3, -915.714, 35.5984, 0, 0),
(@PATH, 8, -12448.6, -909.005, 38.7702, 0, 0),
(@PATH, 9, -12434.3, -915.714, 35.5984, 0, 0),
(@PATH, 10, -12422.5, -930.758, 30.8608, 0, 0),
(@PATH, 11, -12415.9, -942.535, 28.7172, 0, 0),
(@PATH, 12, -12410.9, -950.4, 28.0988, 0, 0),
(@PATH, 13, -12402, -953.174, 24.9704, 0, 0),
(@PATH, 14, -12389.1, -960.663, 19.123, 0, 0),
(@PATH, 15, -12378.6, -963.559, 15.3825, 0, 0),
(@PATH, 16, -12369.5, -963.88, 12.9135, 0, 0);

SET @NPC := 853;
SET @PATH := @NPC * 10;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -12360, -997.523, 11.4784, 100, 0),
(@PATH, 2, -12357.6, -985.988, 13.5685, 100, 0),
(@PATH, 3, -12354.6, -978.756, 13.4476, 100, 0),
(@PATH, 4, -12354.1, -978.975, 13.382, 100, 0),
(@PATH, 5, -12355.9, -982.584, 13.5899, 100, 0),
(@PATH, 6, -12359.3, -989.846, 12.8712, 100, 0),
(@PATH, 7, -12360.9, -993.477, 12.1879, 100, 0),
(@PATH, 8, -12361.1, -997.291, 11.6832, 100, 0),
(@PATH, 9, -12357.2, -1003.77, 9.11341, 100, 0),
(@PATH, 10, -12352.2, -1010.01, 7.92257, 100, 0),
(@PATH, 11, -12349.6, -1013.02, 8.13928, 100, 0),
(@PATH, 12, -12348, -1016.79, 8.16116, 100, 0),
(@PATH, 13, -12346.5, -1020.48, 7.7491, 100, 0),
(@PATH, 14, -12335, -1034.68, 7.85564, 100, 0),
(@PATH, 15, -12334.5, -1030.99, 8.1515, 100, 0),
(@PATH, 16, -12338.7, -1024.88, 8.12575, 100, 0),
(@PATH, 17, -12342.3, -1022.66, 7.9493, 100, 0),
(@PATH, 18, -12345.3, -1020.53, 7.70349, 100, 0),
(@PATH, 19, -12350.3, -1014.33, 8.01138, 100, 0),
(@PATH, 20, -12354.8, -1007.67, 8.62256, 100, 0),
(@PATH, 21, -12359, -1001.3, 9.76074, 100, 0);

SET @NPC := 856;
SET @PATH := @NPC * 10;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -12330.2, -933.855, 9.33679, 0, 0),
(@PATH, 2, -12309.3, -908.34, 8.68362, 0, 0),
(@PATH, 3, -12287.8, -885.928, 7.72276, 0, 0),
(@PATH, 4, -12271.6, -855.56, 7.95999, 0, 0),
(@PATH, 5, -12256, -815.657, 9.87775, 0, 0),
(@PATH, 6, -12246.8, -791.101, 12.5155, 0, 0),
(@PATH, 7, -12256, -815.657, 9.87775, 0, 0),
(@PATH, 8, -12271.6, -855.56, 7.95999, 0, 0),
(@PATH, 9, -12287.8, -885.928, 7.72276, 0, 0),
(@PATH, 10, -12309.3, -908.34, 8.68362, 0, 0),
(@PATH, 11, -12330.2, -933.855, 9.33679, 0, 0),
(@PATH, 12, -12351.4, -969, 13.033, 0, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_06_14' WHERE sql_rev = '1646089487915555800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
