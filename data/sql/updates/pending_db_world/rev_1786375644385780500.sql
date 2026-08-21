-- Battle for Crusaders' Pinnacle (quest 13141): the Scourge waves now crawl out of the ground on spawn
-- instead of popping into existence. Emote 449 = EMOTE_ONESHOT_EMERGE.
-- Halof had no AIName, so it resolved to AggressorAI by permit; SmartAI with no combat rows behaves the
-- same in combat, so this switch only enables the emerge row below.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30989;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 30984 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30984, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 11300, 14500, 0, 0, 11, 51917, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Drudge - In Combat - Cast \'Cleave\' (No Repeat)'),
(30984, 0, 1, 0, 0, 0, 100, 0, 7000, 9000, 17800, 20200, 0, 0, 11, 49678, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Drudge - In Combat - Cast \'Flesh Rot\' (No Repeat)'),
(30984, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 449, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Drudge - On Just Summoned - Play Emote 449');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 30986 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30986, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 32674, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - On Aggro - Cast \'Avenger\'s Shield\' (No Repeat)'),
(30986, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 17800, 19800, 0, 0, 11, 58154, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - In Combat - Cast \'Hammer of Injustice\' (No Repeat)'),
(30986, 0, 2, 0, 2, 0, 100, 1, 0, 45, 0, 0, 0, 0, 11, 58153, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - Between 0-45% Health - Cast \'Unholy Light\' (No Repeat)'),
(30986, 0, 3, 0, 14, 0, 100, 0, 4000, 10, 20000, 30000, 0, 0, 11, 58153, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - Friendly At 4000 Health - Cast \'Unholy Light\' (No Repeat)'),
(30986, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 449, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - On Just Summoned - Play Emote 449');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 30987 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30987, 0, 0, 0, 0, 0, 100, 0, 3400, 4600, 11400, 16500, 0, 0, 11, 38761, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hideous Plaguebringer - In Combat - Cast \'Arcing Smash\' (No Repeat)'),
(30987, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 449, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hideous Plaguebringer - On Just Summoned - Play Emote 449');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 30989 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30989, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 449, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Halof the Deathbringer - On Just Summoned - Play Emote 449');
