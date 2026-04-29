-- DB update 2026_01_26_01 -> 2026_01_26_02
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20040);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20040, 0, 0, 0, 0, 0, 100, 0, 20950, 25000, 17000, 29900, 0, 0, 11, 37102, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - In Combat - Cast \'Knock Away\''),
(20040, 0, 1, 0, 0, 1, 100, 0, 20000, 30000, 20000, 30000, 0, 0, 11, 35035, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - In Combat - Start Countercharge Phase (Phase 1)'),
(20040, 0, 2, 0, 8, 1, 100, 0, 35035, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - On Spell \'Countercharge\' Successful - Enter Countercharge Phase'),
(20040, 0, 3, 6, 105, 2, 10, 0, 3600, 3600, 3600, 3600, 0, 50, 11, 35039, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - On Hostile Casting in Range - Cast \'Countercharge\' if I have a Charge (Phase 2)'),
(20040, 0, 4, 5, 8, 0, 100, 512, 34946, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - On Spellhit \'Golem Repair\' - Store Targetlist'),
(20040, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2004000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - On Spellhit \'Golem Repair\' - Run Script'),
(20040, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 35035, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - On Hostile Casting in Range - If Interrupt Successful, Remove Charge'),
(20040, 0, 7, 0, 0, 2, 50, 0, 1000, 1000, 1000, 1000, 0, 0, 11, 35035, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - In Combat, Every 1000ms - Refresh Charge on Self (Phase 2)'),
(20040, 0, 8, 0, 0, 2, 100, 0, 15000, 15000, 15000, 15000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - In Combat - After 15s, Return to Initial Phase (Phase 2)'),
(20040, 0, 9, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - On Aggro - Set Initial Phase');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceEntry` = 20040) AND (`ConditionTypeOrReference` = 1) AND (`ConditionValue1` = 35035);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 8, 20040, 0, 0, 1, 1, 35035, 0, 0, 1, 0, 0, '', 'Only Refresh Countercharge (35035) Aura if it is not already present'),
(22, 4, 20040, 0, 0, 1, 1, 35035, 0, 0, 0, 0, 0, '', 'Only Interrupt if Crystalcore Devastator has a charge of Countercharge (35035) to spend');

DELETE FROM `spell_script_names` WHERE `spell_id` = 35035 AND `ScriptName` = 'spell_the_eye_countercharge_aura';
