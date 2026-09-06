-- DB update 2025_07_27_02 -> 2025_07_29_00
--
DELETE FROM `creature_template_addon` WHERE `entry` IN (31461, 31462);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(31461, 0, 0, 0, 0, 0, 0, '31690 56740'),
(31462, 0, 0, 0, 0, 0, 0, '31690 56741');

UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~2&~33554432, `flags_extra` = `flags_extra` &~128, `ScriptName` = '' WHERE `entry` IN (30435, 30391, 31461, 31462);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30435;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30435);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30435, 0, 0, 0, 60, 0, 100, 1, 1000, 1000, 0, 0, 0, 0, 11, 57059, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - On Update - Cast \'Serverside - Grow\' (No Repeat)'),
(30435, 0, 1, 0, 26, 0, 100, 1, 0, 3, 0, 0, 1, 0, 223, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - In Combat LoS - Do Action ID 1 (No Repeat)'),
(30435, 0, 2, 3, 2, 0, 100, 0, 0, 5, 0, 0, 0, 0, 11, 31691, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - Between 0-5% Health - Cast \'Serverside - Shrink\''),
(30435, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 4000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - Between 0-5% Health - Despawn In 4000 ms'),
(30435, 0, 4, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - On Respawn - Set Reactstate Passive'),
(30435, 0, 5, 0, 32, 0, 100, 1, 1, 150, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - On Damaged Between 1-150 - Do Action ID 1 (No Repeat)'),
(30435, 0, 6, 0, 72, 0, 100, 1, 1, 0, 0, 0, 0, 0, 80, 3043500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - On Action 1 Done - Run Script (No Repeat)'),
(30435, 0, 7, 0, 101, 0, 100, 0, 1, 0, 4000, 4000, 4000, 0, 28, 56648, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - On 1 or More Players in Range - Remove Aura \'Potent Fungus\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3043500) AND (`source_type` = 9) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3043500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 57061, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - Actionlist - Cast \'Poison Cloud\''),
(3043500, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 31691, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - Actionlist - Cast \'Serverside - Shrink\''),
(3043500, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 3000, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - Actionlist - Despawn In 3000 ms');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30391;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30391);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30391, 0, 0, 0, 60, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 57059, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Healthy Mushroom - On Update - Cast \'Serverside - Grow\''),
(30391, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Healthy Mushroom - On Respawn - Set Reactstate Passive'),
(30391, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 56648, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Healthy Mushroom - On Just Died - Cast \'Potent Fungus\''),
(30391, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 31691, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Healthy Mushroom - On Just Died - Cast \'Serverside - Shrink\'');
