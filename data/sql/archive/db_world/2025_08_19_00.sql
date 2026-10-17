-- DB update 2025_08_18_01 -> 2025_08_19_00

-- Remove Unit Flags from Roanauk Icemist (IMMUNE_TO_PC, IMMUNE_TO_NPC)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~(256|512) WHERE (`entry` = 26654);

-- Remove Unit Flags from Icemist Warriors (IMMUNE_TO_PC, IMMUNE_TO_NPC, STUNNED)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~(256|512|262144) WHERE (`entry` = 26772);

-- Update SmartAI (Roanauk Icemist)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (26654, 26772));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26654);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26654, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - On Respawn - Set Flags Immune To Players & Immune To NPC\'s'),
(26654, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 26656, 10, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - On Respawn - Set Data 1 1'),
(26654, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - On Respawn - Set Event Phase 1'),
(26654, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 47273, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - On Respawn - Cast \'Icemist`s Prison\''),
(26654, 0, 4, 0, 1, 1, 100, 0, 5000, 30000, 120000, 150000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Out of Combat - Say Line 0 (Phase 1)'),
(26654, 0, 5, 0, 38, 0, 100, 513, 1, 1, 0, 0, 0, 0, 80, 2665400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - On Data Set 1 1 - Run Script (No Repeat)'),
(26654, 0, 6, 0, 40, 0, 100, 512, 1, 0, 0, 0, 0, 0, 80, 2665401, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - On Point 1 of Path Any Reached - Run Script'),
(26654, 0, 7, 0, 38, 0, 100, 512, 2, 2, 0, 0, 0, 0, 80, 2665402, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - On Data Set 2 2 - Run Script');

-- Update Action List (Roanauk Icemist)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2665400, 2665401));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2665400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 47273, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Remove Aura \'Icemist`s Prison\''),
(2665400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 9, 26656, 0, 200, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Set Data 2 2'),
(2665400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Set Event Phase 2'),
(2665400, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Say Line 1'),
(2665400, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 53, 0, 26654, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Start Waypoint Path 26654'),
(2665401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Say Line 2'),
(2665401, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Say Line 3'),
(2665401, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 26608, 100, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Say Line 1'),
(2665401, 9, 3, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 11, 47378, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Cast \'Glory of the Ancestors\''),
(2665401, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Say Line 4'),
(2665401, 9, 5, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(2665401, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 47379, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Cast \'Icemist`s Blessing\''),
(2665401, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Say Line 5'),
(2665401, 9, 8, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Say Line 6'),
(2665401, 9, 9, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 26608, 100, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Say Line 2'),
(2665401, 9, 10, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Say Line 7'),
(2665401, 9, 11, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 26608, 100, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Set Data 1 1'),
(2665401, 9, 12, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Set Home Position'),
(2665401, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 26608, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Actionlist - Start Attacking');

-- Update SmartAI (Icemist Warriors)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26772);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26772, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 29266, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Icemist Warrior - On Respawn - Cast \'Permanent Feign Death\''),
(26772, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 262912, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Icemist Warrior - On Respawn - Set Flags Immune To Players & Immune To NPC\'s & Stunned'),
(26772, 0, 2, 3, 8, 0, 100, 512, 47378, 0, 0, 0, 0, 0, 28, 29266, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Icemist Warrior - On Spellhit \'Glory of the Ancestors\' - Remove Aura \'Permanent Feign Death\''),
(26772, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2677200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Icemist Warrior - On Spellhit \'Glory of the Ancestors\' - Run Script'),
(26772, 0, 4, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Icemist Warrior - On Data Set 1 1 - Despawn In 5000 ms');

-- Add Action List (Icemist Warriors)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2677200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2677200, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 12, 26676, 6, 6000, 0, 0, 0, 202, 5, 1, 1, 0, 0, 0, 0, 0, 'Icemist Warrior - Actionlist - Summon Creature \'Anub\'ar Invader\''),
(2677200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 262912, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Icemist Warrior - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s & Stunned');

-- Set Conditions for Icemist's Blessing
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 47379;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,3,47379,0,0,31,0,3,26654,0,0,0,0,'','Icemist\'s Blessing (47379) - target is Roanauk Icemist'),
(13,3,47379,0,1,31,0,3,26772,0,0,0,0,'','Icemist\'s Blessing (47379) - target is Icemist Warrior'),
(13,3,47379,0,2,9,0,12069,0,0,0,0,0,'','Icemist\'s Blessing (47379) - player has quest 12069 active');
