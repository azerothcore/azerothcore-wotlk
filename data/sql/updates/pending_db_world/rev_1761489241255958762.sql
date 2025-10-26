--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28578;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28578);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28578, 0, 0, 0, 0, 0, 100, 6, 4000, 7000, 6000, 10000, 0, 0, 11, 42724, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Steel Reaver - In Combat - Cast \'Cleave\''),
(28578, 0, 1, 0, 0, 0, 100, 2, 9000, 18000, 12000, 24000, 0, 0, 11, 15655, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Steel Reaver - In Combat - Cast \'Shield Slam\' (Normal)'),
(28578, 0, 2, 0, 0, 0, 100, 4, 9000, 18000, 12000, 24000, 0, 0, 11, 59142, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Steel Reaver - In Combat - Cast \'Shield Slam\' (Heroic)'),
(28578, 0, 3, 0, 1, 0, 100, 4, 0, 0, 0, 0, 0, 0, 11, 59143, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hardened Steel Reaver - Out of Combat - Cast Dull Weapons (Heroic)');
