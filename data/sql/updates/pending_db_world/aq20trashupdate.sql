UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15343;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15343) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15343, 0, 0, 0, 9, 0, 100, 0, 0, 5, 5000, 7000, 0, 11, 25174, 3, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Swarmguard - Within 0-5 Range - Cast \'Sundering Cleave\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15325;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15325) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15325, 0, 0, 0, 9, 0, 100, 0, 0, 40, 11000, 16000, 0, 11, 25185, 4, 3, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Wasp - Within 0-40 Range - Cast \'Itch\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15324;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 15324);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15324, 0, 0, 0, 0, 3, 100, 0, 7000, 11000, 6000, 17000, 0, 11, 5568, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Gladiator - In Combat - Cast \'Trample\' (Phases 1 & 2)'),
(15324, 0, 1, 0, 9, 3, 100, 0, 0, 10, 6000, 16000, 0, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Gladiator - Within 0-10 Range - Cast \'Uppercut\' (Phases 1 & 2)'),
(15324, 0, 2, 3, 0, 2, 100, 0, 1000, 1000, 60000, 60000, 0, 11, 25164, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Gladiator - In Combat - Cast \'Vengeance\' (Phase 2)'),
(15324, 0, 3, 0, 61, 2, 100, 0, 0, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Gladiator - In Combat - Play Emote 1 (Phase 2)'),
(15324, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 15324, 60, 0, 0, 0, 0, 0, 0, 'Qiraji Gladiator - On Just Died - Set Data 1 1'),
(15324, 0, 5, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Gladiator - On Data Set 1 1 - Set Event Phase 2'),
(15324, 0, 7, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Gladiator - On Aggro - Set Event Phase 2'),
(15324, 0, 8, 0, 74, 0, 100, 0, 1, 100, 2000, 4000, 0, 22, 1, 0, 0, 0, 0, 0, 19, 15324, 60, 0, 0, 0, 0, 0, 0, 'Qiraji Gladiator - On Friendly Between 1-100% Health - Set Event Phase 1');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15338;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 15338);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15338, 0, 0, 0, 0, 0, 100, 0, 5000, 9000, 8000, 11000, 0, 11, 25756, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Obsidian Destroyer - In Combat - Cast \'Purge\''),
(15338, 0, 1, 0, 0, 0, 100, 0, 2000, 4000, 6000, 6000, 0, 11, 25755, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Obsidian Destroyer - In Combat - Cast \'Drain Mana\''),
(15338, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 27627, 2, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 'Obsidian Destroyer - On Just Died - Cast \'Serverside - Drop Obsidian\''),
(15338, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 25756, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Obsidian Destroyer - On Respawn - Cast \'Purge\'');
UPDATE `creature_template` SET `unit_flags2` = 0 WHERE (`entry` = 15338);
