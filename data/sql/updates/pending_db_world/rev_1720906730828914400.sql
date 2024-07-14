-- Darkscreecher Akkarai
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2316100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2316100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(2316100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 24240, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - Actionlist - Cast \'Spawn - Red Lightning\''),
(2316100, 9, 2, 0, 0, 0, 100, 0, 4500, 4500, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - Actionlist - Say Line 0'),
(2316100, 9, 3, 0, 0, 0, 100, 0, 5500, 5500, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - Actionlist - Set Event Phase 1'),
(2316100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2316101);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2316101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40427, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - Actionlist - Cast \'Flock Call\''),
(2316101, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - Actionlist - Set Event Phase 2'),
(2316101, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - Actionlist - Say Line 1'),
(2316101, 9, 3, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 0, 12, 23206, 4, 30000, 0, 0, 0, 202, 20, 6, 1, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - Actionlist - Summon Creature \'Akkarai Hatchling\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23161);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23161, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2316100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - On Respawn - Run Script'),
(23161, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - On Reset - Set Event Phase 1'),
(23161, 0, 2, 0, 0, 1, 100, 0, 8000, 12000, 8000, 12000, 0, 0, 11, 40429, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - In Combat - Cast \'Frostbolt\' (Phase 1)'),
(23161, 0, 3, 0, 0, 2, 100, 0, 2000, 6000, 2000, 6000, 0, 0, 11, 40430, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - In Combat - Cast \'Frostbolt\' (Phase 2)'),
(23161, 0, 4, 0, 0, 0, 100, 0, 10000, 10000, 15000, 20000, 0, 0, 11, 40428, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - In Combat - Cast \'Shadow Bolt Volley\''),
(23161, 0, 5, 0, 2, 0, 100, 0, 0, 30, 5000, 10000, 0, 0, 11, 15730, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - Between 0-30% Health - Cast \'Curse of Mending\''),
(23161, 0, 6, 0, 0, 0, 100, 0, 15000, 20000, 15000, 20000, 0, 0, 11, 13341, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - In Combat - Cast \'Fire Blast\''),
(23161, 0, 7, 0, 0, 0, 100, 1, 14000, 20000, 0, 0, 0, 0, 80, 2316101, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - In Combat - Run Script (No Repeat)');

DELETE FROM `creature_text` WHERE (`CreatureID` = 23161);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23161, 0, 0, 'Hear the voices below the earth! They call for your blood!', 12, 0, 100, 0, 0, 0, 21904, 0, 'Darkscreecher Akkarai'),
(23161, 1, 0, 'Consume $n, my children!', 14, 0, 100, 0, 0, 0, 21076, 0, 'Darkscreecher Akkarai');

DELETE FROM `creature_template_addon` WHERE (`entry` = 23206);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(23206, 0, 0, 0, 0, 0, 0, '37816');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23206;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23206);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23206, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 1, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Akkarai Hatchling - On Just Summoned - Move To Invoker');

-- Vakkiz the Windrager
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23162);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23162, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2316100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vakkiz the Windrager - On Respawn - Run Script'),
(23162, 0, 1, 2, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 23162, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vakkiz the Windrager - On Reached Home - Morph To Creature Vakkiz the Windrager'),
(23162, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vakkiz the Windrager - On Reached Home - Set Event Phase 1'),
(23162, 0, 3, 0, 0, 1, 100, 0, 6500, 9500, 8500, 11500, 0, 0, 11, 40420, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vakkiz the Windrager - In Combat - Cast \'Lightning Breath\' (Phase 1)'),
(23162, 0, 4, 5, 2, 0, 100, 1, 0, 40, 0, 0, 0, 0, 3, 23204, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vakkiz the Windrager - Between 0-40% Health - Morph To Creature Vakkiz the Windrager (No Repeat)'),
(23162, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vakkiz the Windrager - Between 0-40% Health - Set Event Phase 2 (No Repeat)'),
(23162, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vakkiz the Windrager - Between 0-40% Health - Say Line 1 (No Repeat)'),
(23162, 0, 7, 0, 0, 2, 100, 0, 3000, 7000, 4000, 7000, 0, 0, 11, 40419, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vakkiz the Windrager - In Combat - Cast \'Bone Spray\' (Phase 2)');

-- Karrog
UPDATE `creature_template` SET `unit_flags` = 33555200 WHERE (`entry` = 23205);

DELETE FROM `creature_text` WHERE (`CreatureID` = 23165);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23165, 0, 0, 'You capture Karrog! Karrog smash you!', 12, 0, 100, 0, 0, 0, 21903, 0, 'Karrog'),
(23165, 1, 0, '%s fixates on $n.', 41, 0, 100, 0, 0, 0, 21074, 0, 'Karrog');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2316501);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2316501, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 5, 0, 1, 0, 0, 0, 0, 0, 0, 'Karrog - Actionlist - Store Targetlist'),
(2316501, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 14, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karrog - Actionlist - Remove All Threat'),
(2316501, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40416, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Karrog - Actionlist - Cast \'Fixated Rage\''),
(2316501, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Karrog - Actionlist - Say Line 1'),
(2316501, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karrog - Actionlist - Set Event Phase 2'),
(2316501, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 123, 10000, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gezzarak the Huntress - Actionlist - Modify Threat'),
(2316501, 9, 6, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karrog - Actionlist - Set Event Phase 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23165);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23165, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2316100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karrog - On Respawn - Run Script'),
(23165, 0, 1, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karrog - On Reached Home - Set Event Phase 1'),
(23165, 0, 2, 0, 0, 1, 100, 0, 8000, 16000, 8000, 40000, 0, 0, 11, 40488, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karrog - In Combat - Cast \'Trample\' (Phase 1)'),
(23165, 0, 3, 0, 0, 1, 100, 0, 22000, 22000, 22000, 22000, 0, 0, 80, 2316501, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karrog - In Combat - Run Script (Phase 1)'),
(23165, 0, 4, 5, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 23205, 4, 10000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karrog - On Just Died - Summon Creature \'Karrog Shardling\''),
(23165, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 23205, 4, 10000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karrog - On Just Died - Summon Creature \'Karrog Shardling\''),
(23165, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 23205, 4, 10000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karrog - On Just Died - Summon Creature \'Karrog Shardling\'');

-- Gezzarak the Huntress
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2316301);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2316301, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 5, 0, 1, 0, 0, 0, 0, 0, 0, 'Gezzarak the Huntress - Actionlist - Store Targetlist'),
(2316301, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gezzarak the Huntress - Actionlist - Set Event Phase 2'),
(2316301, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gezzarak the Huntress - Actionlist - Say Line 1'),
(2316301, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 14, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gezzarak the Huntress - Actionlist - Remove All Threat'),
(2316301, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 123, 1000, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gezzarak the Huntress - Actionlist - Modify Threat'),
(2316301, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40432, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gezzarak the Huntress - Actionlist - Cast \'Warp\''),
(2316301, 9, 6, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 11, 40433, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gezzarak the Huntress - Actionlist - Cast \'Warp Rift\''),
(2316301, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gezzarak the Huntress - Actionlist - Set Event Phase 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23163);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23163, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2316100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gezzarak the Huntress - On Respawn - Run Script'),
(23163, 0, 1, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gezzarak the Huntress - On Reached Home - Set Event Phase 1'),
(23163, 0, 2, 0, 0, 1, 100, 0, 1000, 1000, 15000, 21000, 0, 0, 11, 40542, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gezzarak the Huntress - In Combat - Cast \'Warped Armor\' (Phase 1)'),
(23163, 0, 3, 4, 0, 1, 100, 0, 4000, 7000, 17500, 20000, 0, 0, 11, 40434, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gezzarak the Huntress - In Combat - Cast \'Knock Away\' (Phase 1)'),
(23163, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 13, 0, 25, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gezzarak the Huntress - In Combat - Set Single Threat -25% (Phase 1)'),
(23163, 0, 5, 0, 0, 1, 100, 0, 16000, 19000, 22000, 25000, 0, 0, 80, 2316301, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gezzarak the Huntress - In Combat - Run Script (Phase 1)');
