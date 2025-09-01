-- DB update 2025_04_25_01 -> 2025_04_26_00

-- Set Not Selectable for dead bodies inside Scarlet Tavern
UPDATE `creature` SET `unit_flags` = `unit_flags` |33554432 WHERE (`id1` IN(28610, 28939, 28940, 28941, 28942)) AND (`guid` IN(129664, 129682, 129683, 129727, 129769, 130001, 130002));

-- Set Timed Action List for reset (to prevent total aura resets)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2894103) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2894103, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 52262, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Remove Aura \'Cornered and Enraged!\''),
(2894103, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 51604, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Remove Aura \'Serverside - Stun Self\''),
(2894103, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 52716, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Remove Aura \'Terrified\''),
(2894103, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Set Reactstate Aggressive');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2894203) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2894203, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 52262, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Remove Aura \'Cornered and Enraged!\''),
(2894203, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 51604, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Remove Aura \'Serverside - Stun Self\''),
(2894203, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 52716, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Remove Aura \'Terrified\''),
(2894203, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Set Reactstate Aggressive');

-- Set SmartAI for Citizen of New Avalon
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28941;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28941);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28941, 0, 0, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 87, 2894100, 2894101, 2894102, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Aggro - Run Random Script'),
(28941, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2894103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Reset - Run Script'),
(28941, 0, 2, 3, 23, 1, 100, 0, 52716, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Aura \'Terrified\' - Evade (Phase 1)'),
(28941, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Aura \'Terrified\' - Set Event Phase 0 (Phase 1)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28942;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28942);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28942, 0, 0, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 87, 2894100, 2894101, 2894102, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Aggro - Run Random Script'),
(28942, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2894103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Reset - Run Script'),
(28942, 0, 2, 3, 23, 1, 100, 0, 52716, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Aura \'Terrified\' - Evade (Phase 1)'),
(28942, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Aura \'Terrified\' - Set Event Phase 0 (Phase 1)');
