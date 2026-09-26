-- DB update 2026_08_20_10 -> 2026_08_21_00
--
-- Bomb Bot: detonate on reaching the target instead of after landing melee swings
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 33836);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33836, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bomb Bot - On Reset - Disable Auto Attack'),
(33836, 0, 1, 0, 1, 0, 100, 1, 1500, 1500, 60000, 60000, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bomb Bot - Out of Combat - Set In Combat With Zone'),
(33836, 0, 2, 3, 9, 0, 100, 1, 0, 0, 100, 100, 0, 3, 11, 63801, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bomb Bot - Victim Within 0-3 Range - Cast Explode'),
(33836, 0, 3, 4, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 45, 0, 12, 0, 0, 0, 0, 19, 33350, 200, 0, 0, 0, 0, 0, 0, 'Bomb Bot - On Link - Set Data 12 on Mimiron'),
(33836, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bomb Bot - On Link - Die');
