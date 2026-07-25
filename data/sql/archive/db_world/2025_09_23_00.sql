-- DB update 2025_09_22_03 -> 2025_09_23_00

-- Update SmartAIs
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (18855, 19643, 21660));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (18855, 19643, 21660));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18855, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 3000, 4000, 0, 0, 11, 9053, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunfury Magister - In Combat - Cast \'Fireball\''),
(18855, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 26000, 31000, 0, 0, 11, 35778, 33, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunfury Magister - In Combat - Cast \'Bloodcrystal Surge\''),
(18855, 0, 2, 0, 2, 0, 100, 512, 0, 15, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunfury Magister - Between 0-15% Health - Flee For Assist'),
(18855, 0, 3, 0, 1, 0, 50, 0, 10000, 20000, 15000, 30000, 0, 0, 11, 34397, 0, 0, 0, 0, 0, 19, 19421, 30, 0, 0, 0, 0, 0, 0, 'Sunfury Magister - Out of Combat - Cast \'Red Beam\''),
(19643, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 600000, 600000, 0, 0, 11, 35917, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunfury Astromancer - Out of Combat - Cast \'Fiery Intellect\''),
(19643, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 1500, 2000, 0, 30, 11, 38391, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunfury Astromancer - In Combat - Cast \'Scorch\''),
(19643, 0, 2, 0, 0, 0, 100, 0, 12000, 16000, 12000, 16000, 0, 30, 11, 35914, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunfury Astromancer - In Combat - Cast \'Astral Focus\''),
(21660, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2400, 3800, 0, 0, 11, 34447, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Abjurist - In Combat - Cast \'Arcane Missiles\''),
(21660, 0, 1, 0, 106, 0, 100, 0, 5000, 9000, 13000, 18000, 0, 10, 11, 11831, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Abjurist - On Hostile in Range - Cast \'Frost Nova\'');
