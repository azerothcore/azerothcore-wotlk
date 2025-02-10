-- DB update 2025_02_10_00 -> 2025_02_10_01

-- Remove flag IMMUNE_TO_NPC. Add Flag PET_IN_COMBAT (Sniffed Values)
UPDATE `creature_template` SET `unit_flags`=`unit_flags`& ~512 WHERE (`entry` = 24938);
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|2048 WHERE (`entry` = 24938);

-- Change Temp movement
UPDATE `creature_template_movement` SET `Rooted` = `Rooted`|1 WHERE (`CreatureId` = 24938);

-- Dawnblade Hawkrider SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25063;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25063);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25063, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dawnblade Hawkrider - On Reset - Set Reactstate Passive'),
(25063, 0, 1, 0, 60, 0, 100, 0, 3000, 6500, 3000, 6500, 0, 0, 11, 45189, 2, 0, 1, 0, 0, 9, 24938, 5, 40, 0, 0, 0, 0, 0, 'Dawnblade Hawkrider - On Update - Cast \'Dawnblade Attack\'');

-- Shattered Sun Marksman SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24938;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24938);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24938, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 1000, 1000, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Out of Combat - Disable Combat Movement (No Repeat)'),
(24938, 0, 1, 0, 60, 0, 100, 0, 4500, 8000, 4500, 8000, 0, 0, 11, 74414, 0, 0, 1, 0, 0, 9, 25063, 0, 40, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Update - Cast \'Shoot\''),
(24938, 0, 2, 0, 10, 0, 100, 1, 0, 70, 4500, 8000, 0, 0, 11, 74414, 0, 0, 0, 0, 0, 9, 25192, 0, 50, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Within 0-70 Range Out of Combat LoS - Cast \'Shoot\' (No Repeat)'),
(24938, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493810, 2493813, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Random Script'),
(24938, 0, 4, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493820, 2493823, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Random Script'),
(24938, 0, 5, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493830, 2493833, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Random Script'),
(24938, 0, 6, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493840, 2493843, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Random Script');
