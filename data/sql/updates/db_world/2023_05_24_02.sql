-- DB update 2023_05_24_01 -> 2023_05_24_02
--
-- Blackrock Summoner
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 9818);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9818, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 12380, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackhand Summoner - On Reset - Cast \'Shadow Channeling\' (Phase 1) (Normal Dungeon)'),
(9818, 0, 1, 0, 4, 0, 100, 2, 0, 0, 0, 0, 0, 39, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackhand Summoner - On Aggro - Call For Help (Normal Dungeon)'),
(9818, 0, 2, 0, 4, 0, 100, 3, 0, 0, 0, 0, 0, 87, 981800, 981801, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackhand Summoner - On Aggro - Summon Random Enemy (No Repeat) (Normal Dungeon)'),
(9818, 0, 3, 0, 0, 0, 100, 2, 50, 100, 3600, 6300, 0, 11, 12466, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackhand Summoner - In Combat - Cast \'Fireball\' (Normal Dungeon)'),
(9818, 0, 4, 0, 0, 0, 100, 2, 11400, 11400, 12700, 16700, 0, 11, 15532, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackhand Summoner - In Combat - Cast \'Frost Nova\' (Normal Dungeon)'),
(9818, 0, 5, 0, 2, 0, 100, 3, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackhand Summoner - Between 0-15% Health - Flee For Assist (No Repeat) (Normal Dungeon)'),
(9818, 0, 6, 0, 1, 0, 100, 2, 0, 8000, 12000, 14000, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackhand Summoner - Out of Combat - Play Emote 1 (No Repeat) (Normal Dungeon)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (981800, 981801));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(981800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 15792, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackhand Summoner - ActionList - Cast \'Summon Blackhand Veteran\' (No Repeat) (Normal Dungeon)'),
(981800, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackhand Summoner - ActionList - Say Line 0 (No Repeat) (Normal Dungeon)'),
(981801, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 15794, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackhand Summoner - ActionList - Cast \'Summon Blackhand Dreadweaver\' (No Repeat) (Normal Dungeon)'),
(981801, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackhand Summoner - ActionList - Say Line 1 (No Repeat) (Normal Dungeon)');

