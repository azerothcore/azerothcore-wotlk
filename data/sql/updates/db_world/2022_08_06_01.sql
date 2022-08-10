-- DB update 2022_08_06_00 -> 2022_08_06_01
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15391;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15391) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15391, 0, 0, 0, 0, 0, 100, 2, 10000, 11000, 8000, 9000, 0, 11, 24317, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Qeez - In Combat - Cast \'Sunder Armor\' (Normal Dungeon)'),
(15391, 0, 1, 0, 0, 0, 100, 2, 12000, 13000, 14000, 15000, 0, 11, 19134, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Qeez - In Combat - Cast \'Frightening Shout\' (Normal Dungeon)'),
(15391, 0, 2, 0, 0, 0, 100, 514, 13000, 17000, 14000, 18000, 0, 23, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Qeez - In Combat - Increment Phase (Normal Dungeon)'),
(15391, 0, 3, 0, 0, 1, 100, 2, 1000, 1000, 1000, 1000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Qeez - In Combat - Cast \'Cleave\' (Phase 1) (Normal Dungeon)'),
(15391, 0, 4, 0, 0, 1, 100, 2, 2000, 2000, 2000, 2000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Qeez - In Combat - Cast \'Cleave\' (Phase 1) (Normal Dungeon)'),
(15391, 0, 5, 0, 0, 1, 100, 514, 3000, 3000, 3000, 3000, 0, 23, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Qeez - In Combat - Decrement Phase (Phase 1) (Normal Dungeon)'),
(15391, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 34, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Qeez - On Aggro - Set Instance Data 1 to 8');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15392;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15392) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15392, 0, 0, 0, 0, 0, 100, 2, 10000, 11000, 8000, 9000, 0, 11, 24317, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Tuubid - In Combat - Cast \'Sunder Armor\' (Normal Dungeon)'),
(15392, 0, 1, 0, 0, 0, 100, 2, 12000, 13000, 14000, 15000, 0, 11, 25471, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Tuubid - In Combat - Cast \'Attack Order\' (Normal Dungeon)'),
(15392, 0, 2, 0, 0, 0, 100, 514, 13000, 17000, 14000, 18000, 0, 23, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Tuubid - In Combat - Increment Phase (Normal Dungeon)'),
(15392, 0, 3, 0, 0, 1, 100, 2, 1000, 1000, 1000, 1000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Tuubid - In Combat - Cast \'Cleave\' (Phase 1) (Normal Dungeon)'),
(15392, 0, 4, 0, 0, 1, 100, 2, 2000, 2000, 2000, 2000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Tuubid - In Combat - Cast \'Cleave\' (Phase 1) (Normal Dungeon)'),
(15392, 0, 5, 0, 0, 1, 100, 514, 3000, 3000, 3000, 3000, 0, 23, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Tuubid - In Combat - Decrement Phase (Phase 1) (Normal Dungeon)'),
(15392, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 34, 1, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Tuubid - On Aggro - Set Instance Data 1 to 9');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15389;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15389) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15389, 0, 0, 0, 0, 0, 100, 2, 10000, 11000, 8000, 9000, 0, 11, 24317, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Drenn - In Combat - Cast \'Sunder Armor\' (Normal Dungeon)'),
(15389, 0, 1, 0, 0, 0, 100, 2, 12000, 13000, 14000, 15000, 0, 11, 26550, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Drenn - In Combat - Cast \'Lightning Cloud\' (Normal Dungeon)'),
(15389, 0, 2, 0, 0, 0, 100, 514, 13000, 17000, 14000, 18000, 0, 23, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Drenn - In Combat - Increment Phase (Normal Dungeon)'),
(15389, 0, 3, 0, 0, 1, 100, 2, 1000, 1000, 1000, 1000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Drenn - In Combat - Cast \'Cleave\' (Phase 1) (Normal Dungeon)'),
(15389, 0, 4, 0, 0, 1, 100, 2, 2000, 2000, 2000, 2000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Drenn - In Combat - Cast \'Cleave\' (Phase 1) (Normal Dungeon)'),
(15389, 0, 5, 0, 0, 1, 100, 514, 3000, 3000, 3000, 3000, 0, 23, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Drenn - In Combat - Decrement Phase (Phase 1) (Normal Dungeon)'),
(15389, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 34, 1, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Drenn - On Aggro - Set Instance Data 1 to 10');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15390;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15390) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15390, 0, 0, 0, 0, 0, 100, 2, 10000, 11000, 8000, 9000, 0, 11, 24317, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Xurrem - In Combat - Cast \'Sunder Armor\' (Normal Dungeon)'),
(15390, 0, 1, 0, 0, 0, 100, 2, 12000, 13000, 14000, 15000, 0, 11, 25425, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Xurrem - In Combat - Cast \'Shockwave\' (Normal Dungeon)'),
(15390, 0, 2, 0, 0, 0, 100, 514, 13000, 17000, 14000, 18000, 0, 23, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Xurrem - In Combat - Increment Phase (Normal Dungeon)'),
(15390, 0, 3, 0, 0, 1, 100, 2, 1000, 1000, 1000, 1000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Xurrem - In Combat - Cast \'Cleave\' (Phase 1) (Normal Dungeon)'),
(15390, 0, 4, 0, 0, 1, 100, 2, 2000, 2000, 2000, 2000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Xurrem - In Combat - Cast \'Cleave\' (Phase 1) (Normal Dungeon)'),
(15390, 0, 5, 0, 0, 1, 100, 514, 3000, 3000, 3000, 3000, 0, 23, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Xurrem - In Combat - Decrement Phase (Phase 1) (Normal Dungeon)'),
(15390, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 34, 1, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Xurrem - On Aggro - Set Instance Data 1 to 11');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15386;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15386) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15386, 0, 0, 0, 0, 0, 100, 2, 10000, 11000, 8000, 9000, 0, 11, 24317, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Yeggeth - In Combat - Cast \'Sunder Armor\' (Normal Dungeon)'),
(15386, 0, 1, 0, 0, 0, 100, 2, 12000, 13000, 8000, 9000, 0, 11, 25282, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Yeggeth - In Combat - Cast \'Shield of Rajaxx\' (Normal Dungeon)'),
(15386, 0, 2, 0, 0, 0, 100, 514, 13000, 17000, 14000, 18000, 0, 23, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Yeggeth - In Combat - Increment Phase (Normal Dungeon)'),
(15386, 0, 3, 0, 0, 1, 100, 2, 1000, 1000, 1000, 1000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Yeggeth - In Combat - Cast \'Cleave\' (Phase 1) (Normal Dungeon)'),
(15386, 0, 4, 0, 0, 1, 100, 2, 2000, 2000, 2000, 2000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Yeggeth - In Combat - Cast \'Cleave\' (Phase 1) (Normal Dungeon)'),
(15386, 0, 5, 0, 0, 1, 100, 514, 3000, 3000, 3000, 3000, 0, 23, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Yeggeth - In Combat - Decrement Phase (Phase 1) (Normal Dungeon)'),
(15386, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 34, 1, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Yeggeth - On Aggro - Set Instance Data 1 to 12');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15388;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15388) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15388, 0, 0, 0, 0, 0, 100, 2, 10000, 11000, 8000, 9000, 0, 11, 24317, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Pakkon - In Combat - Cast \'Sunder Armor\' (Normal Dungeon)'),
(15388, 0, 1, 0, 0, 0, 100, 2, 12000, 13000, 14000, 15000, 0, 11, 25322, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Pakkon - In Combat - Cast \'Sweeping Slam\' (Normal Dungeon)'),
(15388, 0, 2, 0, 0, 0, 100, 514, 13000, 17000, 14000, 18000, 0, 23, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Pakkon - In Combat - Increment Phase (Normal Dungeon)'),
(15388, 0, 3, 0, 0, 1, 100, 2, 1000, 1000, 1000, 1000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Pakkon - In Combat - Cast \'Cleave\' (Phase 1) (Normal Dungeon)'),
(15388, 0, 4, 0, 0, 1, 100, 2, 2000, 2000, 2000, 2000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Pakkon - In Combat - Cast \'Cleave\' (Phase 1) (Normal Dungeon)'),
(15388, 0, 5, 0, 0, 1, 100, 514, 3000, 3000, 3000, 3000, 0, 23, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Pakkon - In Combat - Decrement Phase (Phase 1) (Normal Dungeon)'),
(15388, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 34, 1, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Major Pakkon - On Aggro - Set Instance Data 1 to 13');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15385;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15385) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15385, 0, 0, 0, 0, 0, 100, 2, 10000, 11000, 8000, 9000, 0, 11, 24317, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Zerran - In Combat - Cast \'Sunder Armor\' (Normal Dungeon)'),
(15385, 0, 1, 0, 0, 0, 100, 2, 12000, 13000, 8000, 9000, 0, 11, 25462, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Zerran - In Combat - Cast \'Enlarge\' (Normal Dungeon)'),
(15385, 0, 2, 0, 0, 0, 100, 514, 13000, 17000, 14000, 18000, 0, 23, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Zerran - In Combat - Increment Phase (Normal Dungeon)'),
(15385, 0, 3, 0, 0, 1, 100, 2, 1000, 1000, 1000, 1000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Zerran - In Combat - Cast \'Cleave\' (Phase 1) (Normal Dungeon)'),
(15385, 0, 4, 0, 0, 1, 100, 2, 2000, 2000, 2000, 2000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Zerran - In Combat - Cast \'Cleave\' (Phase 1) (Normal Dungeon)'),
(15385, 0, 5, 0, 0, 1, 100, 514, 3000, 3000, 3000, 3000, 0, 23, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Zerran - In Combat - Decrement Phase (Phase 1) (Normal Dungeon)'),
(15385, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 34, 1, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Zerran - On Aggro - Set Instance Data 1 to 14');
