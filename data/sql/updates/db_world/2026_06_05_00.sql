-- DB update 2026_06_02_03 -> 2026_06_05_00

-- Update SAI (Lured Colossus)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20599;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20599);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20599, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 20, 0, 0, 0, 0, 0, 10, 68868, 19294, 0, 0, 0, 0, 0, 0, 'Lured Colossus - On Just Died - Do Action ID 20');

-- Update SAI (Tola'thion)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19293;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19293);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19293, 0, 0, 1, 19, 0, 100, 0, 10349, 0, 0, 0, 0, 0, 64, 12, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Tola\'thion - On Quest \'The Earthbinder\' Taken - Store Targetlist'),
(19293, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 12, 0, 0, 0, 0, 0, 10, 68868, 19294, 0, 0, 0, 0, 0, 0, 'Tola\'thion - On Quest \'The Earthbinder\' Taken - Send Target 12'),
(19293, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 19, 0, 0, 0, 0, 0, 10, 68868, 19294, 0, 0, 0, 0, 0, 0, 'Tola\'thion - On Quest \'The Earthbinder\' Taken - Do Action ID 19');

-- Update SAI (Earthbinder Galandria Nightbreeze)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19294;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19294);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19294, 0, 0, 0, 72, 0, 100, 0, 19, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 12, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Action 19 Done - Say Line 0'),
(19294, 0, 1, 0, 20, 0, 100, 0, 10349, 0, 0, 0, 0, 0, 80, 1929400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Quest \'The Earthbinder\' Finished - Run Script'),
(19294, 0, 2, 0, 34, 0, 100, 0, 8, 12, 0, 0, 0, 0, 80, 1929402, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Reached Point 12 - Run Script'),
(19294, 0, 3, 0, 72, 0, 100, 0, 20, 0, 0, 0, 0, 0, 80, 1929401, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Action 20 Done - Run Script'),
(19294, 0, 4, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Respawn - Set Npc Flags Gossip & Questgiver');

-- Set Action Lists (Earthbinder Galandria Nightbreeze)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (1929400, 1929401, 1929402));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1929400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - Actionlist - Set Active On'),
(1929400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - Actionlist - Set Run Off'),
(1929400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - Actionlist - Set Npc Flag '),
(1929400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - Actionlist - Close Gossip'),
(1929400, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - Actionlist - Set Orientation Closest Player'),
(1929400, 9, 5, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - Actionlist - Say Line 1'),
(1929400, 9, 6, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 69, 12, 0, 1, 0, 0, 0, 8, 0, 0, 0, 0, -286.767, 4729.43, 18.4418, 1.72788, 'Earthbinder Galandria Nightbreeze - Actionlist - Move To Position'),
(1929401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -294.766, 4715.08, 28.1862, 0.20944, 'Earthbinder Galandria Nightbreeze - Actionlist - Move To Position'),
(1929401, 9, 1, 0, 0, 0, 100, 0, 13000, 13000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0.20944, 'Earthbinder Galandria Nightbreeze - Actionlist - Set Orientation Home Position'),
(1929401, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - Actionlist - Set Npc Flags Gossip & Questgiver'),
(1929401, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - Actionlist - Set Active Off'),
(1929402, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 5, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - Actionlist - Play Emote 16'),
(1929402, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - Actionlist - Play Emote 0'),
(1929402, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 50, 184450, 60, 0, 0, 0, 0, 8, 0, 0, 0, 0, -287.019, 4731.63, 18.217, 2.58308, 'Earthbinder Galandria Nightbreeze - Actionlist - Summon Gameobject \'Crimson Crystal Shard\''),
(1929402, 9, 3, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - Actionlist - Say Line 2'),
(1929402, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 20599, 4, 10000, 0, 1, 0, 8, 0, 0, 0, 0, -288.19, 4733.63, 18.2982, 5.044, 'Earthbinder Galandria Nightbreeze - Actionlist - Summon Creature \'Lured Colossus\'');
