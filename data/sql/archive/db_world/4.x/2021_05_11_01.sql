-- DB update 2021_05_11_00 -> 2021_05_11_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_11_00 2021_05_11_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1618834215629926428'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618834215629926428');

-- Dusty rug SAI:
SET @DUSTY_RUG_ENTRY := 1728;
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = @DUSTY_RUG_ENTRY;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = @DUSTY_RUG_ENTRY);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@DUSTY_RUG_ENTRY, 1, 0, 0, 20, 0, 100, 0, 524, 0, 0, 0, 0, 50, 1729, 40, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0.437117, -942.794, 61.9384, -2.54818, 'Dusty Rug - On Quest \'Elixir of Agony\' Finished - Summon Gameobject \'Tainted Keg\'');


-- Tainted keg SAI:
SET @TAINTED_KEG_ENTRY := 1729;
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = @TAINTED_KEG_ENTRY;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = @TAINTED_KEG_ENTRY);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@TAINTED_KEG_ENTRY, 1, 0, 1, 63, 0, 100, 0, 0, 0, 0, 0, 0, 67, 1, 12000, 12000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tainted Keg - On Just Created - Create Timed Event'),
(@TAINTED_KEG_ENTRY, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 15892, 0, 0, 0, 0, 0, 0, 0, 'Tainted Keg - On Just Created - Set Data 1 1'),
(@TAINTED_KEG_ENTRY, 1, 2, 3, 61, 0, 100, 0, 1, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 10, 15893, 0, 0, 0, 0, 0, 0, 0, 'Tainted Keg - On Just Created - Set Data 1 2'),
(@TAINTED_KEG_ENTRY, 1, 3, 0, 61, 0, 100, 0, 2, 0, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 10, 15891, 0, 0, 0, 0, 0, 0, 0, 'Tainted Keg - On Just Created - Set Data 1 3'),
(@TAINTED_KEG_ENTRY, 1, 4, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 50, 1730, 25, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0.437117, -942.794, 62.93, -2.54818, 'Tainted Keg - On Timed Event 1 Triggered - Summon Gameobject \'Tainted Keg Smoke\'');


-- Delete Tainted keg spawn location:
DELETE FROM `gameobject` WHERE `id` = @TAINTED_KEG_ENTRY;


-- Tainted keg smoke SAI:
SET @TAINTED_KEG_SMOKE_ENTRY := 1730;
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = @TAINTED_KEG_SMOKE_ENTRY;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = @TAINTED_KEG_SMOKE_ENTRY);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@TAINTED_KEG_SMOKE_ENTRY, 1, 0, 1, 63, 0, 100, 0, 0, 0, 0, 0, 0, 67, 1, 7000, 7000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tainted Keg Smoke - On Just Created - Create Timed Event'),
(@TAINTED_KEG_SMOKE_ENTRY, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 67, 2, 4000, 4000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tainted Keg Smoke - On Just Created - Create Timed Event'),
(@TAINTED_KEG_SMOKE_ENTRY, 1, 2, 0, 61, 0, 100, 0, 1, 0, 0, 0, 0, 67, 3, 2000, 2000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tainted Keg Smoke - On Just Created - Create Timed Event'),
(@TAINTED_KEG_SMOKE_ENTRY, 1, 3, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 10, 15892, 0, 0, 0, 0, 0, 0, 0, 'Tainted Keg Smoke - On Timed Event 1 Triggered - Kill Target'),
(@TAINTED_KEG_SMOKE_ENTRY, 1, 4, 0, 59, 0, 100, 0, 2, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 10, 15893, 0, 0, 0, 0, 0, 0, 0, 'Tainted Keg Smoke - On Timed Event 2 Triggered - Kill Target'),
(@TAINTED_KEG_SMOKE_ENTRY, 1, 5, 0, 59, 0, 100, 0, 3, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 10, 15891, 0, 0, 0, 0, 0, 0, 0, 'Tainted Keg Smoke - On Timed Event 3 Triggered - Kill Target');


-- Captured Farmer waypoints:
DELETE FROM `waypoints` WHERE `entry` IN (1589100, 1589200, 1589300);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`) VALUES
(1589100, 1, 0.350253, -946.004, 61.9387),
(1589100, 2, 2.42399, -942.742, 61.9396),
(1589200, 1, -7.60962, -943.344, 61.9371),
(1589200, 2, -1.75652, -941.321, 61.9381),
(1589300, 1, 0.299552, -938.505, 61.935),
(1589300, 2, 0.826452, -941.134, 61.9409);


-- Captured Farmer SAI:
SET @CAPTURED_FARMER_ENTRY := 2284;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @CAPTURED_FARMER_ENTRY;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @CAPTURED_FARMER_ENTRY);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@CAPTURED_FARMER_ENTRY, 0, 0, 0, 38, 0, 100, 1, 1, 1, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Farmer - On Data Set 1 1 - Create Timed Event (No Repeat)'),
(@CAPTURED_FARMER_ENTRY, 0, 1, 2, 59, 0, 100, 0, 1, 0, 0, 0, 0, 53, 0, 1589200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Farmer - On Timed Event 1 Triggered - Start Waypoint'),
(@CAPTURED_FARMER_ENTRY, 0, 2, 0, 61, 0, 100, 0, 1, 0, 0, 0, 0, 1, 0, 4000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Farmer - On Timed Event 1 Triggered - Say Line 0'),
(@CAPTURED_FARMER_ENTRY, 0, 3, 0, 40, 0, 100, 0, 2, 1589200, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 5.62476, 'Captured Farmer - On Waypoint 2 Reached - Set Orientation 5.62476'),
(@CAPTURED_FARMER_ENTRY, 0, 4, 5, 38, 0, 100, 1, 1, 2, 0, 0, 0, 53, 0, 1589300, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Farmer - On Data Set 1 2 - Start Waypoint (No Repeat)'),
(@CAPTURED_FARMER_ENTRY, 0, 5, 0, 61, 0, 100, 1, 4, 0, 0, 0, 0, 67, 2, 7000, 7000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Farmer - On Data Set 1 2 - Create Timed Event (No Repeat)'),
(@CAPTURED_FARMER_ENTRY, 0, 6, 0, 40, 0, 100, 0, 2, 1589300, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.63309, 'Captured Farmer - On Waypoint 2 Reached - Set Orientation 4.63309'),
(@CAPTURED_FARMER_ENTRY, 0, 7, 0, 59, 0, 100, 0, 2, 0, 0, 0, 0, 1, 1, 4000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Farmer - On Timed Event 2 Triggered - Say Line 1'),
(@CAPTURED_FARMER_ENTRY, 0, 8, 0, 38, 0, 100, 1, 1, 3, 0, 0, 0, 53, 0, 1589100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Farmer - On Data Set 1 3 - Start Waypoint (No Repeat)'),
(@CAPTURED_FARMER_ENTRY, 0, 9, 0, 40, 0, 100, 0, 2, 1589100, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.82591, 'Captured Farmer - On Waypoint 2 Reached - Set Orientation 2.82591');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
