--
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2612700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2612700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 26175, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - Actionlist - Quest Credit \'Drake Hunt\''),
(2612700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 46607, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - Actionlist - Remove Aura \'Drake Harpoon\''),
(2612700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - Actionlist - Stop Follow'),
(2612700, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 1, 0, 0, 0, 8, 0, 0, 0, 0, 3573.02, 6651.63, 195.2, 0, 'Nexus Drake Hatchling - Actionlist - Move To Position'),
(2612700, 9, 4, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 26117, 30, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - Actionlist - Raelorasz Say Line'),
(2612700, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 86, 46704, 0, 19, 26117, 30, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - Actionlist - Cross Cast \'Raelorasz Fireball\'');
