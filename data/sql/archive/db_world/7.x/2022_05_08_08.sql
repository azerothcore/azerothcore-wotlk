-- DB update 2022_05_08_07 -> 2022_05_08_08
-- Soulflayer
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11359;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11359) AND (`source_type` = 0) AND (`id` IN (0, 1, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11359, 0, 0, 0, 0, 0, 100, 0, 16000, 19000, 2100, 23000, 0, 11, 22678, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Soulflayer - In Combat - Cast \'Fear\''),
(11359, 0, 1, 0, 0, 0, 100, 0, 10000, 14000, 20000, 22000, 0, 11, 24619, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Soulflayer - In Combat - Cast \'Soul Tap\''),
(11359, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Soulflayer - Between 0-30% Health - Say Line 0 (No Repeat)');

-- Gurubashi Berserker
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11352;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 11352);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11352, 0, 0, 0, 0, 0, 100, 0, 15000, 15000, 15000, 15000, 0, 11, 16508, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Berserker - In Combat - Cast \'Intimidating Roar\''),
(11352, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 15000, 15000, 0, 11, 11130, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Berserker - In Combat - Cast \'Knock Away\''),
(11352, 0, 2, 0, 0, 0, 100, 0, 3000, 3000, 13000, 18000, 0, 11, 15588, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Berserker - In Combat - Cast \'Thunderclap\''),
(11352, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8269, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Berserker - Between 0-30% Health - Cast \'Frenzy\' (No Repeat)'),
(11352, 0, 4, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Berserker - Between 0-30% Health - Say Line 0 (No Repeat)');

-- Gurubashi Axe Thrower
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11350;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11350) AND (`source_type` = 0) AND (`id` IN (0, 1, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11350, 0, 0, 0, 4, 0, 30, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Axe Thrower - On Aggro - Say Line 1'),
(11350, 0, 1, 0, 9, 0, 100, 1, 5, 30, 1500, 2000, 0, 11, 22887, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Axe Thrower - Within 5-30 Range - Cast \'Throw\''),
(11350, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Axe Thrower - Between 0-30% Health - Say Line 0 (No Repeat)');

-- Razzashi Serpent
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11371;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 11371);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11371, 0, 0, 0, 0, 0, 100, 0, 7000, 9000, 12000, 15000, 0, 11, 20539, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Serpent - In Combat - Cast \'Fatal Bite\''),
(11371, 0, 1, 0, 0, 0, 100, 0, 9000, 11000, 14000, 17000, 0, 11, 24002, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Serpent - In Combat - Cast \'Tranquilizing Poison\''),
(11371, 0, 2, 0, 0, 0, 100, 0, 3000, 5000, 11000, 11000, 0, 11, 12097, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Serpent - In Combat - Cast \'Pierce Armor\'');
