-- DB update 2023_03_15_09 -> 2023_03_15_10
-- Improve Respawn Script
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2102700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2102700, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 60, 0, 30, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Disable Gravity'),
(2102700, 9, 1, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Set Faction 35'),
(2102700, 9, 2, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Remove Npc Flags Questgiver'),
(2102700, 9, 3, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Set Reactstate Passive'),
(2102700, 9, 4, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 11, 35921, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Cast \'Water Bubble\''),
(2102700, 9, 5, 0, 0, 0, 100, 512, 1200, 1200, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 21041, 0, 40, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Set Data 1 1');

UPDATE `smart_scripts` SET `event_flags`=512, `action_param2`=2, `action_param3`=1 WHERE (`entryorguid` = 21027) AND (`source_type` = 0) AND (`id` IN (0));

-- Increase Visibility Range of Triggers
DELETE FROM `creature_template_addon` WHERE (`entry` = 21041);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(21041, 0, 0, 0, 0, 0, 3, '');

-- Handle Quest Credit and Despawn on Actionlist
UPDATE `smart_scripts` SET `action_param4`=0, `action_param5`=0 WHERE (`entryorguid` = 2102704) AND (`source_type` = 9) AND (`id` IN (1));

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2102705) AND (`source_type` = 9) AND (`id` IN (3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2102705, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 26, 10451, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Quest Credit \'Escape from Coilskar Cistern\''),
(2102705, 9, 4, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Despawn Instant');
