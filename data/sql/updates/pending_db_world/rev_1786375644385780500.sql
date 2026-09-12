-- Battle for Crusaders' Pinnacle (quest 13141).
-- The wave actionlist runs on the out-of-combat timer so a creature pulled on the way up keeps
-- fighting instead of breaking off to reach the position.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30989;

-- speed_run 0.45714 is not sniffed and sits below the Drudge's own speed_walk, so it trails the wave.
UPDATE `creature_template` SET `speed_run` = 1.142857 WHERE `entry` = 30984;

-- Wave spawn points, sniffed 2023-09-25 (build 50664). Groups 0 and 1 are the two wave flavours the
-- banner picks between, group 2 is the closing Halof wave. summonType 6 / 30000 keeps the lifetime
-- the script's own summons had.
DELETE FROM `creature_summon_groups` WHERE `summonerId` = 30891 AND `summonerType` = 0;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(30891, 0, 0, 30984, 6465.638, 402.743, 488.848, 2.8623, 6, 30000, 'Scourge Drudge'),
(30891, 0, 0, 30987, 6468.084, 410.647, 487.848, 2.8990, 6, 30000, 'Hideous Plaguebringer'),
(30891, 0, 0, 30987, 6476.593, 402.247, 486.004, 2.7994, 6, 30000, 'Hideous Plaguebringer'),
(30891, 0, 1, 30984, 6465.638, 402.743, 488.848, 2.8623, 6, 30000, 'Scourge Drudge'),
(30891, 0, 1, 30986, 6470.711, 399.197, 487.660, 2.8623, 6, 30000, 'Reanimated Captain'),
(30891, 0, 1, 30986, 6471.096, 407.598, 487.279, 3.0892, 6, 30000, 'Reanimated Captain'),
(30891, 0, 2, 30984, 6460.910, 397.833, 489.997, 2.8100, 6, 30000, 'Scourge Drudge'),
(30891, 0, 2, 30984, 6460.268, 408.247, 490.122, 2.9845, 6, 30000, 'Scourge Drudge'),
(30891, 0, 2, 30989, 6469.555, 405.334, 487.743, 3.2812, 6, 30000, 'Halof the Deathbringer');

DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` IN (3098700, 3098900);
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (30984, 30986, 30987, 30989);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
    -- Shared wave actionlist
    (3098900, 9, 0, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6419.78, 422.362, 510.995, 0, 'The Battle for Crusaders\' Pinnacle - Actionlist - Move To Position'),
    -- Scourge Drudge
    (30984, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 11300, 14500, 0, 0, 11, 51917, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Drudge - In Combat - Cast \'Cleave\''),
    (30984, 0, 1, 0, 0, 0, 100, 0, 7000, 9000, 17800, 20200, 0, 0, 11, 49678, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Drudge - In Combat - Cast \'Flesh Rot\''),
    (30984, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3098900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Drudge - On Just Summoned - Run Script'),
    (30984, 0, 3, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Drudge - On Reached Point 1 - Set Home Position'),
    -- Reanimated Captain
    (30986, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 32674, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - On Aggro - Cast \'Avenger\'s Shield\' (No Repeat)'),
    (30986, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 17800, 19800, 0, 0, 11, 58154, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - In Combat - Cast \'Hammer of Injustice\''),
    (30986, 0, 2, 0, 2, 0, 100, 1, 0, 45, 0, 0, 0, 0, 11, 58153, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - Between 0-45% Health - Cast \'Unholy Light\' (No Repeat)'),
    (30986, 0, 3, 0, 14, 0, 100, 0, 4000, 10, 20000, 30000, 0, 0, 11, 58153, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - Friendly At 4000 Health - Cast \'Unholy Light\''),
    (30986, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3098900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - On Just Summoned - Run Script'),
    (30986, 0, 5, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - On Reached Point 1 - Set Home Position'),
    -- Hideous Plaguebringer
    (30987, 0, 0, 0, 0, 0, 100, 0, 3400, 4600, 11400, 16500, 0, 0, 11, 38761, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hideous Plaguebringer - In Combat - Cast \'Arcing Smash\''),
    (30987, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3098900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hideous Plaguebringer - On Just Summoned - Run Script'),
    (30987, 0, 2, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hideous Plaguebringer - On Reached Point 1 - Set Home Position'),
    -- Halof the Deathbringer
    (30989, 0, 0, 0, 0, 0, 100, 0, 0, 5500, 5500, 11400, 0, 0, 11, 49895, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Halof the Deathbringer - In Combat - Cast \'Death Coil\''),
    (30989, 0, 1, 0, 0, 0, 100, 0, 2600, 5700, 8500, 13400, 0, 0, 11, 49941, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Halof the Deathbringer - In Combat - Cast \'Blood Boil\''),
    (30989, 0, 2, 0, 0, 0, 100, 0, 7300, 8700, 10300, 10400, 0, 0, 11, 49909, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Halof the Deathbringer - In Combat - Cast \'Icy Touch\''),
    (30989, 0, 3, 0, 0, 0, 100, 0, 5000, 5300, 5100, 5300, 0, 0, 11, 51425, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Halof the Deathbringer - In Combat - Cast \'Obliterate\''),
    (30989, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3098900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Halof the Deathbringer - On Just Summoned - Run Script'),
    (30989, 0, 5, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Halof the Deathbringer - On Reached Point 1 - Set Home Position');
