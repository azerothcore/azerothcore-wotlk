-- DB update 2019_08_11_00 -> 2019_08_15_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_08_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_08_11_00 2019_08_15_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1564613018254939406'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1564613018254939406');

-- Column Ornament
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29754;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 29754 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(29754,0,0,1,27,0,100,0,0,0,0,0,0,203,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Column Ornament - On Passenger Boarded - Exit Vehicle'),
(29754,0,1,0,61,0,100,0,0,0,0,0,0,75,50550,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Column Ornament - Linked - Add Aura ''Parachute''');

-- Gretta the Arbiter
DELETE FROM `smart_scripts` WHERE `entryorguid` = 29796 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(29796,0,0,1,19,0,100,0,12886,0,0,0,0,12,29679,3,600000,0,0,0,8,0,0,0,0,7090.47,-1765.8,821.052,0,'Gretta the Arbiter - On Accepted Quest ''The Drakkensryd'' - Summon ''Hyldsmeet Proto-Drake'''),
(29796,0,1,0,61,0,100,0,0,0,0,0,0,86,46598,2,7,0,0,0,19,29679,10,0,0,0,0,0,0,'Gretta the Arbiter - Linked - Cross Cast ''Ride Vehicle Hardcoded'' (Invoker - Hyldsmeet Proto-Drake)');

-- Hyldsmeet Proto-Drake
DELETE FROM `smart_scripts` WHERE `entryorguid` = 29679 AND `source_type` = 0 AND `id` = 2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(29679,0,2,0,28,0,100,0,0,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Hyldsmeet Proto-Drake - On Passenger Removed - Force Despawn After 2 Seconds');

DELETE FROM `waypoints` WHERE `entry` = 29679;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`)
VALUES
(29679,1,7071.2,-1772.26,827.542,'Hyldsmeet Proto-Drake'),
(29679,2,7042.99,-1757.14,842.747,'Hyldsmeet Proto-Drake'),
(29679,3,7018.42,-1727.55,873.987,'Hyldsmeet Proto-Drake'),
(29679,4,7004.25,-1677.93,923.391,'Hyldsmeet Proto-Drake'),
(29679,5,7042.87,-1581.54,943.848,'Hyldsmeet Proto-Drake'),
(29679,6,7089.01,-1513.21,999.059,'Hyldsmeet Proto-Drake'),
(29679,7,7187.18,-1359.52,1125.41,'Hyldsmeet Proto-Drake'),
(29679,8,7273.46,-1226.56,1235.73,'Hyldsmeet Proto-Drake'),
(29679,9,7366.43,-1041.68,1394.12,'Hyldsmeet Proto-Drake'),
(29679,10,7503.78,-855.742,1558.88,'Hyldsmeet Proto-Drake'),
(29679,11,7668.24,-639.42,1677.99,'Hyldsmeet Proto-Drake'),
(29679,12,7677.31,-568.353,1717.85,'Hyldsmeet Proto-Drake'),
(29679,13,7618.18,-499.276,1795.46,'Hyldsmeet Proto-Drake'),
(29679,14,7590.15,-466.137,1800.37,'Hyldsmeet Proto-Drake'),
(29679,15,7551.98,-425.286,1802.96,'Hyldsmeet Proto-Drake'),
(29679,16,7506.14,-389.719,1805.08,'Hyldsmeet Proto-Drake'),
(29679,17,7453.89,-372.881,1807.31,'Hyldsmeet Proto-Drake'),
(29679,18,7392.22,-386.513,1806.91,'Hyldsmeet Proto-Drake'),
(29679,19,7334.82,-420.561,1808.99,'Hyldsmeet Proto-Drake'),
(29679,20,7284.84,-468.004,1808.05,'Hyldsmeet Proto-Drake'),
(29679,21,7255.45,-522.765,1805.46,'Hyldsmeet Proto-Drake'),
(29679,22,7254.75,-577.764,1803.85,'Hyldsmeet Proto-Drake'),
(29679,23,7285.51,-642.46,1802.19,'Hyldsmeet Proto-Drake'),
(29679,24,7339.46,-674.759,1803.99,'Hyldsmeet Proto-Drake'),
(29679,25,7407.65,-688.525,1804.51,'Hyldsmeet Proto-Drake'),
(29679,26,7473.79,-680.05,1799.08,'Hyldsmeet Proto-Drake'),
(29679,27,7531.82,-653.494,1796.62,'Hyldsmeet Proto-Drake'),
(29679,28,7581.98,-608.632,1797.69,'Hyldsmeet Proto-Drake'),
(29679,29,7617.53,-549.32,1794.77,'Hyldsmeet Proto-Drake'),
(29679,30,7616.44,-500.8,1798.93,'Hyldsmeet Proto-Drake'),
(29679,31,7566.79,-450.701,1859.32,'Hyldsmeet Proto-Drake'),
(29679,32,7521.65,-413.662,1919.56,'Hyldsmeet Proto-Drake'),
(29679,33,7430.38,-404.684,1935.66,'Hyldsmeet Proto-Drake'),
(29679,34,7414.28,-471.557,1935.11,'Hyldsmeet Proto-Drake'),
(29679,35,7412.3,-532.338,1912.76,'Hyldsmeet Proto-Drake'),
(29679,36,7426.15,-556.076,1903.53,'Hyldsmeet Proto-Drake');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
