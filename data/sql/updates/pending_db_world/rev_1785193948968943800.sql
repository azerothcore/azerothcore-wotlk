--
UPDATE `spell_area` SET `spell` = 44018 WHERE `spell` = 44017 AND `area` = 3990 AND `quest_start` = 11504 AND `aura_spell` = 0 AND `racemask` = 0 AND `gender` = 2;

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2471300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2471300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Crowleg" Dan - Actionlist - Remove Npc Flags Gossip'),
(2471300, 9, 1, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Crowleg" Dan - Actionlist - Say Line'),
(2471300, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Crowleg" Dan - Actionlist - Set Faction 14'),
(2471300, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '"Crowleg" Dan - Actionlist - Start Attacking'),
(2471300, 9, 4, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Crowleg" Dan - Actionlist - Add Npc Flags Gossip'),
(2471300, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 1888, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Crowleg" Dan - Actionlist - Set Faction 1888');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24713);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24713, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Crowleg" Dan - On Reset - Add Npc Flags Gossip'),
(24713, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 1888, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Crowleg" Dan - On Reset - Set Faction 1888'),
(24713, 0, 2, 0, 62, 0, 100, 0, 9335, 0, 0, 0, 0, 0, 80, 2471300, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Crowleg" Dan - On Gossip Option Selected - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2453900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2453900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '\'Silvermoon\' Harry - On Script - Say Line 0'),
(2453900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 131, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - Actionlist - Remove Npc Flags Gossip & Questgiver & Vendor'),
(2453900, 9, 2, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - Actionlist - Set Faction 14'),
(2453900, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 10, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - Actionlist - Start Attacking');
