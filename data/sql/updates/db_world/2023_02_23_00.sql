-- DB update 2023_02_20_00 -> 2023_02_23_00
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2242200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2242200, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 86, 40227, 0, 10, 73126, 20736, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blade\'s Edge - Legion - Anger Camp - Invis Bunny - Actionlist - Cross Cast \'Green Beam\''),
(2242200, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 86, 40227, 0, 10, 73126, 20736, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blade\'s Edge - Legion - Anger Camp - Invis Bunny - Actionlist - Cross Cast \'Green Beam\''),
(2242200, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 86, 40227, 0, 10, 73129, 20736, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blade\'s Edge - Legion - Anger Camp - Invis Bunny - Actionlist - Cross Cast \'Green Beam\''),
(2242200, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 86, 40227, 0, 10, 73130, 20736, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blade\'s Edge - Legion - Anger Camp - Invis Bunny - Actionlist - Cross Cast \'Green Beam\''),
(2242200, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 86, 40227, 0, 10, 73133, 20736, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blade\'s Edge - Legion - Anger Camp - Invis Bunny - Actionlist - Cross Cast \'Green Beam\''),
(2242200, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 12, 19963, 4, 120000, 0, 0, 0, 8, 0, 0, 0, 0, 2870.55, 4814.18, 283.66, 0.34, 'Blade\'s Edge - Legion - Anger Camp - Invis Bunny - Actionlist - Summon Creature \'Doomcryer\''),
(2242200, 9, 6, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blade\'s Edge - Legion - Anger Camp - Invis Bunny - Actionlist - Reset Counter'),
(2242200, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 92, 0, 0, 0, 0, 0, 0, 11, 20736, 100, 0, 0, 0, 0, 0, 0, 'Blade\'s Edge - Legion - Anger Camp - Invis Bunny - Actionlist - Interrupt Spell'),
(2242200, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 104, 4, 0, 0, 0, 0, 0, 20, 185193, 100, 0, 0, 0, 0, 0, 0, 'Blade\'s Edge - Legion - Anger Camp - Invis Bunny - Actionlist - Set Gameobject Flags Interact Condition'),
(2242200, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 104, 4, 0, 0, 0, 0, 0, 20, 185195, 100, 0, 0, 0, 0, 0, 0, 'Blade\'s Edge - Legion - Anger Camp - Invis Bunny - Actionlist - Set Gameobject Flags Interact Condition'),
(2242200, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 104, 4, 0, 0, 0, 0, 0, 20, 185196, 100, 0, 0, 0, 0, 0, 0, 'Blade\'s Edge - Legion - Anger Camp - Invis Bunny - Actionlist - Set Gameobject Flags Interact Condition'),
(2242200, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 104, 4, 0, 0, 0, 0, 0, 20, 185197, 100, 0, 0, 0, 0, 0, 0, 'Blade\'s Edge - Legion - Anger Camp - Invis Bunny - Actionlist - Set Gameobject Flags Interact Condition'),
(2242200, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 104, 4, 0, 0, 0, 0, 0, 20, 185198, 100, 0, 0, 0, 0, 0, 0, 'Blade\'s Edge - Legion - Anger Camp - Invis Bunny - Actionlist - Set Gameobject Flags Interact Condition');
