-- Battle for Crusaders' Pinnacle (quest 13141).
-- ALWAYS timer (action_param2 = 2): Add Threat puts the summon in combat, and an out-of-combat
-- timer would stall every row after it.
-- Emote 449 does nothing on the Plaguebringer - display 23137 has no emerge animation.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30989;

-- Sniffed speed_run 0.45714 is below the Drudge's own speed_walk, so it trails the wave.
UPDATE `creature_template` SET `speed_run` = 1.14286 WHERE `entry` = 30984;

DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` IN (3098700, 3098900);
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (30984, 30986, 30987, 30989);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
    -- Shared emerge actionlist
    (3098900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Battle for Crusaders\' Pinnacle - Actionlist - Set React State Passive'),
    (3098900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 449, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Battle for Crusaders\' Pinnacle - Actionlist - Play Emote 449'),
    (3098900, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6426.343, 420.515, 508.65, 0, 'The Battle for Crusaders\' Pinnacle - Actionlist - Set Home Position'),
    (3098900, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 19, 30891, 100, 0, 0, 0, 0, 0, 0, 'The Battle for Crusaders\' Pinnacle - Actionlist - Add Threat On Blessed Banner'),
    (3098900, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Battle for Crusaders\' Pinnacle - Actionlist - Set React State Aggressive'),
    -- Scourge Drudge
    (30984, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 11300, 14500, 0, 0, 11, 51917, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Drudge - In Combat - Cast \'Cleave\''),
    (30984, 0, 1, 0, 0, 0, 100, 0, 7000, 9000, 17800, 20200, 0, 0, 11, 49678, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Drudge - In Combat - Cast \'Flesh Rot\''),
    (30984, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3098900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Drudge - On Just Summoned - Run Script'),
    -- Reanimated Captain
    (30986, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 32674, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - On Aggro - Cast \'Avenger\'s Shield\' (No Repeat)'),
    (30986, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 17800, 19800, 0, 0, 11, 58154, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - In Combat - Cast \'Hammer of Injustice\''),
    (30986, 0, 2, 0, 2, 0, 100, 1, 0, 45, 0, 0, 0, 0, 11, 58153, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - Between 0-45% Health - Cast \'Unholy Light\' (No Repeat)'),
    (30986, 0, 3, 0, 14, 0, 100, 0, 4000, 10, 20000, 30000, 0, 0, 11, 58153, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - Friendly At 4000 Health - Cast \'Unholy Light\''),
    (30986, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3098900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Captain - On Just Summoned - Run Script'),
    -- Hideous Plaguebringer
    (30987, 0, 0, 0, 0, 0, 100, 0, 3400, 4600, 11400, 16500, 0, 0, 11, 38761, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hideous Plaguebringer - In Combat - Cast \'Arcing Smash\''),
    (30987, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3098900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hideous Plaguebringer - On Just Summoned - Run Script'),
    -- Halof the Deathbringer
    (30989, 0, 0, 0, 0, 0, 100, 0, 0, 5500, 5500, 11400, 0, 0, 11, 49895, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Halof the Deathbringer - In Combat - Cast \'Death Coil\''),
    (30989, 0, 1, 0, 0, 0, 100, 0, 2600, 5700, 8500, 13400, 0, 0, 11, 49941, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Halof the Deathbringer - In Combat - Cast \'Blood Boil\''),
    (30989, 0, 2, 0, 0, 0, 100, 0, 7300, 8700, 10300, 10400, 0, 0, 11, 49909, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Halof the Deathbringer - In Combat - Cast \'Icy Touch\''),
    (30989, 0, 3, 0, 0, 0, 100, 0, 5000, 5300, 5100, 5300, 0, 0, 11, 51425, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Halof the Deathbringer - In Combat - Cast \'Obliterate\''),
    (30989, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3098900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Halof the Deathbringer - On Just Summoned - Run Script');
