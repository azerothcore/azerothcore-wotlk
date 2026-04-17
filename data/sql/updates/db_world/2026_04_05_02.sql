-- DB update 2026_04_05_01 -> 2026_04_05_02
-- Fix quest The Dread Relic
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22369) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22369, 0, 0, 1, 54, 0, 100, 1, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dread Relic Thrall - On Just Summoned - Set Passive'),
(22369, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 67, 1, 10000, 10000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dread Relic Thrall - On Just Summoned - Create Timed Event'),
(22369, 0, 2, 3, 59, 0, 100, 1, 1, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dread Relic Thrall - Timed Event - Set Aggressive'),
(22369, 0, 3, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Dread Relic Thrall - Timed Event - Attack Summoner'),
(22369, 0, 4, 0, 4, 0, 100, 4, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 22369, 10, 0, 0, 0, 0, 0, 0, 'Dread Relic Thrall - On Aggro - Set Data');
