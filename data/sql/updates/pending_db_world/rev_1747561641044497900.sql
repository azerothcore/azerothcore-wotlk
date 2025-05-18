-- Warp Storm (21322)
DELETE FROM `creature_template_addon` WHERE (`entry` = 21322);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(21322, 0, 0, 0, 0, 0, 0, '36581');
UPDATE `creature_template` SET `AIName` = '', `unit_flags` = `unit_flags`&~(128|256) WHERE `entry` = 21322;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (20516,21322) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18865 AND `id` = 4);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18865, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 204, 21322, 0, 0, 0, 0, 0, 0, 0, 'Warp Aberration - On Just Died - Despawn \'Warp Storm\' In 1000 ms'),
(20516, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 36577, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warp Monstrosity - On Aggro - Cast \'Warp Storm\''),
(20516, 0, 1, 0, 0, 0, 100, 0, 1700, 2300, 6800, 8100, 0, 0, 11, 13901, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warp Monstrosity - In Combat - Cast \'Arcane Bolt\''),
(20516, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 204, 21322, 0, 0, 0, 0, 0, 0, 0, 'Warp Monstrosity - On Just Died - Despawn \'Warp Storm\' In 1000 ms');
