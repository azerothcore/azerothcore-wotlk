-- DB update 2026_01_14_01 -> 2026_01_15_00

-- Edit Spell Timers (Watcher Narjil, Gashra, Silthik)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (28729, 28730, 28731));

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28729) AND (`source_type` = 0) AND (`id` IN (0, 2, 3));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28730) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28731) AND (`source_type` = 0) AND (`id` IN (0, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28729, 0, 0, 0, 0, 0, 100, 0, 18000, 20000, 30000, 40000, 0, 0, 11, 52524, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - In Combat - Cast \'Blinding Webs\''),
(28729, 0, 2, 0, 0, 0, 100, 0, 20000, 25000, 20000, 25000, 0, 0, 11, 52086, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - In Combat - Cast \'Web Wrap\''),
(28729, 0, 3, 0, 0, 0, 100, 0, 24000, 28000, 24000, 28000, 0, 0, 11, 52469, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - In Combat - Cast \'Infected Bite\''),
(28730, 0, 0, 0, 0, 0, 100, 0, 8000, 10000, 12000, 20000, 0, 0, 11, 52470, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Gashra - In Combat - Cast \'Enrage\''),
(28730, 0, 1, 0, 0, 0, 100, 0, 15000, 18000, 16000, 18000, 0, 0, 11, 52086, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Watcher Gashra - In Combat - Cast \'Web Wrap\''),
(28730, 0, 2, 0, 0, 0, 100, 0, 24000, 28000, 24000, 28000, 0, 0, 11, 52469, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Gashra - In Combat - Cast \'Infected Bite\''),
(28731, 0, 0, 0, 0, 0, 100, 0, 8000, 10000, 18000, 20000, 0, 0, 11, 52493, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - In Combat - Cast \'Poison Spray\''),
(28731, 0, 2, 0, 0, 0, 100, 0, 15000, 18000, 16000, 18000, 0, 0, 11, 52086, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - In Combat - Cast \'Web Wrap\''),
(28731, 0, 3, 0, 0, 0, 100, 0, 24000, 28000, 24000, 28000, 0, 0, 11, 52469, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - In Combat - Cast \'Infected Bite\'');
