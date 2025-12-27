-- Also changes this lol
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 118);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(118, 0, 0, 0, 0, 0, 70, 0, 10000, 20000, 15000, 30000, 0, 0, 11, 3604, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Prowler - In Combat - Cast \'Tendon Rip\'');

-- Set to Distance where the howl sound is played
UPDATE `smart_scripts` SET `action_param3` = 1 WHERE `entryorguid` IN (834, 1922, 2729) AND `source_type` = 0 AND `action_param1` = 1018 AND `action_type` = 4;
