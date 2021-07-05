-- INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624454393059603100');

SET @SERGEANT_BLY_ENTRY = 7604;
SET @SERGEANT_BLY_ALIST = 760400;
SET @SERGEANT_BLY_GOSSIP_MENU = 941;

SET @SOURCE_TYPE_CREATURE = 0;
SET @CONDITION_UNIT_DATA = 103;

-- Update sanfury executioner's orientation
UPDATE `creature` SET `orientation` = 4.780020 WHERE `guid` = 81552;

-- New Condition Unit has Data set, used to display his gossip menu option when he's ready to be fought.
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 941);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 941, 1, 0, 0, 103, 1, 3, 3, 0, 0, 0, 0, '', 'Checking if Sergeant Bly has field 3 and data 3');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = @SERGEANT_BLY_GOSSIP_MENU) AND (`SourceEntry` = 1515);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, @SERGEANT_BLY_GOSSIP_MENU, 1515, 0, 0, @CONDITION_UNIT_DATA, 1, 0, 0, 0, 0, 0, 0, '', 'Show Text if GetData(0) == 0');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = @SERGEANT_BLY_GOSSIP_MENU) AND (`SourceEntry` = 1516);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, @SERGEANT_BLY_GOSSIP_MENU, 1516, 0, 0, @CONDITION_UNIT_DATA, 1, 1, 1, 0, 0, 0, 0, '', 'Show Text if GetData(0) == 1');

-- Regenerate HP for Creatures
UPDATE `creature_template` SET `RegenHealth` = 1 WHERE `entry` IN (7604, 7605, 7606, 7607, 7608);

