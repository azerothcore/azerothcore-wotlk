-- DB update 2025_10_26_00 -> 2025_10_26_01
-- Dark Rune Elementalist
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27962;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27962);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27962, 0, 1, 0, 0, 0, 100, 6, 5000, 9000, 16000, 20000, 0, 0, 11, 51475, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rune Elementalist - In Combat - Cast \'Summon Air Elemental\' (Dungeon)'),
(27962, 0, 2, 0, 1, 0, 100, 2, 1000, 1000, 600000, 600000, 0, 0, 11, 51776, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rune Elementalist - Out of Combat - Cast \'Lightning Shield\' (Normal Dungeon)'),
(27962, 0, 3, 0, 0, 0, 100, 2, 0, 0, 20000, 30000, 0, 0, 11, 51776, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rune Elementalist - In Combat - Cast \'Lightning Shield\' (Normal Dungeon)'),
(27962, 0, 4, 0, 0, 0, 100, 6, 1000, 10000, 31000, 42000, 0, 0, 11, 32693, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rune Elementalist - In Combat - Cast \'Arcane Haste\' (Dungeon)'),
(27962, 0, 5, 0, 1, 0, 100, 4, 1000, 1000, 600000, 600000, 0, 0, 11, 59025, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rune Elementalist - Out of Combat - Cast \'Lightning Shield\' (Heroic Dungeon)'),
(27962, 0, 6, 0, 0, 0, 100, 4, 0, 0, 20000, 30000, 0, 0, 11, 59025, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rune Elementalist - In Combat - Cast \'Lightning Shield\' (Heroic Dungeon)');
-- lesser air elemental
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28384;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28384) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28384, 0, 0, 0, 0, 0, 100, 6, 3000, 10000, 5000, 9000, 0, 0, 11, 15801, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Lesser Air Elemental - In Combat - Cast \'Lightning Bolt\'');
