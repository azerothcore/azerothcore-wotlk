-- DB update 2023_03_31_02 -> 2023_03_31_03
DELETE FROM `smart_scripts` WHERE (`entryorguid` BETWEEN 2087501 AND 2087506) AND (`source_type` = 9) AND (`id` IN (5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2087501, 9, 5, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 28, 34333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Remove Aura \'Damage Reduction: Fire\''),
(2087502, 9, 5, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 28, 34334, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Remove Aura \'Damage Reduction: Frost\''),
(2087503, 9, 5, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 28, 34331, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Remove Aura \'Damage Reduction: Arcane\''),
(2087504, 9, 5, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 28, 34335, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Remove Aura \'Damage Reduction: Nature\''),
(2087505, 9, 5, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 28, 34338, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Remove Aura \'Damage Reduction: Shadow\''),
(2087506, 9, 5, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 28, 34336, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Remove Aura \'Damage Reduction: Holy\'');
