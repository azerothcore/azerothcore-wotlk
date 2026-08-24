-- DB update 2026_08_19_01 -> 2026_08_19_02
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25451) AND (`source_type` = 0) AND (`id` IN (5));

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25453) AND (`source_type` = 0) AND (`id` IN (9));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25453, 0, 9, 0, 82, 1, 100, 0, 25451, 0, 0, 0, 0, 0, 80, 2545302, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ith\'rix the Harvester - On Summoned Unit Dies - Summon Another (Phase 1)');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25446) AND (`source_type` = 0) AND (`id` IN (5, 6, 7, 8, 9, 10));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25446, 0, 5, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 80, 2544601, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - On Action Received from Ith\'rix - Run Script End Event'),
(25446, 0, 6, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2544602, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - On Reached Carapace - Run Gloat Script');
