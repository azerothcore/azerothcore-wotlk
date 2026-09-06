-- DB update 2025_07_24_01 -> 2025_07_24_02
-- Add Creature Text (Emery Neill)
DELETE FROM `creature_text` WHERE (`CreatureID` = 30570);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30570, 0, 0, 'The Stone Crow\'s closed today, sorry. There are too many health concerns, and I\'m not about to have Ed under fire for supposedly making people sick.', 12, 0, 100, 1, 0, 0, 31724, 0, ''),
(30570, 0, 1, 'I hate to disappoint people, but the Stone Crow\'s closed. If the kids from the orphanage were evacuated, I don\'t see why we should be open, either.', 12, 0, 100, 1, 0, 0, 31729, 0, '');

-- Add Trigger SmartAI (Emery Neill)
DELETE FROM `areatrigger_scripts` WHERE `entry` = 5251;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (5251, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE (`source_type` = 2 AND `entryorguid` = 5251);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5251, 2, 0, 0, 46, 0, 100, 0, 5251, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 1970931, 30570, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Set Data 0 1');

-- Add SmartAI (Emery Neill)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30570;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30570);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30570, 0, 0, 0, 38, 0, 100, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Emery Neill - On Data Set 0 1 - Say Line 0 (No Repeat)');

-- Add Creature Text (Leeka Turner)
DELETE FROM `creature_text` WHERE (`CreatureID` = 31027);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(31027, 0, 0, 'I hope you\'re not coming in here fixing for a fight. There are too many angry people on the streets today.', 12, 0, 100, 1, 0, 0, 31720, 0, ''),
(31027, 0, 1, 'I don\'t know how much longer I\'ll be open today with all the commotion outside. If you need something repaired, I\'ll take a quick look.', 12, 0, 100, 1, 0, 0, 31722, 0, ''),
(31027, 0, 2, 'Look, I\'ll sell you shields today, but no maces. The last thing I want is for some innocent to get brained by one of my weapons.', 12, 0, 100, 1, 0, 0, 31721, 0, '');

-- Set Trigger SmartAI (Leeka Turner)
DELETE FROM `areatrigger_scripts` WHERE `entry` = 5250;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (5250, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE (`source_type` = 2 AND `entryorguid` = 5250);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5250, 2, 0, 0, 46, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 1970874, 31027, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Set Data 0 1');

-- Set SmartAI (Leeka Turner)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31027;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31027);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31027, 0, 0, 0, 38, 0, 100, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leeka Turner - On Data Set 0 1 - Say Line 0 (No Repeat)');

-- Set Creature Text (Sophie Aaren)
DELETE FROM `creature_text` WHERE (`CreatureID` = 31021);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(31021, 0, 0, 'Is something going on? I hear angry voices.', 12, 0, 100, 1, 0, 0, 31731, 0, ''),
(31021, 0, 1, 'What\'s the commotion outside?', 12, 0, 100, 1, 0, 0, 31730, 0, ''),
(31021, 0, 3, 'Everything\'s been so strange lately...', 12, 0, 100, 1, 0, 0, 31732, 0, '');

-- Set Trigger SmartAI (Sophie Aaren)
DELETE FROM `areatrigger_scripts` WHERE `entry` = 5252;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (5252, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE (`source_type` = 2 AND `entryorguid` = 5252);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5252, 2, 0, 0, 46, 0, 100, 0, 5252, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 1970869, 31021, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Set Data 0 1');

-- Set SmartAI (Sophie Aaren)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31021;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31021);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31021, 0, 0, 0, 38, 0, 100, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sophie Aaren - On Data Set 0 1 - Say Line 0 (No Repeat)');

-- Add Waypoint (Magistrate Barthilas)
DELETE FROM `waypoint_data` WHERE `id` IN (3099400);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
("3099400", 1, 2418.5806, 1097.5596, 147.28342, NULL, 0, 0, 0, 100, 0),
("3099400", 2, 2415.1028, 1113.2949, 147.29402, NULL, 0, 0, 0, 100, 0);

-- Add Creature Text (Magistrate Barthilas)
DELETE FROM `creature_text` WHERE (`CreatureID` = 30994);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30994, 0, 0, 'How can I possibly help the city in such a widespread crisis?', 12, 0, 100, 1, 0, 0, 31581, 0, ''),
(30994, 0, 1, 'Everyone is falling ill - this is an epidemic!', 12, 0, 100, 1, 0, 0, 31582, 0, ''),
(30994, 0, 2, 'No remedy seems to work - the entire city has sickened...', 12, 0, 100, 1, 0, 0, 31583, 0, ''),
(30994, 0, 3, 'The soldiers are spreading panic with the rumors of bad food. Neighbors are accusing one another of poison. The city will fall into bedlam!', 12, 0, 100, 1, 0, 0, 31584, 0, ''),
(30994, 0, 4, 'I\'m at a loss. What can one simple man do in the face of disaster?', 12, 0, 100, 1, 0, 0, 31586, 0, ''),
(30994, 0, 5, 'I pray the illness I\'m feeling is due to stress ulcers...', 12, 0, 100, 1, 0, 0, 31587, 0, '');

-- Add SmartAI (Magistrate Barthilas)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30994;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30994);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30994, 0, 0, 0, 1, 0, 100, 0, 20000, 70000, 20000, 70000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - Out of Combat - Say Line 0'),
(30994, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 3099400, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On Reset - Start Path 3099400');
