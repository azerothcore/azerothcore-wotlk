-- DB update 2021_01_13_00 -> 2021_01_13_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_13_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_13_00 2021_01_13_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1609106243604105800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609106243604105800');

-- DELETE OLD WAYPOINTS
DELETE FROM `waypoints` WHERE `entry`=25220;

DELETE FROM `waypoints` WHERE `entry`=2522000;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(2522000, 1, 2253.64, 5195.47, 11.4006, 'Civilian Recruit'),
(2522000, 2, 2254.1, 5196.36, 11.4006, 'Civilian Recruit'),
(2522000, 3, 2277.82, 5238.72, 11.451, 'Civilian Recruit'),
(2522000, 4, 2279.22, 5241.41, 11.451, 'Civilian Recruit'),
(2522000, 5, 2280.84, 5244.22, 11.4572, 'Civilian Recruit'),
(2522000, 6, 2282.6, 5245.74, 11.3635, 'Civilian Recruit'),
(2522000, 7, 2284.87, 5246.3, 11.451, 'Civilian Recruit'),
(2522000, 8, 2287.47, 5245.93, 11.451, 'Civilian Recruit'),
(2522000, 9, 2289.47, 5244.9, 11.451, 'Civilian Recruit'),
(2522000, 10, 2291.77, 5243.93, 11.451, 'Civilian Recruit'),
(2522000, 11, 2294.13, 5242.71, 11.451, 'Civilian Recruit'),
(2522000, 12, 2296.28, 5241.78, 11.401, 'Civilian Recruit'),
(2522000, 13, 2303.02, 5253.31, 11.5058, 'Civilian Recruit'),
(2522000, 14, 2308.73, 5256.93, 11.5058, 'Civilian Recruit'),
(2522000, 15, 2320.83, 5259.26, 11.2558, 'Civilian Recruit');

