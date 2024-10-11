-- DB update 2024_07_08_00 -> 2024_07_09_00
-- Quest: Threat from Above, creatures already have KillCredit for 23450
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22143) AND (`source_type` = 0) AND (`id` IN (4));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22144) AND (`source_type` = 0) AND (`id` IN (4));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22148) AND (`source_type` = 0) AND (`id` IN (2));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23022);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23022, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2400, 3800, 0, 0, 11, 15232, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordunni Soulreaper - In Combat - Cast \'Shadow Bolt\''),
(23022, 0, 1, 0, 0, 0, 100, 0, 4000, 6000, 18000, 25000, 0, 0, 11, 20464, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordunni Soulreaper - In Combat - Cast \'Summon Skeleton\''),
(23022, 0, 2, 0, 2, 0, 100, 0, 0, 30, 30000, 35000, 0, 0, 11, 20743, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordunni Soulreaper - Between 0-30% Health - Cast \'Drain Life\'');
