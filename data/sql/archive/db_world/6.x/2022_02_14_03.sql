-- DB update 2022_02_14_02 -> 2022_02_14_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_14_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_14_02 2022_02_14_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1644527416818211100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644527416818211100');

DELETE FROM `creature` WHERE `guid` BETWEEN 285020 AND 285040;
INSERT INTO `creature` (`guid`, `id1`, `map`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`) VALUES
-- Dwarven Farmer (Hidden farm #1)
(285020, 12998, 0, 0, -1853.19, -4122.06, 11.1314, 4.76928, 60, 0, 2),
(285021, 12998, 0, 0, -1853.49, -4091.65, 9.81663, 4.70644, 60, 0, 0),
-- Ram (Hidden farm #1)
(285022, 2098, 0, 0, -1813.51, -4155.14, 9.89494, 1.82635, 60, 0, 0),
(285023, 2098, 0, 0, -1818.03, -4142.99, 9.89494, 4.68913, 60, 0, 0),
-- Cat (Hidden farm #1)
(285024, 6368, 0, 0, -1855.72, -4117.62, 13.0457, 5.2373, 60, 0, 0),
(285025, 6368, 0, 0, -1839.99, -4245.72, 2.13572, 1.15007, 60, 0, 0),
-- Rat (Hidden farm #1)
(285026, 4075, 0, 0, -1818.5, -4149.38, 9.89524, 0.0426621, 60, 5, 1),
(285027, 4075, 0, 0, -1853.79, -4149.49, 9.74445, 5.99991, 60, 5, 1),
(285028, 4075, 0, 0, -1832.93, -4231.47, 2.13493, 4.15422, 60, 5, 1),
(285029, 4075, 0, 0, -1765.09, -4228.05, 2.06121, 3.92646, 60, 5, 1),
(285030, 4075, 0, 0, -1685.3, -4200.7, 1.99848, 0.324622, 60, 5, 1),
(285031, 4075, 0, 0, -1720.4, -4190.35, 1.99845, 2.78763, 60, 5, 1),
(285032, 4075, 0, 0, -1953.66, -4080.47, 2.03243, 1.65973, 60, 5, 1),
(285033, 4075, 0, 0, -1981, -4082.81, 2.06496, 2.00923, 60, 5, 1),
(285034, 4075, 0, 0, -1952.94, -4118.76, 2.0329, 5.26471, 60, 5, 1),
(285035, 4075, 0, 0, -1933.78, -4107.02, 2.0329, 5.249, 60, 5, 1),
(285036, 4075, 0, 0, -1898.76, -4155.48, 2.0329, 6.10665, 60, 5, 1),
(285037, 4075, 0, 0, -1773.96, -4198.48, 1.99868, 5.41943, 60, 5, 1),
(285038, 4075, 0, 0, -1748.44, -4205.78, 1.99868, 5.91973, 60, 5, 1),
(285039, 4075, 0, 0, -1702.71, -4252.72, 1.99827, 2.49775, 60, 5, 1),
(285040, 4075, 0, 0, -1728.17, -4279.38, 1.99826, 4.70708, 60, 5, 1);

DELETE FROM `creature_addon` WHERE `guid` IN (285021, 285024, 285025);
INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`) VALUES
(285021, 0, 3),
(285024, 0, 1),
(285025, 0, 1);

SET @NPC := 285020;
SET @PATH := @NPC * 10;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES
(@NPC, @PATH);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -1851.5, -4161.39, 8.0422, 100, 5000),
(@PATH, 2, -1849.24, -4170.83, 6.40288, 0, 0),
(@PATH, 3, -1843.77, -4176.64, 5.19335, 0, 0),
(@PATH, 4, -1827.66, -4188.65, 3.6245, 0, 0),
(@PATH, 5, -1821.43, -4200.03, 3.37323, 100, 5000);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_14_03' WHERE sql_rev = '1644527416818211100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