DELETE FROM `waypoints` WHERE `entry`=2522001;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(2522001, 1, 2296.559, 5246.846, 11.404, 'Civilian Recruit'),
(2522001, 2, 2292.450, 5254.650, 11.388, 'Civilian Recruit'),
(2522001, 3, 2285.198, 5253.812, 11.234, 'Civilian Recruit'),
(2522001, 4, 2277.200, 5253.496, 11.276, 'Civilian Recruit'),
(2522001, 5, 2269.225, 5256.365, 7.161, 'Civilian Recruit'),
(2522001, 6, 2261.543, 5259.822, 7.163, 'Civilian Recruit'),
(2522001, 7, 2258.661, 5260.919, 7.359, 'Civilian Recruit'),
(2522001, 8, 2251.999, 5263.715, 11.654, 'Civilian Recruit'),
(2522001, 9, 2242.162, 5267.343, 11.658, 'Civilian Recruit'),
(2522001, 10, 2234.742, 5269.070, 7.347, 'Civilian Recruit'),
(2522001, 11, 2224.120, 5274.070, 7.163, 'Civilian Recruit'),
(2522001, 12, 2216.152, 5276.913, 11.278, 'Civilian Recruit'),
(2522001, 13, 2214.973, 5278.051, 11.281, 'Civilian Recruit'),
(2522001, 14, 2213.541, 5282.745, 10.813, 'Civilian Recruit'),
(2522001, 15, 2214.522, 5288.735, 10.604, 'Civilian Recruit'),
(2522001, 16, 2212.032, 5291.217, 10.618, 'Civilian Recruit'),
(2522001, 17, 2205.3017, 5292.435, 15.717, 'Civilian Recruit'),
(2522001, 18, 2197.444, 5295.870, 22.238, 'Civilian Recruit'),
(2522001, 19, 2194.665, 5296.065, 21.897, 'Civilian Recruit'),
(2522001, 20, 2192.113, 5293.873, 22.002, 'Civilian Recruit'),
(2522001, 21, 2188.318, 5286.672, 22.058, 'Civilian Recruit'),
(2522001, 22, 2184.876, 5284.927, 22.058, 'Civilian Recruit'),
(2522001, 23, 2182.702, 5284.855, 22.058, 'Civilian Recruit'),
(2522001, 24, 2178.031, 5285.953, 24.625, 'Civilian Recruit'),
(2522001, 25, 2169.735, 5289.780, 24.665, 'Civilian Recruit'),
(2522001, 26, 2163.189, 5290.488, 24.665, 'Civilian Recruit'),
(2522001, 27, 2158.472, 5291.988, 24.665, 'Civilian Recruit');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25220;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25220);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25220, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Just Summoned - Set Active On'),
(25220, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 2522000, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Just Summoned - Start Waypoint'),
(25220, 0, 2, 0, 8, 0, 100, 0, 45313, 0, 0, 0, 0, 54, 22000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Spellhit \'Anchor Here\' - Pause Waypoint'),
(25220, 0, 3, 0, 8, 0, 100, 0, 45307, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Spellhit \'Borean Tundra - Valiance Keep Flavor - Queue Global Ping\' - Resume Waypoint'),
(25220, 0, 4, 0, 40, 0, 100, 0, 3, 2522000, 0, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Waypoint 3 Reached - Cast \'Anchor Here\''),
(25220, 0, 5, 0, 40, 0, 100, 0, 4, 2522000, 0, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Waypoint 4 Reached - Cast \'Anchor Here\''),
(25220, 0, 6, 0, 40, 0, 100, 0, 5, 2522000, 0, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Waypoint 5 Reached - Cast \'Anchor Here\''),
(25220, 0, 7, 0, 40, 0, 100, 0, 6, 2522000, 0, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Waypoint 6 Reached - Cast \'Anchor Here\''),
(25220, 0, 8, 0, 40, 0, 100, 0, 7, 2522000, 0, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Waypoint 7 Reached - Cast \'Anchor Here\''),
(25220, 0, 9, 0, 40, 0, 100, 0, 8, 2522000, 0, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Waypoint 8 Reached - Cast \'Anchor Here\''),
(25220, 0, 10, 0, 40, 0, 100, 0, 9, 2522000, 0, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Waypoint 9 Reached - Cast \'Anchor Here\''),
(25220, 0, 11, 0, 40, 0, 100, 0, 10, 2522000, 0, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Waypoint 10 Reached - Cast \'Anchor Here\''),
(25220, 0, 12, 0, 40, 0, 100, 0, 11, 2522000, 0, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Waypoint 11 Reached - Cast \'Anchor Here\''),
(25220, 0, 13, 14, 40, 0, 100, 0, 12, 2522000, 0, 0, 0, 54, 18000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Waypoint 12 Reached - Pause Waypoint'),
(25220, 0, 14, 0, 61, 0, 100, 0, 12, 2522000, 0, 0, 0, 87, 2522000, 2522001, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Waypoint 12 Reached - Run Random Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2522000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2522000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 25222, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Actionlist - Say Line 0'),
(2522000, 9, 1, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Actionlist - Say Line 0'),
(2522000, 9, 2, 0, 0, 0, 100, 0, 6000, 7000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 25222, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Actionlist - Say Line 1'),
(2522000, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Actionlist - Change Equipment'),
(2522000, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Actionlist - Resume Waypoint'),
(2522000, 9, 5, 0, 0, 0, 100, 0, 4000, 5000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 25222, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Actionlist - Say Line 3');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2522001);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2522001, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 25222, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Actionlist - Say Line 0'),
(2522001, 9, 1, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Actionlist - Say Line 0'),
(2522001, 9, 2, 0, 0, 0, 100, 0, 6000, 7000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 25222, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Actionlist - Say Line 2'),
(2522001, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 0, 2178, 143, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Actionlist - Change Equipment'),
(2522001, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 53, 0, 2522001, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Actionlist - Start Waypoint'),
(2522001, 9, 5, 0, 0, 0, 100, 0, 4000, 5000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 25222, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Actionlist - Say Line 3');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
