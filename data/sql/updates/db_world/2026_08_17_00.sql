-- DB update 2026_08_16_01 -> 2026_08_17_00
--
DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 23784);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(23784, 1, 1906, 0, 0, 47720);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23784) AND (`source_type` = 0) AND (`id` IN (13));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23784, 0, 13, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - On Reached Home - Remove Npc Flags Questgiver');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2378401);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2378401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Remove FlagStandstate Kneel'),
(2378401, 9, 2, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Say Line 0'),
(2378401, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 232, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Set Faction 232'),
(2378401, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 1179030, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Start Path 1179030'),
(2378401, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Remove Npc Flags Questgiver');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2378402);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2378402, 9, 0, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Say Line 1'),
(2378402, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 124, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Load Equipment Id 1'),
(2378402, 9, 2, 0, 0, 0, 100, 0, 2600, 2600, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Hanes - Actionlist - Say Line 2');
