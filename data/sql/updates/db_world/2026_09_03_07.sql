-- DB update 2026_09_03_06 -> 2026_09_03_07
-- Lost Drakkari Spirit should be neutral. Faction template 634 is the sniffed one.
-- Arcane Bolt kept the spirit at spell range casting nonstop. It should close in and melee between
-- casts.
UPDATE `creature_template` SET `faction` = 634 WHERE (`entry` = 29129);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29129);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29129, 0, 0, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 0, 0, 11, 17327, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lost Drakkari Spirit - On Update - Cast \'Spirit Particles\''),
(29129, 0, 1, 0, 0, 0, 50, 0, 0, 2000, 2000, 3500, 0, 0, 11, 37361, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Lost Drakkari Spirit - In Combat - Cast \'Arcane Bolt\''),
(29129, 0, 2, 0, 0, 0, 100, 0, 10000, 16000, 15000, 18000, 0, 0, 11, 24050, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Lost Drakkari Spirit - In Combat - Cast \'Spirit Burst\'');
