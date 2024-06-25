-- DB update 2024_06_25_08 -> 2024_06_25_09
-- Soulbind
DELETE FROM `spell_scripts` WHERE `id`=36153;
INSERT INTO `spell_scripts` (`id`, `effIndex`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(36153, 0, 0, 15, 36141, 3, 0, 0, 0, 0, 0);

-- Transformed from Tormented Soul & Tormented Citizen
DELETE FROM `creature` WHERE `id1`=20480;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (20480,20512));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20512, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2051200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tormented Soul - On Aggro - Run Script'),
(20512, 0, 1, 0, 0, 0, 100, 0, 7000, 12000, 0, 0, 0, 0, 11, 36153, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tormented Soul - In Combat - Cast \'Soulbind\''),
(20512, 0, 2, 3, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 36, 20512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tormented Soul - On Reset - Update Template To \'Tormented Soul\''),
(20512, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tormented Soul - On Reset - Set Reactstate Aggressive');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` - 2051200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2051200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tormented Soul - Actionlist - Set Reactstate Passive'),
(2051200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tormented Soul - Actionlist - Stop Attack'),
(2051200, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tormented Soul - Actionlist - Set Rooted On'),
(2051200, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tormented Soul - Actionlist - Play Emote 15'),
(2051200, 9, 4, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 0, 36, 20480, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tormented Soul - Actionlist - Update Template To \'Kirin\'Var Ghost\''),
(2051200, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tormented Soul - Actionlist - Set Reactstate Aggressive'),
(2051200, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tormented Soul - Actionlist - Set Rooted Off');
