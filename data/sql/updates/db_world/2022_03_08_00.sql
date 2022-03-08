-- DB update 2022_03_07_04 -> 2022_03_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_07_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_07_04 2022_03_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646669713670945917'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646669713670945917');

-- fix start position slightly
DELETE FROM `creature` WHERE `guid`=37101;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(37101, 3695, 0, 0, 1, 0, 0, 1, 1, 0, 4773.25, 207.805, 50.987, 2.17813, 275, 0, 0, 273, 0, 0, 0, 0, 0, '', 0);

-- Add in missing waypoints
DELETE FROM `waypoints` WHERE `entry`=3695;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES 
(3695, 1, 4794.2827, 221.6492, 48.695915, 0, 0, 'Grimclaw'),
(3695, 2, 4865.442, 218.13693, 49.990364, 0, 0, 'Grimclaw'),
(3695, 3, 4928.499, 218.9626, 43.547977, 0, 0, 'Grimclaw'),
(3695, 4, 4963.0303, 214.23178, 40.75603, 0, 0, 'Grimclaw'),
(3695, 5, 4985.399, 213.64648, 38.63475, 0, 0, 'Grimclaw'),
(3695, 6, 5073.8076, 240.7489, 27.4628, 0, 0, 'Grimclaw'),
(3695, 7, 5140.132, 247.67764, 29.921043, 0, 0, 'Grimclaw'),
(3695, 8, 5194.3276, 249.19644, 34.322613, 0, 0, 'Grimclaw'),
(3695, 9, 5241.461, 246.278, 31.690386, 0, 0, 'Grimclaw'),
(3695, 10, 5288.1694, 250.07332, 28.250198, 0, 0, 'Grimclaw'),
(3695, 11, 5321.149, 263.38617, 27.515112, 0, 0, 'Grimclaw'),
(3695, 12, 5321.149, 263.38617, 27.515112, 0, 0, 'Grimclaw'),
(3695, 13, 5345.3745, 279.31253, 26.82741, 0, 0, 'Grimclaw'),
(3695, 14, 5381.865, 285.21475, 27.594788, 0, 0, 'Grimclaw'),
(3695, 15, 5418.403, 283.04355, 31.069038, 0, 0, 'Grimclaw'),
(3695, 16, 5460.8667, 279.2674, 30.627277, 0, 0, 'Grimclaw'),
(3695, 17, 5527.946, 310.3122, 27.840548, 0, 0, 'Grimclaw'),
(3695, 18, 5582.47, 320.0467, 26.304102, 0, 0, 'Grimclaw'),
(3695, 19, 5669.0366, 316.40652, 18.525936, 0, 0, 'Grimclaw'), 
(3695, 20, 5735.4277, 310.2411, 20.505152, 0, 0, 'Grimclaw'),
(3695, 21, 5771.039, 285.43924, 20.657175, 0, 0, 'Grimclaw'), 
(3695, 22, 5815.3247, 281.89014, 24.36706, 0, 0, 'Grimclaw'),
(3695, 23, 5939.1567, 231.44012, 23.4428, 0, 0, 'Grimclaw'),
(3695, 24, 5974.223, 230.7148, 20.319902, 0, 0, 'Grimclaw'),
(3695, 25, 6065.7734, 272.71457, 21.286674, 0, 0, 'Grimclaw'),
(3695, 26, 6123.43, 274.8901, 19.853626, 0, 0, 'Grimclaw'),
(3695, 27, 6147.806, 283.58685, 24.209549, 0, 0, 'Grimclaw'),
(3695, 28, 6191.0933, 317.5763, 27.337402, 0, 0, 'Grimclaw'),
(3695, 29, 6301.5044, 316.65002, 23.03243, 0, 0, 'Grimclaw'),
(3695, 30, 6319.3794, 323.68317, 25.119139, 0, 0, 'Grimclaw'),
(3695, 31, 6352.5625, 354.42517, 22.381474, 0, 0, 'Grimclaw'),
(3695, 32, 6398.345, 363.20105, 17.399408, 0, 0, 'Grimclaw'),
(3695, 33, 6409.01, 381.597, 13.7997, 0, 0, 'Grimclaw'),
(3695, 34, 6422.38, 398.542, 11.1623, 0, 0, 'Grimclaw'),
(3695, 35, 6429.16, 395.692, 11.6041, 0, 0, 'Grimclaw'),
(3695, 36, 6437.87, 372.912, 13.9415, 0, 0, 'Grimclaw'),
(3695, 37, 6436.29, 366.529, 13.9415, 0, 0, 'Grimclaw'),
(3695, 38, 6437.87, 372.912, 13.9415, 0, 0, 'Grimclaw'),
(3695, 39, 6429.16, 395.692, 11.6041, 0, 0, 'Grimclaw'),
(3695, 40, 6422.38, 398.542, 11.1623, 0, 0, 'Grimclaw'),
(3695, 41, 6409.01, 381.597, 13.7997, 0, 0, 'Grimclaw');

-- adjust smart scripts with new waypoints
DELETE FROM `smart_scripts` WHERE `entryorguid`=3695;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(3695, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 3695, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Respawn - Start Waypoint'),
(3695, 0, 1, 0, 40, 0, 100, 0, 33, 3695, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On WP 33 Reached (Path 3695) - Talk 0 (Terenthis)'),
(3695, 0, 2, 0, 40, 0, 100, 0, 37, 3695, 0, 0, 0, 80, 369500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On WP 37 Reached (Path 3695) - Run Actionlist'),
(3695, 0, 3, 0, 40, 0, 100, 0, 41, 3695, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On WP 41 Reached (Path 3695) - Despawn'),
(3695, 0, 4, 0, 22, 0, 100, 0, 101, 50000, 50000, 0, 0, 80, 369501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - Received Emote 101 - Run Actionlist'),
(3695, 0, 5, 0, 40, 0, 100, 0, 35, 369500, 0, 0, 0, 80, 369502, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On WP 35 Reached (Path 369500) - Run Actionlist');

-- adjust actionlist with orientation and waypoints
DELETE FROM `smart_scripts` WHERE `entryorguid`=369500;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(369500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 40000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Pause Waypoint for 40 seconds'),
(369500, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.41001, "Grimclaw - Set Orientation"),
(369500, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 0'),
(369500, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 1 (Terenthis)'),
(369500, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 1'),
(369500, 9, 5, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 2 (Terenthis)'),
(369500, 9, 6, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 3 (Terenthis)'),
(369500, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 86, 6238, 0, 19, 3693, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Cross Cast \'Speak with Animals\''),
(369500, 9, 8, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 4 (Terenthis)'),
(369500, 9, 9, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 2'),
(369500, 9, 10, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 5 (Terenthis)'),
(369500, 9, 11, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 3'),
(369500, 9, 12, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 6 (Terenthis)'),
(369500, 9, 13, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 82, 3, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Add Questgiver+Gossip npcflag (Terenthis)');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_08_00' WHERE sql_rev = '1646669713670945917';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
