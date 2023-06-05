-- permanent aura
DELETE FROM `creature_template_addon` WHERE `entry` = 16491;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES (16491, 0, 0, 0, 1, 0, 0, '10095');
-- SAI
DELETE FROM `smart_scripts` WHERE `entryorguid` = 16491 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16491, 0, 0, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 11, 39804, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mana Feeder - On Reset - Cast Damage Immunity: Magic'),
(16491, 0, 1, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 11, 29908, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mana Feeder - In Combat - Cast \'Astral Bite\''),
(16491, 0, 2, 0, 0, 0, 100, 512, 2000, 2000, 2000, 2000, 0, 14, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mana Feeder - In Combat - Drop Threat On All'),
(16491, 0, 3, 0, 0, 0, 100, 512, 2500, 2500, 2000, 2000, 0, 13, 100, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Mana Feeder - In Combat - Add Threat to Random Target');
