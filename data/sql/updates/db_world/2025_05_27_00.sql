-- DB update 2025_05_26_00 -> 2025_05_27_00
-- 30695 (Portal Keeper)
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (58529,58532);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(58529, 58529, 61592, 0, 0),
(58532, 58532, 61594, 0, 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30695);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30695, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 6000, 8000, 0, 0, 11, 58529, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Portal Keeper - In Combat - Cast \'Arcane Missiles\''),
(30695, 0, 1, 0, 0, 0, 100, 0, 13000, 19000, 13000, 19000, 0, 0, 11, 58532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Portal Keeper - In Combat - Cast \'Frostbolt Volley\''),
(30695, 0, 2, 0, 0, 0, 100, 0, 6000, 9000, 9000, 14000, 0, 0, 11, 58534, 64, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Portal Keeper - In Combat - Cast \'Deep Freeze\'');
