-- DB update 2023_02_11_09 -> 2023_02_12_00
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20478;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20478);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20478, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35259, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcane Servant - On Just Summoned - Cast \'Spotlight\''),
(20478, 0, 1, 0, 0, 0, 100, 0, 20000, 25000, 20000, 25000, 0, 11, 35255, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcane Servant - In Combat - Cast \'Arcane Volley\''),
(20478, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 11, 22271, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcane Servant - On Just Summoned - Cast \'Arcane Explosion\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20059);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20059, 0, 0, 0, 0, 0, 100, 2, 15000, 30000, 15000, 30000, 0, 11, 35243, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast \'Starfire\' (Normal Dungeon)'),
(20059, 0, 1, 0, 0, 0, 100, 4, 15000, 30000, 15000, 30000, 0, 11, 38935, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast \'Starfire\' (Heroic Dungeon)'),
(20059, 0, 2, 0, 9, 0, 100, 2, 0, 8, 9000, 10000, 0, 11, 35261, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - Within 0-8 Range - Cast \'Arcane Nova\' (Normal Dungeon)'),
(20059, 0, 3, 0, 9, 0, 100, 4, 0, 8, 9000, 10000, 0, 11, 38936, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - Within 0-8 Range - Cast \'Arcane Nova\' (Heroic Dungeon)'),
(20059, 0, 4, 0, 0, 0, 100, 4, 5000, 5000, 10000, 10000, 0, 11, 17201, 0, 0, 0, 0, 0, 26, 30, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast \'Dispel Magic\' (Heroic Dungeon)'),
(20059, 0, 5, 0, 0, 0, 100, 0, 20000, 20000, 40000, 40000, 0, 11, 35251, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast \'Summon Arcane Golem\''),
(20059, 0, 6, 0, 0, 0, 100, 0, 20000, 20000, 40000, 40000, 0, 11, 35260, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast \'Summon Arcane Golem\'');