-- SERGEANT BLY SMARTAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7604;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 7604);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7604, 0, 0, 13, 38, 0, 100, 257, 1, 1, 0, 0, 0, 80, 760400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Data Set 1 1 - Run Script (No Repeat)'),
(7604, 0, 1, 2, 34, 0, 100, 257, 8, 1, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Reached Point 1 - Set Home Position (No Repeat)'),
(7604, 0, 3, 0, 0, 0, 100, 0, 3000, 10000, 9000, 15000, 0, 11, 12170, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - In Combat - Cast \'Revenge\''),
(7604, 0, 4, 0, 11, 0, 100, 0, 8, 1, 0, 0, 0, 11, 3637, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Respawn - Cast \'Improved Blocking III\''),
(7604, 0, 5, 0, 0, 0, 100, 0, 3000, 10000, 17000, 27000, 0, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - In Combat - Cast \'Shield Bash\''),
(7604, 0, 6, 0, 77, 0, 100, 257, 1, 2, 0, 0, 0, 80, 760402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Missing comment for event_type 77 - Run Script (No Repeat)'),
(7604, 0, 7, 8, 62, 0, 100, 257, 941, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Gossip Option 0 Selected - Close Gossip (No Repeat)'),
(7604, 0, 8, 9, 61, 0, 100, 0, 941, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Gossip Option 0 Selected - Set Orientation Invoker (No Repeat)'),
(7604, 0, 9, 0, 61, 0, 100, 0, 941, 0, 0, 0, 0, 80, 760403, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Gossip Option 0 Selected - Run Script (No Repeat)'),
(7604, 0, 10, 0, 34, 0, 100, 257, 8, 2, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Reached Point 2 - Set Home Position (No Repeat)'),
(7604, 0, 11, 12, 34, 0, 100, 257, 8, 3, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Reached Point 3 - Set Home Position (No Repeat)'),
(7604, 0, 12, 0, 61, 0, 100, 0, 8, 3, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Reached Point 3 - Set Data 3 3 (No Repeat)'),
(7604, 0, 13, 14, 61, 0, 100, 0, 1, 1, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 9000000, 200, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Data Set 1 1 - Set Data 1 1 (No Repeat)'),
(7604, 0, 14, 15, 61, 0, 100, 0, 1, 1, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Data Set 1 1 - Set Npc Flags Gossip (No Repeat)'),
(7604, 0, 15, 0, 61, 0, 100, 0, 1, 1, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Data Set 1 1 - Set Npc Flags Gossip (No Repeat)'),
(7604, 0, 18, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 80, 760401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Data Set 2 2 - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 760400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(760400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Active'),
(760400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 19, 7605, 20, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Store Target'),
(760400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 19, 7606, 20, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Store Target'),
(760400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 3, 0, 0, 0, 0, 0, 19, 7607, 20, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Store Target'),
(760400, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 4, 0, 0, 0, 0, 0, 19, 7608, 20, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Store Target'),
(760400, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Walk'),
(760400, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Walk'),
(760400, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Walk'),
(760400, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Walk'),
(760400, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Walk'),
(760400, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction'),
(760400, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction'),
(760400, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction'),
(760400, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction'),
(760400, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction'),
(760400, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1886.79, 1263.61, 41.4898, 4.725, 'Sergeant Bly - Script9 - Move Point'),
(760400, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 1891.25, 1264.55, 41.4012, 4.725, 'Sergeant Bly - Script9 - Move Point'),
(760400, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 1882.37, 1270.97, 41.8417, 4.725, 'Sergeant Bly - Script9 - Move Point'),
(760400, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 1882.46, 1263.74, 41.605, 4.725, 'Sergeant Bly - Script9 - Move Point'),
(760400, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 1886.64, 1271.05, 41.693, 4.68968, 'Sergeant Bly - Script9 - Move Point'),
(760400, 9, 20, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 34, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Instance Data 0 to 1'),
(760400, 9, 21, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag'),
(760400, 9, 22, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 760401);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(760401, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1887.92, 1228.18, 9.98, 0, 'Sergeant Bly - Script9 - Move Point'),
(760401, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 1883.68, 1227.95, 9.543, 0, 'Sergeant Bly - Script9 - Move Point'),
(760401, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 1897.23, 1228.34, 9.43, 0, 'Sergeant Bly - Script9 - Move Point'),
(760401, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 1878.02, 1227.65, 9.485, 0, 'Sergeant Bly - Script9 - Move Point'),
(760401, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 1891.57, 1228.68, 9.69, 0, 'Sergeant Bly - Script9 - Move Point'),
(760401, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Say Line 2'),
(760401, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1887.92, 1228.18, 9.98, 4.68, 'Sergeant Bly - Script9 - Set Home Pos'),
(760401, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data'),
(760401, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data'),
(760401, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data'),
(760401, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data'),
(760401, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag'),
(760401, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 760402);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(760402, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 69, 3, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1883.82, 1200.83, 8.87, 0, 'Sergeant Bly - Script9 - Move Point'),
(760402, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 1874.11, 1206.17, 8.87, 0, 'Sergeant Bly - Script9 - Move Point'),
(760402, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 1894.5, 1204.4, 8.87, 0, 'Sergeant Bly - Script9 - Move Point'),
(760402, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 1877.52, 1199.63, 8.87, 0, 'Sergeant Bly - Script9 - Move Point'),
(760402, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 1891.83, 1201.45, 8.87, 0, 'Sergeant Bly - Script9 - Move Point'),
(760402, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1883.82, 1200.83, 8.87, 4.68, 'Sergeant Bly - Script9 - Set Home Pos'),
(760402, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data'),
(760402, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data'),
(760402, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data'),
(760402, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data'),
(760402, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 34, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Instance Data 0 to 3'),
(760402, 9, 11, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag'),
(760402, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 760403);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(760403, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag'),
(760403, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag'),
(760403, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction'),
(760403, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Run'),
(760403, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data'),
(760403, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Say Line 0'),
(760403, 9, 6, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Say Line 1'),
(760403, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction'),
(760403, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction'),
(760403, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction'),
(760403, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = @SERGEANT_BLY_ALIST+1) AND (`source_type` = 9) AND (`id` IN (3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@SERGEANT_BLY_ALIST+1, 9, 3, 0, 0, 0, 100, 0, 60000, 60000, 0, 0, 0, 107, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Summon Creature Group'),
(@SERGEANT_BLY_ALIST+1, 9, 4, 0, 0, 0, 100, 0, 90000, 90000, 0, 0, 0, 107, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Summon Creature Group');

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = @SERGEANT_BLY_GOSSIP_MENU);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(@SERGEANT_BLY_GOSSIP_MENU, 1, 0, "That\'s it!  I\'m tired of helping you out.  It\'s time we settled things on the battlefield!", 4165, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = @SERGEANT_BLY_ALIST+2) AND (`source_type` = 9) AND (`id` IN (11));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@SERGEANT_BLY_ALIST+2, 9, 11, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Sergeant Bly - Script9 - Set NPC Flag");

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (7789, 7787, 8876, 7788, 8877);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7789) AND (`source_type` = 0) AND (`id` IN (0, 1, 3, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7789, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 1200000, 1200000, 0, 11, 20798, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Cretin - In Combat - Cast \'Demon Skin\''),
(7789, 0, 1, 0, 0, 0, 100, 0, 0, 8000, 12000, 20000, 0, 11, 14032, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Cretin - In Combat - Cast \'Shadow Word: Pain\''),
(7789, 0, 2, 0, 54, 0, 100, 257, 0, 90000, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Cretin - On Just Summoned - Start Random Movement (No Repeat)'),
(7789, 0, 3, 0, 1, 0, 100, 0, 2000, 8000, 10000, 12000, 0, 5, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Cretin - Out of Combat - Play Emote 4');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8876) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 5, 6, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8876, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Acolyte - In Combat - Cast \'Shadow Bolt\''),
(8876, 0, 1, 0, 0, 0, 100, 0, 4000, 11000, 13000, 24000, 0, 11, 11981, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 0, 'Sandfury Acolyte - In Combat - Cast \'Mana Burn\''),
(8876, 0, 2, 0, 0, 0, 100, 0, 0, 8000, 12000, 20000, 0, 11, 11639, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Acolyte - In Combat - Cast \'Shadow Word: Pain\''),
(8876, 0, 3, 0, 0, 0, 100, 0, 0, 22000, 32000, 50000, 0, 11, 11980, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Acolyte - In Combat - Cast \'Curse of Weakness\''),
(8876, 0, 4, 0, 54, 0, 100, 257, 0, 90000, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Acolyte - On Just Summoned - Start Random Movement (No Repeat)'),
(8876, 0, 5, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Acolyte - Between 0-15% Health - Flee For Assist (No Repeat)'),
(8876, 0, 6, 0, 1, 0, 100, 0, 2000, 8000, 12000, 14000, 0, 5, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Acolyte - Out of Combat - Play Emote 4');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7788) AND (`source_type` = 0) AND (`id` IN (1, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7788, 0, 1, 0, 54, 0, 100, 257, 0, 90000, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Drudge - On Just Summoned - Start Random Movement (No Repeat)'),
(7788, 0, 0, 0, 1, 0, 100, 0, 2000, 8000, 10000, 14000, 0, 5, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Drudge - Out of Combat - Play Emote 4');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8877) AND (`source_type` = 0) AND (`id` IN (0, 1, 3, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8877, 0, 0, 1, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Zealot - Between 0-30% Health - Cast \'Enrage\' (No Repeat)'),
(8877, 0, 1, 0, 61, 0, 100, 0, 0, 30, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Zealot - Between 0-30% Health - Say Line 0 (No Repeat)'),
(8877, 0, 3, 0, 54, 0, 100, 257, 0, 90000, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Zealot - On Just Summoned - Start Random Movement (No Repeat)'),
(8877, 0, 2, 0, 1, 0, 100, 0, 2000, 6000, 10000, 12000, 0, 5, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Zealot - Out of Combat - Play Emote 4');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 760401) AND (`source_type` = 9) AND (`id` IN (3, 4, 18));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 760401) AND (`source_type` = 9) AND (`id` IN (0, 1, 2));

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7787) AND (`source_type` = 0) AND (`id` IN (1, 0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7787, 0, 1, 0, 54, 0, 100, 257, 0, 90000, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Slave - On Just Summoned - Start Random Movement (No Repeat)'),
(7787, 0, 0, 0, 1, 0, 100, 0, 2000, 8000, 12000, 15000, 0, 5, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Slave - Out of Combat - Play Emote 4');

-- Altering Waypoints table to group them and a new SmartAI Action for Random Waypoint Group:
-- allows for several pathing options for mobs, like for example Zul'farrak's mobs on Pyramid event
ALTER TABLE `waypoints`	ADD COLUMN `wp_group` MEDIUMINT(7) UNSIGNED NOT NULL DEFAULT '0' AFTER `pointid`;
ALTER TABLE `waypoints`
DROP PRIMARY KEY,
ADD PRIMARY KEY (`entry`, `pointid`, `wp_group`) USING BTREE;

DELETE FROM `waypoints` WHERE `entry` IN (7789, 7787, 8876, 7788, 8877);
INSERT INTO `waypoints` (`entry`, `pointid`, `wp_group`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(7789, 0, 1, 1900.05, 1228.05, 9.22243, NULL),
(7789, 1, 1, 1897.53, 1241.17, 20.4998, NULL),
(7789, 2, 1, 1892.34, 1259.13, 38.3703, NULL),
(7789, 0, 2, 1876.97, 1227.56, 9.59821, NULL),
(7789, 1, 2, 1879.39, 1243.26, 23.0368, NULL),
(7789, 0, 4, 1879.39, 1243.26, 23.0368, NULL),
(7789, 2, 2, 1882.09, 1258.41, 38.0934, NULL),
(7789, 1, 4, 1882.09, 1258.41, 38.0934, NULL),
(7789, 0, 3, 1897.53, 1241.17, 20.4998, NULL),
(7789, 1, 3, 1879.39, 1243.26, 23.0368, NULL),
(7787, 0, 1, 1900.05, 1228.05, 9.22243, NULL),
(7787, 1, 1, 1897.53, 1241.17, 20.4998, NULL),
(7787, 2, 1, 1892.34, 1259.13, 38.3703, NULL),
(7787, 0, 2, 1876.97, 1227.56, 9.59821, NULL),
(7787, 1, 2, 1879.39, 1243.26, 23.0368, NULL),
(7787, 0, 4, 1879.39, 1243.26, 23.0368, NULL),
(7787, 2, 2, 1882.09, 1258.41, 38.0934, NULL),
(7787, 1, 4, 1882.09, 1258.41, 38.0934, NULL),
(7787, 0, 3, 1897.53, 1241.17, 20.4998, NULL),
(7787, 1, 3, 1879.39, 1243.26, 23.0368, NULL),
(8876, 0, 1, 1900.05, 1228.05, 9.22243, NULL),
(8876, 1, 1, 1897.53, 1241.17, 20.4998, NULL),
(8876, 2, 1, 1892.34, 1259.13, 38.3703, NULL),
(8876, 0, 2, 1876.97, 1227.56, 9.59821, NULL),
(8876, 1, 2, 1879.39, 1243.26, 23.0368, NULL),
(8876, 0, 4, 1879.39, 1243.26, 23.0368, NULL),
(8876, 2, 2, 1882.09, 1258.41, 38.0934, NULL),
(8876, 1, 4, 1882.09, 1258.41, 38.0934, NULL),
(8876, 0, 3, 1897.53, 1241.17, 20.4998, NULL),
(8876, 1, 3, 1879.39, 1243.26, 23.0368, NULL),
(7788, 0, 1, 1900.05, 1228.05, 9.22243, NULL),
(7788, 1, 1, 1897.53, 1241.17, 20.4998, NULL),
(7788, 2, 1, 1892.34, 1259.13, 38.3703, NULL),
(7788, 0, 2, 1876.97, 1227.56, 9.59821, NULL),
(7788, 1, 2, 1879.39, 1243.26, 23.0368, NULL),
(7788, 0, 4, 1879.39, 1243.26, 23.0368, NULL),
(7788, 2, 2, 1882.09, 1258.41, 38.0934, NULL),
(7788, 1, 4, 1882.09, 1258.41, 38.0934, NULL),
(7788, 0, 3, 1897.53, 1241.17, 20.4998, NULL),
(7788, 1, 3, 1879.39, 1243.26, 23.0368, NULL),
(8877, 0, 1, 1900.05, 1228.05, 9.22243, NULL),
(8877, 1, 1, 1897.53, 1241.17, 20.4998, NULL),
(8877, 2, 1, 1892.34, 1259.13, 38.3703, NULL),
(8877, 0, 2, 1876.97, 1227.56, 9.59821, NULL),
(8877, 1, 2, 1879.39, 1243.26, 23.0368, NULL),
(8877, 0, 4, 1879.39, 1243.26, 23.0368, NULL),
(8877, 2, 2, 1882.09, 1258.41, 38.0934, NULL),
(8877, 1, 4, 1882.09, 1258.41, 38.0934, NULL),
(8877, 0, 3, 1897.53, 1241.17, 20.4998, NULL),
(8877, 1, 3, 1879.39, 1243.26, 23.0368, NULL);

-- Goblin SmartAI adjustments
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7607;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 7607);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7607, 0, 0, 0, 0, 0, 100, 0, 6000, 11000, 13000, 25000, 0, 11, 8858, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - In Combat - Cast \'Bomb\''),
(7607, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - In Combat - Cast \'Shoot\''),
(7607, 0, 2, 0, 0, 0, 100, 0, 6000, 20000, 23000, 45000, 0, 11, 21688, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - In Combat - Cast \'Goblin Land Mine\''),
(7607, 0, 3, 0, 34, 0, 100, 1, 8, 1, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Reached Point 1 - Set Home Position (No Repeat)'),
(7607, 0, 4, 5, 62, 0, 100, 257, 940, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Gossip Option 0 Selected - Set Npc Flag  (No Repeat)'),
(7607, 0, 5, 7, 61, 0, 100, 257, 940, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Gossip Option 0 Selected - Say Line 1 (No Repeat)'),
(7607, 0, 6, 7, 38, 0, 100, 257, 1, 2, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Data Set 1 2 - Set Npc Flag  (No Repeat)'),
(7607, 0, 7, 19, 61, 0, 100, 257, 940, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1858.57, 1146.35, 14.745, 0, 'Weegli Blastfuse - On Gossip Option 0 Selected - Move To Position (No Repeat)'),
(7607, 0, 8, 0, 34, 0, 100, 257, 8, 2, 0, 0, 0, 67, 1, 2000, 2000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Reached Point 2 - Create Timed Event (No Repeat)'),
(7607, 0, 9, 10, 59, 0, 100, 257, 1, 0, 0, 0, 0, 11, 10772, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Timed Event 1 Triggered - Cast \'Plant explosives\' (No Repeat)'),
(7607, 0, 10, 11, 61, 0, 100, 0, 1, 0, 0, 0, 0, 69, 3, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1871.18, 1100, 8.88, 0, 'Weegli Blastfuse - On Timed Event 1 Triggered - Move To Position (No Repeat)'),
(7607, 0, 11, 12, 61, 0, 100, 0, 1, 0, 0, 0, 0, 41, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Timed Event 1 Triggered - Despawn In 8000 ms (No Repeat)'),
(7607, 0, 12, 0, 61, 0, 100, 0, 1, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Timed Event 1 Triggered - Say Line 2 (No Repeat)'),
(7607, 0, 13, 0, 38, 0, 100, 0, 1, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1878.02, 1227.65, 9.485, 4.68, 'Weegli Blastfuse - On Data Set 1 0 - Set Home Position'),
(7607, 0, 14, 0, 38, 0, 100, 0, 2, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1877.52, 1199.63, 8.87, 4.68, 'Weegli Blastfuse - On Data Set 2 0 - Set Home Position'),
(7607, 0, 15, 16, 34, 0, 100, 0, 8, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Reached Point 1 - Say Line 0'),
(7607, 0, 16, 0, 61, 0, 100, 0, 8, 1, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Reached Point 1 - Set Event Phase 1'),
(7607, 0, 17, 18, 60, 1, 100, 0, 3000, 3000, 0, 0, 0, 69, 4, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1890.6, 1270.56, 41.5341, 4.7211, 'Weegli Blastfuse - On Update - Move To Position (Phase 1)'),
(7607, 0, 18, 0, 61, 1, 100, 0, 3000, 3000, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Update - Set Event Phase 0 (Phase 1)'),
(7607, 0, 19, 0, 61, 0, 100, 0, 940, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Gossip Option 0 Selected - Set Reactstate Passive (No Repeat)'),
(7607, 0, 20, 0, 34, 1, 100, 0, 8, 4, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1891.25, 1264.55, 41.4012, 4.725, 'Weegli Blastfuse - On Reached Point 4 - Set Orientation 4.725 (Phase 1)');

-- Using a helper to spawn the creatures and make them climb up.
DELETE FROM `creature_template` WHERE (`entry` = 9000000);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(9000000, 0, 0, 0, 0, 0, 123, 0, 0, 0, 'pyramid_trigger', "zul\'farrak", '', 0, 1, 1, 0, 31, 0, 1, 1.14286, 1, 0, 0, 1, 0, 0, 0, 0, 0, 33686402, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 1, 1, 1, 0, 0, 1, 0, 0, 128, '', 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9000000;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 9000000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9000000, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'pyramid_trigger - On Data Set 1 1 - Summon Creature Group 0'),
(9000000, 0, 1, 0, 61, 0, 100, 0, 1, 1, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'pyramid_trigger - On Data Set 1 1 - Set Event Phase 1'),
(9000000, 0, 2, 0, 38, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'pyramid_trigger - On Data Set 0 0 - Set Event Phase 0'),
(9000000, 0, 3, 0, 60, 1, 100, 0, 35000, 40000, 30000, 35000, 0, 107, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Summon Creature Group 1 (Phase 1)'),
(9000000, 0, 4, 0, 60, 1, 100, 0, 40000, 50000, 30000, 35000, 0, 107, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Summon Creature Group 2 (Phase 1)'),
(9000000, 0, 5, 0, 60, 1, 100, 0, 60000, 70000, 25000, 25000, 0, 107, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Summon Creature Group 3 (Phase 1)'),
(9000000, 0, 6, 0, 60, 1, 100, 0, 80000, 90000, 25000, 25000, 0, 107, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Summon Creature Group 4 (Phase 1)'),
(9000000, 0, 7, 0, 60, 1, 100, 0, 180000, 190000, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Set Event Phase 2 (Phase 1)'),
(9000000, 0, 8, 0, 60, 1, 100, 0, 18000, 23000, 12000, 15000, 0, 223, 1, 2, 1, 0, 0, 0, 11, 7789, 100, 1, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Missing comment for action_type 223'),
(9000000, 0, 9, 0, 60, 1, 100, 0, 18000, 25000, 10000, 15000, 0, 223, 1, 2, 1, 0, 0, 0, 11, 7787, 100, 1, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Missing comment for action_type 223'),
(9000000, 0, 10, 0, 60, 1, 100, 0, 18000, 23000, 10000, 15000, 0, 223, 1, 2, 1, 0, 0, 0, 11, 8876, 100, 1, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Missing comment for action_type 223'),
(9000000, 0, 11, 0, 60, 1, 100, 0, 18000, 23000, 10000, 14000, 0, 223, 1, 2, 1, 0, 0, 0, 11, 7788, 100, 1, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Missing comment for action_type 223'),
(9000000, 0, 12, 0, 60, 1, 100, 0, 18000, 23000, 10000, 15000, 0, 223, 1, 2, 1, 0, 0, 0, 11, 8877, 100, 1, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Missing comment for action_type 223'),
(9000000, 0, 13, 0, 60, 2, 100, 0, 240000, 240000, 0, 0, 0, 107, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Summon Creature Group 5 (Phase 2)'),
(9000000, 0, 14, 0, 60, 2, 100, 0, 300000, 300000, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 9, 7604, 0, 100, 1, 0, 0, 0, 0, 'pyramid_trigger - On Update - Set Data 2 2 (Phase 2)'),
(9000000, 0, 15, 0, 60, 2, 100, 0, 18000, 23000, 12000, 15000, 0, 223, 1, 2, 1, 0, 0, 0, 11, 7789, 100, 1, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Missing comment for action_type 223'),
(9000000, 0, 16, 0, 60, 2, 100, 0, 18000, 25000, 10000, 15000, 0, 223, 1, 2, 1, 0, 0, 0, 11, 7787, 100, 1, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Missing comment for action_type 223'),
(9000000, 0, 17, 0, 60, 2, 100, 0, 18000, 23000, 10000, 15000, 0, 223, 1, 2, 1, 0, 0, 0, 11, 8876, 100, 1, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Missing comment for action_type 223'),
(9000000, 0, 18, 0, 60, 2, 100, 0, 18000, 23000, 10000, 14000, 0, 223, 1, 2, 1, 0, 0, 0, 11, 7788, 100, 1, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Missing comment for action_type 223'),
(9000000, 0, 19, 0, 60, 2, 100, 0, 18000, 23000, 10000, 15000, 0, 223, 1, 2, 1, 0, 0, 0, 11, 8877, 100, 1, 0, 0, 0, 0, 0, 'pyramid_trigger - On Update - Missing comment for action_type 223');

DELETE FROM `creature` WHERE (`id` = 9000000) AND (`guid` IN (3110360));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(3110360, 9000000, 209, 1176, 1176, 1, 1, 6428, 0, 1886.099487, 1208.106567, 8.877301, 1.461719, 120, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `creature_summon_groups` WHERE (`summonerId` = 9000000);
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`) VALUES 
(9000000, 0, 1, 8877, 1899.63, 1202.52, 8.87, 0, 8, 0),
(9000000, 0, 1, 8876, 1877.4, 1216.41, 8.87, 0, 8, 0),
(9000000, 0, 1, 8877, 1873.63, 1204.65, 8.87, 0, 8, 0),
(9000000, 0, 1, 8877, 1877, 1207.27, 8.87, 0, 8, 0),
(9000000, 0, 1, 7788, 1883.74, 1212.35, 8.87, 0, 8, 0),
(9000000, 0, 1, 7788, 1878.57, 1214.16, 8.87, 0, 8, 0),
(9000000, 0, 1, 7788, 1893.07, 1215.26, 8.87, 0, 8, 0),
(9000000, 0, 1, 8876, 1889.82, 1222.51, 8.87, 0, 8, 0),
(9000000, 0, 1, 7787, 1886.93, 1221.4, 8.87, 0, 8, 0),
(9000000, 0, 1, 7787, 1883.5, 1218.25, 8.87, 0, 8, 0),
(9000000, 0, 1, 7787, 1894.72, 1221.91, 8.87, 0, 8, 0),
(9000000, 0, 1, 7787, 1886.97, 1225.86, 8.87, 0, 8, 0),
(9000000, 0, 1, 8877, 1896.46, 1205.62, 8.87, 0, 8, 0),
(9000000, 0, 1, 7787, 1882.07, 1225.7, 8.87, 0, 8, 0),
(9000000, 0, 1, 8876, 1898.23, 1217.97, 8.87, 0, 8, 0),
(9000000, 0, 1, 7789, 1874.45, 1204.44, 8.87, 0, 8, 0),
(9000000, 0, 1, 7787, 1879.02, 1223.06, 8.87, 0, 8, 0),
(9000000, 0, 1, 7788, 1889.94, 1212.21, 8.87, 0, 8, 0),
(9000000, 0, 1, 7787, 1892.28, 1225.49, 8.87, 0, 8, 0),
(9000000, 0, 1, 7789, 1874.18, 1221.24, 8.87, 0, 8, 0),
(9000000, 0, 1, 8876, 1883.76, 1222.3, 8.87, 0, 8, 0),
(9000000, 0, 1, 7787, 1890.08, 1218.68, 8.87, 0, 8, 0),
(9000000, 0, 1, 7789, 1894.64, 1206.29, 8.87, 0, 8, 0),
(9000000, 0, 2, 8877, 1899.63, 1202.52, 8.87, 0, 8, 0),
(9000000, 0, 2, 7788, 1889.94, 1212.21, 8.87, 0, 8, 0),
(9000000, 0, 3, 7788, 1894.72, 1221.91, 8.87, 0, 8, 0),
(9000000, 0, 3, 7788, 1878.57, 1214.16, 8.87, 0, 8, 0),
(9000000, 0, 4, 8876, 1898.23, 1217.97, 8.87, 0, 8, 0),
(9000000, 0, 4, 7787, 1879.02, 1223.06, 8.87, 0, 8, 0),
(9000000, 0, 5, 7789, 1889.505737, 1200.001953, 8.877799, 1.497047, 8, 0),
(9000000, 0, 5, 7787, 1891.132324, 1199.881836, 8.877799, 1.497047, 8, 0),
(9000000, 0, 5, 7787, 1893.121948, 1199.734863, 8.877799, 1.497047, 8, 0),
(9000000, 0, 5, 8876, 1878.447754, 1200.869629, 8.877799, 1.352534, 8, 0),
(9000000, 0, 5, 7787, 1875.824341, 1200.869629, 8.877799, 1.352534, 8, 0),
(9000000, 0, 5, 8876, 1873.574951, 1200.869629, 8.877799, 1.352534, 8, 0),
(9000000, 0, 5, 7796, 1883, 1199.64, 8.88, 0, 8, 0),
(9000000, 0, 5, 7275, 1885.4, 1199.52, 8.88, 1.54, 8, 0);
