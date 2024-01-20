-- DB update 2023_07_09_01 -> 2023_07_10_00
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1782700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1782700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - Actionlist - Remove All Aura'),
(1782700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - Actionlist - Set Run On'),
(1782700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 289.255, -129.7, 29.821, 2.49582, 'Claw - Actionlist - Move To Position'),
(1782700, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 1660, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - Actionlist - Set Faction 1660'),
(1782700, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 18, 525072, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - Actionlist - Set Flags Rename & Immune To Players & Immune To NPC\'s & In Combat'),
(1782700, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 3, 0, 2289, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - Actionlist - Morph To Model 2289'),
(1782700, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - Actionlist - Set Npc Flag '),
(1782700, 9, 7, 0, 0, 0, 100, 0, 4000, 4000, 4000, 4000, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 290.532, -125.352, 29.6971, 1.82491, 'Claw - Actionlist - Move To Position'),
(1782700, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 3, 17894, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - Actionlist - Morph To Creature Windcaller Claw'),
(1782700, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 18, 557824, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - Actionlist - Set Flags Immune To Players & Immune To NPC\'s & In Combat'),
(1782700, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 90, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - Actionlist - Set Flag Standstate Sit Down'),
(1782700, 9, 11, 0, 0, 0, 100, 0, 500, 500, 500, 500, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - Actionlist - Set Npc Flags Gossip');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17827);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17827, 0, 0, 0, 0, 0, 100, 0, 7400, 7400, 20000, 20000, 0, 11, 39435, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - In Combat - Cast \'Feral Charge\''),
(17827, 0, 1, 0, 0, 0, 100, 0, 2400, 2400, 10600, 21200, 0, 11, 31429, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - In Combat - Cast \'Echoing Roar\''),
(17827, 0, 2, 6, 0, 0, 100, 0, 5000, 5000, 30500, 30500, 0, 11, 34971, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - In Combat - Cast \'Frenzy\''),
(17827, 0, 3, 0, 0, 0, 100, 0, 5300, 5300, 11100, 21500, 0, 11, 34298, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - In Combat - Cast \'Maul\''),
(17827, 0, 4, 0, 2, 0, 100, 769, 0, 20, 0, 0, 0, 80, 1782700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - Between 0-20% Health - Run Script'),
(17827, 0, 5, 0, 64, 0, 100, 512, 0, 0, 0, 0, 0, 33, 17894, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - On Gossip Hello - Quest Credit \'Lost In Action\''),
(17827, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 17826, 100, 0, 0, 0, 0, 0, 0, 'Claw - In Combat - Say Line 0'),
(17827, 0, 7, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Claw - On Reset - Set Invincibility Hp 1');
