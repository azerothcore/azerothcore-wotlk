-- DB update 2022_07_27_01 -> 2022_07_27_02
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15338;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 15338);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15338, 0, 0, 0, 0, 0, 100, 0, 5000, 9000, 8000, 11000, 0, 11, 25756, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Obsidian Destroyer - In Combat - Cast \'Purge\''),
(15338, 0, 1, 0, 0, 0, 100, 0, 2000, 4000, 6000, 6000, 0, 11, 25755, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Obsidian Destroyer - In Combat - Cast \'Drain Mana\''),
(15338, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 27627, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Obsidian Destroyer - On Just Died - Cast \'Serverside - Drop Obsidian\''),
(15338, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 108, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Obsidian Destroyer - On Respawn - Set Mana To 0'),
(15338, 0, 4, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 108, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Obsidian Destroyer - On Evade - Set Mana To 0');
