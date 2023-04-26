-- DB update 2022_11_21_13 -> 2022_11_21_14
--
-- Update effects from classic to the summoning spell
UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64 WHERE (`ID` = 33903);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19188) AND (`source_type` = 0) AND (`id` IN (3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19188, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Raging Colossus - Between 0-20% Health - Say Line 0 (No Repeat)'),
(19188, 0, 4, 0, 2, 0, 100, 1, 0, 75, 0, 0, 0, 11, 33903, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Raging Colossus - Between 0-75% Health - Cast \'Serverside - Summon Crystalhide Rageling\' (No Repeat)'),
(19188, 0, 5, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 11, 33903, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Raging Colossus - Between 0-50% Health - Cast \'Serverside - Summon Crystalhide Rageling\' (No Repeat)'),
(19188, 0, 6, 0, 2, 0, 100, 1, 0, 25, 0, 0, 0, 11, 33903, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Raging Colossus - Between 0-25% Health - Cast \'Serverside - Summon Crystalhide Rageling\' (No Repeat)');
