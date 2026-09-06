-- DB update 2025_07_01_01 -> 2025_07_01_02

-- Korfax, Champion of the Light
DELETE FROM `creature_text` WHERE (`CreatureID` = 29176) AND (`GroupID` = 0);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(29176, 0, 0, '%s falls unconscious.', 41, 0, 100, 0, 0, 0, 29725, 0, '');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29176;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29176);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29176, 0, 0, 1, 2, 0, 100, 0, 0, 3, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korfax, Champion of the Light - Between 0-3% Health - Stop Combat'),
(29176, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korfax, Champion of the Light - Between 0-3% Health - Set Flags Immune To Players & Immune To NPC\'s & Not Selectable'),
(29176, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korfax, Champion of the Light - Between 0-3% Health - Set Flag Standstate Dead'),
(29176, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 65, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korfax, Champion of the Light - Between 0-3% Health - Set Emote State 65'),
(29176, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korfax, Champion of the Light - Between 0-3% Health - Say Line 0'),
(29176, 0, 5, 6, 72, 0, 100, 1, 2, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korfax, Champion of the Light - On Action 2 Done - Remove Flags Not Selectable (No Repeat)'),
(29176, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korfax, Champion of the Light - On Action 2 Done - Remove FlagStandstate Dead (No Repeat)'),
(29176, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korfax, Champion of the Light - On Action 2 Done - Set Emote State 0 (No Repeat)'),
(29176, 0, 8, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2285.7, -5303.2, 85.92, 1.59, 'Korfax, Champion of the Light - On Action 2 Done - Move To Position (No Repeat)'),
(29176, 0, 9, 10, 34, 0, 100, 513, 8, 2, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2285.7, -5303.2, 85.92, 1.59, 'Korfax, Champion of the Light - On Reached Point 2 - Set Orientation 1.59 (No Repeat)'),
(29176, 0, 10, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korfax, Champion of the Light - On Reached Point 2 - Set Flag Standstate Kneel (No Repeat)'),
(29176, 0, 11, 0, 0, 0, 100, 0, 10000, 20000, 10000, 10000, 0, 0, 11, 53631, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Korfax, Champion of the Light - In Combat - Cast \'Cleave\''),
(29176, 0, 12, 0, 0, 0, 100, 0, 10000, 20000, 10000, 10000, 0, 0, 11, 53625, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Korfax, Champion of the Light - In Combat - Cast \'Heroic Leap\''),
(29176, 0, 13, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korfax, Champion of the Light - On Respawn - Set Invincibility Hp 1%');

-- Commander Eligor Dawnbringer
DELETE FROM `creature_text` WHERE (`CreatureID` = 29177) AND (`GroupID` = 0);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(29177, 0, 0, '%s falls unconscious.', 41, 0, 100, 0, 0, 0, 29725, 0, '');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29177;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29177);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29177, 0, 0, 1, 2, 0, 100, 0, 0, 3, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Eligor Dawnbringer - Between 0-3% Health - Stop Combat'),
(29177, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Eligor Dawnbringer - Between 0-3% Health - Set Flags Immune To Players & Immune To NPC\'s & Not Selectable'),
(29177, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Eligor Dawnbringer - Between 0-3% Health - Set Flag Standstate Dead'),
(29177, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 65, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Eligor Dawnbringer - Between 0-3% Health - Set Emote State 65'),
(29177, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Eligor Dawnbringer - Between 0-3% Health - Say Line 0'),
(29177, 0, 5, 6, 72, 0, 100, 1, 2, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Eligor Dawnbringer - On Action 2 Done - Remove Flags Not Selectable (No Repeat)'),
(29177, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Eligor Dawnbringer - On Action 2 Done - Remove FlagStandstate Dead (No Repeat)'),
(29177, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Eligor Dawnbringer - On Action 2 Done - Set Emote State 0 (No Repeat)'),
(29177, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2276.13, -5312, 87.09, 1.47, 'Commander Eligor Dawnbringer - On Action 2 Done - Move To Position (No Repeat)'),
(29177, 0, 9, 0, 34, 0, 100, 513, 8, 2, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2276.13, -5312, 87.09, 1.47, 'Commander Eligor Dawnbringer - On Reached Point 2 - Set Orientation 1.47 (No Repeat)'),
(29177, 0, 10, 0, 74, 0, 100, 0, 0, 0, 5000, 10000, 20, 0, 11, 37979, 1, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Eligor Dawnbringer - On Friendly Below 20% Health - Cast \'Holy Light\''),
(29177, 0, 11, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Eligor Dawnbringer - On Respawn - Set Invincibility Hp 1%');

-- Lord Maxwell Tyrosus
DELETE FROM `creature_text` WHERE (`CreatureID` = 29178) AND (`GroupID` = 0);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(29178, 0, 0, '%s falls unconscious.', 41, 0, 100, 0, 0, 0, 29725, 0, '');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29178;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29178);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29178, 0, 0, 1, 2, 0, 100, 0, 0, 3, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Maxwell Tyrosus - Between 0-3% Health - Stop Combat'),
(29178, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Maxwell Tyrosus - Between 0-3% Health - Set Flags Immune To Players & Immune To NPC\'s & Not Selectable'),
(29178, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Maxwell Tyrosus - Between 0-3% Health - Set Flag Standstate Dead'),
(29178, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 65, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Maxwell Tyrosus - Between 0-3% Health - Set Emote State 65'),
(29178, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Maxwell Tyrosus - Between 0-3% Health - Say Line 0'),
(29178, 0, 5, 6, 72, 0, 100, 1, 2, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Maxwell Tyrosus - On Action 2 Done - Remove Flags Not Selectable (No Repeat)'),
(29178, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Maxwell Tyrosus - On Action 2 Done - Remove FlagStandstate Dead (No Repeat)'),
(29178, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Maxwell Tyrosus - On Action 2 Done - Set Emote State 0 (No Repeat)'),
(29178, 0, 8, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2276.3, -5305.75, 85.89, 1.54, 'Lord Maxwell Tyrosus - On Action 2 Done - Move To Position (No Repeat)'),
(29178, 0, 9, 10, 34, 0, 100, 513, 8, 2, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2276.3, -5305.75, 85.89, 1.54, 'Lord Maxwell Tyrosus - On Reached Point 2 - Set Orientation 1.54 (No Repeat)'),
(29178, 0, 10, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Maxwell Tyrosus - On Reached Point 2 - Set Flag Standstate Kneel (No Repeat)'),
(29178, 0, 11, 0, 11, 0, 100, 1, 0, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Maxwell Tyrosus - On Respawn - Say Line 7 (No Repeat)'),
(29178, 0, 12, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Maxwell Tyrosus - On Respawn - Set Invincibility Hp 1%');

-- Leonid Barthalomew the Revered
DELETE FROM `creature_text` WHERE (`CreatureID` = 29179) AND (`GroupID` = 0);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(29179, 0, 0, '%s falls unconscious.', 41, 0, 100, 0, 0, 0, 29725, 0, '');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29179;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29179);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29179, 0, 0, 1, 2, 0, 100, 0, 0, 3, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leonid Barthalomew the Revered - Between 0-3% Health - Stop Combat'),
(29179, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leonid Barthalomew the Revered - Between 0-3% Health - Set Flags Immune To Players & Immune To NPC\'s & Not Selectable'),
(29179, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leonid Barthalomew the Revered - Between 0-3% Health - Set Flag Standstate Dead'),
(29179, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 65, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leonid Barthalomew the Revered - Between 0-3% Health - Set Emote State 65'),
(29179, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leonid Barthalomew the Revered - Between 0-3% Health - Say Line 0'),
(29179, 0, 5, 6, 72, 0, 100, 1, 2, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leonid Barthalomew the Revered - On Action 2 Done - Remove Flags Not Selectable (No Repeat)'),
(29179, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leonid Barthalomew the Revered - On Action 2 Done - Remove FlagStandstate Dead (No Repeat)'),
(29179, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leonid Barthalomew the Revered - On Action 2 Done - Set Emote State 0 (No Repeat)'),
(29179, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2276.32, -5319.22, 88.55, 1.47, 'Leonid Barthalomew the Revered - On Action 2 Done - Move To Position (No Repeat)'),
(29179, 0, 9, 0, 34, 0, 100, 513, 8, 2, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2276.32, -5319.22, 88.55, 1.47, 'Leonid Barthalomew the Revered - On Reached Point 2 - Set Orientation 1.47 (No Repeat)'),
(29179, 0, 10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leonid Barthalomew the Revered - On Respawn - Set Invincibility Hp 1%');

-- Duke Nicholas Zverenhoff
DELETE FROM `creature_text` WHERE (`CreatureID` = 29180) AND (`GroupID` = 0);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(29180, 0, 0, '%s falls unconscious.', 41, 0, 100, 0, 0, 0, 29725, 0, '');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29180;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29180);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29180, 0, 0, 1, 2, 0, 100, 0, 0, 3, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Duke Nicholas Zverenhoff - Between 0-3% Health - Stop Combat'),
(29180, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Duke Nicholas Zverenhoff - Between 0-3% Health - Set Flags Immune To Players & Immune To NPC\'s & Not Selectable'),
(29180, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Duke Nicholas Zverenhoff - Between 0-3% Health - Set Flag Standstate Dead'),
(29180, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 65, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Duke Nicholas Zverenhoff - Between 0-3% Health - Set Emote State 65'),
(29180, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Duke Nicholas Zverenhoff - Between 0-3% Health - Say Line 0'),
(29180, 0, 5, 6, 72, 0, 100, 1, 2, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Duke Nicholas Zverenhoff - On Action 2 Done - Remove Flags Not Selectable (No Repeat)'),
(29180, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Duke Nicholas Zverenhoff - On Action 2 Done - Remove FlagStandstate Dead (No Repeat)'),
(29180, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Duke Nicholas Zverenhoff - On Action 2 Done - Set Emote State 0 (No Repeat)'),
(29180, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2285.49, -5312.6, 88.01, 1.5, 'Duke Nicholas Zverenhoff - On Action 2 Done - Move To Position (No Repeat)'),
(29180, 0, 9, 0, 34, 0, 100, 513, 8, 2, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2285.49, -5312.6, 88.01, 1.5, 'Duke Nicholas Zverenhoff - On Reached Point 2 - Set Orientation 1.5 (No Repeat)'),
(29180, 0, 10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Duke Nicholas Zverenhoff - On Respawn - Set Invincibility Hp 1%');

-- Rayne
DELETE FROM `creature_text` WHERE (`CreatureID` = 29181) AND (`GroupID` = 0);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(29181, 0, 0, '%s falls unconscious.', 41, 0, 100, 0, 0, 0, 29725, 0, '');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29181;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29181);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29181, 0, 0, 1, 2, 0, 100, 0, 0, 3, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rayne - Between 0-3% Health - Stop Combat'),
(29181, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rayne - Between 0-3% Health - Set Flags Immune To Players & Immune To NPC\'s & Not Selectable'),
(29181, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rayne - Between 0-3% Health - Set Flag Standstate Dead'),
(29181, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 65, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rayne - Between 0-3% Health - Set Emote State 65'),
(29181, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rayne - Between 0-3% Health - Say Line 0'),
(29181, 0, 5, 6, 72, 0, 100, 1, 2, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rayne - On Action 2 Done - Remove Flags Not Selectable (No Repeat)'),
(29181, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rayne - On Action 2 Done - Remove FlagStandstate Dead (No Repeat)'),
(29181, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rayne - On Action 2 Done - Set Emote State 0 (No Repeat)'),
(29181, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2272.7, -5315.06, 87.14, 1.31, 'Rayne - On Action 2 Done - Move To Position (No Repeat)'),
(29181, 0, 9, 0, 34, 0, 100, 513, 8, 2, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2272.7, -5315.06, 87.14, 1.31, 'Rayne - On Reached Point 2 - Set Orientation 1.31 (No Repeat)'),
(29181, 0, 10, 0, 0, 0, 100, 0, 10000, 20000, 10000, 20000, 0, 0, 11, 20687, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rayne - In Combat - Cast \'Starfall\''),
(29181, 0, 11, 0, 0, 0, 100, 0, 10000, 20000, 10000, 20000, 0, 0, 11, 21807, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rayne - In Combat - Cast \'Wrath\''),
(29181, 0, 12, 13, 74, 0, 100, 0, 0, 0, 5000, 10000, 20, 0, 11, 20664, 1, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 'Rayne - On Friendly Below 20% Health - Cast \'Rejuvenation\''),
(29181, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 25817, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rayne - On Friendly Below 0% Health - Cast \'Tranquility\''),
(29181, 0, 14, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rayne - On Respawn - Set Invincibility Hp 1%');

-- Rimblat Earthshatter
DELETE FROM `creature_text` WHERE (`CreatureID` = 29182) AND (`GroupID` = 0);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(29182, 0, 0, '%s falls unconscious.', 41, 0, 100, 0, 0, 0, 29725, 0, '');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29182;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29182);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29182, 0, 0, 1, 2, 0, 100, 0, 0, 3, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rimblat Earthshatter - Between 0-3% Health - Stop Combat'),
(29182, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rimblat Earthshatter - Between 0-3% Health - Set Flags Immune To Players & Immune To NPC\'s & Not Selectable'),
(29182, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rimblat Earthshatter - Between 0-3% Health - Set Flag Standstate Dead'),
(29182, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 65, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rimblat Earthshatter - Between 0-3% Health - Set Emote State 65'),
(29182, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rimblat Earthshatter - Between 0-3% Health - Say Line 0'),
(29182, 0, 5, 6, 72, 0, 100, 1, 2, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rimblat Earthshatter - On Action 2 Done - Remove Flags Not Selectable (No Repeat)'),
(29182, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rimblat Earthshatter - On Action 2 Done - Remove FlagStandstate Dead (No Repeat)'),
(29182, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rimblat Earthshatter - On Action 2 Done - Set Emote State 0 (No Repeat)'),
(29182, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2279.26, -5316.37, 88.27, 1.52, 'Rimblat Earthshatter - On Action 2 Done - Move To Position (No Repeat)'),
(29182, 0, 9, 0, 34, 0, 100, 513, 8, 2, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2279.26, -5316.37, 88.27, 1.52, 'Rimblat Earthshatter - On Reached Point 2 - Set Orientation 1.52 (No Repeat)'),
(29182, 0, 10, 0, 0, 0, 100, 0, 10000, 20000, 10000, 10000, 0, 0, 11, 53630, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rimblat Earthshatter - In Combat - Cast \'Thunder\''),
(29182, 0, 11, 0, 74, 0, 100, 0, 0, 0, 5000, 10000, 20, 0, 11, 33642, 1, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 'Rimblat Earthshatter - On Friendly Below 20% Health - Cast \'Chain Heal\''),
(29182, 0, 12, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rimblat Earthshatter - On Respawn - Set Invincibility Hp 1%');
