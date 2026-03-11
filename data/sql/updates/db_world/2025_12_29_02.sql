-- DB update 2025_12_29_01 -> 2025_12_29_02
--
DELETE FROM `spelldifficulty_dbc` WHERE `ID`=54095;
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(54095, 54095, 54096, 0, 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16506);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16506, 0, 0, 0, 0, 0, 70, 0, 3000, 5000, 2500, 2500, 0, 0, 11, 54095, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Naxxramas Worshipper - In Combat - Cast \'Fireball\''),
(16506, 0, 1, 0, 6, 0, 100, 2, 0, 0, 0, 0, 0, 0, 11, 28732, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naxxramas Worshipper - On Just Died - Cast \'Widow`s Embrace\' (Normal Dungeon)'),
(16506, 0, 2, 0, 5, 0, 100, 512, 0, 0, 1, 0, 0, 0, 34, 119, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naxxramas Worshipper - On Killed Unit - Set Instance Data 119 to 0'),
(16506, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naxxramas Worshipper - On Aggro - Call For Help');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16505);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16505, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 16000, 21000, 0, 0, 11, 56107, 0, 0, 0, 0, 0, 17, 7, 40, 0, 0, 0, 0, 0, 0, 'Naxxramas Follower - In Combat - Cast \'Berserker Charge\''),
(16505, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 11000, 15000, 0, 0, 11, 54093, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naxxramas Follower - In Combat - Cast \'Silence\''),
(16505, 0, 2, 0, 5, 0, 100, 512, 0, 0, 1, 0, 0, 0, 34, 119, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naxxramas Follower - On Killed Unit - Set Instance Data 119 to 0'),
(16505, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naxxramas Follower - On Aggro - Call For Help');

DELETE FROM `creature_formations` WHERE `memberGUID` IN (127800, 127987, 127988, 127989, 127990, 127991, 127992, 127993, 127994, 127995, 127996, 127997, 127998, 127999, 128000, 128001, 128019, 128020, 128021, 128022, 128023, 128024, 128025, 128026, 128027, 128028, 128029, 128030, 128031, 128032, 128033, 128034, 128035);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `groupAI`) VALUES
(127800, 127800, 1),
(127800, 127987, 1),
(127800, 127988, 1),
(127800, 127989, 1),
(127800, 127990, 1),
(127800, 127991, 1),
(127800, 127992, 1),
(127800, 127993, 1),
(127800, 127994, 1),
(127800, 127995, 1),
(127800, 127996, 1),
(127800, 127997, 1),
(127800, 127998, 1),
(127800, 127999, 1),
(127800, 128000, 1),
(127800, 128001, 1),
(127800, 128019, 1),
(127800, 128020, 1),
(127800, 128021, 1),
(127800, 128022, 1),
(127800, 128023, 1),
(127800, 128024, 1),
(127800, 128025, 1),
(127800, 128026, 1),
(127800, 128027, 1),
(127800, 128028, 1),
(127800, 128029, 1),
(127800, 128030, 1),
(127800, 128031, 1),
(127800, 128032, 1),
(127800, 128033, 1),
(127800, 128034, 1),
(127800, 128035, 1);
