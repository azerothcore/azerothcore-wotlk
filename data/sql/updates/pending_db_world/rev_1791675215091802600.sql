-- 66319 Summon Fire Bomb (serverside): summons a Fire Bomb for 35s at the Fire Bomb's impact point
UPDATE `spell_dbc` SET `DurationIndex` = 125, `Effect_1` = 28, `ImplicitTargetA_1` = 6, `ImplicitTargetB_1` = 53, `EffectMiscValue_1` = 34854, `EffectMiscValueB_1` = 64 WHERE `ID` = 66319;

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 34854;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 34854 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(34854, 0, 0, 1, 63, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fire Bomb - On Just Created - Set Reactstate Passive'),
(34854, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 66318, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fire Bomb - On Just Created - Cast ''Fire Bomb''');
