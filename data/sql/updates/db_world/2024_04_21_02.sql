-- DB update 2024_04_21_01 -> 2024_04_21_02
-- make 'Midsummer Celebrants' talk regularly
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16781) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16781, 0, 2, 0, 1, 0, 100, 0, 10000, 60000, 10000, 60000, 0, 0, 5, 396, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Midsummer Celebrant - Out of Combat - Play Emote 396');
