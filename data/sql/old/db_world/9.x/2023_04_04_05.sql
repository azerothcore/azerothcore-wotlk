-- DB update 2023_04_04_04 -> 2023_04_04_05
-- ID 3374 (Bael'dun Excavator)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3374);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3374, 0, 0, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Excavator - Between 0-15% Health - Flee For Assist (No Repeat)'),
(3374, 0, 1, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Excavator - On Aggro - Cast \'Defensive Stance\' (No Repeat)'),
(3374, 0, 2, 0, 0, 0, 100, 0, 5000, 20000, 10000, 30000, 0, 11, 7386, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Excavator - In Combat - Cast \'Sunder Armor\'');

-- ID 3375 (Bael'dun Foreman)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3375);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3375, 0, 0, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Foreman - Between 0-15% Health - Flee For Assist (No Repeat)'),
(3375, 0, 1, 0, 0, 0, 100, 0, 0, 20000, 27000, 35000, 0, 11, 6257, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Foreman - In Combat - Cast \'Torch Toss\'');

-- ID 3376 (Bael'dun Soldier)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3376);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3376, 0, 0, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Soldier - Between 0-15% Health - Flee For Assist (No Repeat)');

-- ID 3377 (Bael'dun Rifleman)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3377);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3377, 0, 0, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Rifleman - Between 0-15% Health - Flee For Assist (No Repeat)'),
(3377, 0, 1, 0, 0, 0, 100, 0, 0, 0, 2300, 3900, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Rifleman - In Combat - Cast \'Shoot\'');

-- ID 3378 (Bael'dun Officer) -- Thrash (2 attacks) - move from SAI to _addon
UPDATE `creature_template_addon` SET `auras` = '8876' WHERE (`entry` = 3378);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3378);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3378, 0, 0, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Officer - Between 0-15% Health - Flee For Assist (No Repeat)'),
(3378, 0, 1, 0, 0, 0, 100, 0, 0, 20000, 45000, 60000, 0, 11, 6264, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Officer - In Combat - Cast \'Nimble Reflexes\'');

-- ID 3392 (Prospector Khazgorm)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3392);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3392, 0, 0, 0, 0, 0, 100, 0, 7000, 14000, 10000, 16000, 0, 11, 6253, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Prospector Khazgorm - In Combat - Cast \'Backhand\'');
