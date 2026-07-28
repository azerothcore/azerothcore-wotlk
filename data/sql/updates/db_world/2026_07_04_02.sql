-- DB update 2026_07_04_01 -> 2026_07_04_02

-- Register Rain of Darkness Spell Script.
DELETE FROM `spell_script_names` WHERE `spell_id` = 51761;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(51761, 'spell_q12641_rain_of_darkness');

-- Delete Personal SAI guid row (Pause Movement and Movement Resume).
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`id` IN (9, 10)) AND (`entryorguid` IN (-128958, -128959, -128960, -128961, -128962, -128963, -128964, -128965, -128966, -128967, -128968, -128970, -128973, -128976, -128978, -128979, -128980, -128981, -128986, -128991, -128992, -128993, -128910, -128911, -128912, -128913, -128914, -128915, -128916, -128917, -128918, -128919, -128920, -128922, -128924, -128926, -128927, -128928, -128929, -128930, -128934, -128935, -128948, -128954));

-- Remove Rain of Darkness Dummies from map.
DELETE FROM `creature` WHERE `id` = 28643;

-- Set Rain of Darkness Dummy Movement Flags.
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 28643);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(28643, 0, 0, 1, 1, 0, 0, 0);

-- Set Rain of Darkness Dummy SAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28643;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28643);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28643, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52149, 2, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Rain of Darkness Dummy - On Just Summoned - Cast \'Rain of Darkness\'');

-- Update Citizen of Havenshire Action Lists.
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2857600, 2857700));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2857600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51604, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - Actionlist - Cast \'Serverside - Stun Self\''),
(2857600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - Actionlist - Play Emote 5'),
(2857600, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4, 14561, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - Actionlist - Play Sound 14561'),
(2857600, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - Actionlist - Say Line 1'),
(2857600, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 17, 431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - Actionlist - Set Emote State 431'),
(2857700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51604, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - Actionlist - Cast \'Serverside - Stun Self\''),
(2857700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - Actionlist - Play Emote 5'),
(2857700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4, 14564, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - Actionlist - Play Sound 14564'),
(2857700, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - Actionlist - Say Line 1'),
(2857700, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 17, 431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - Actionlist - Set Emote State 431');

-- Update Citizen of Havenshire SAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (28576, 28577));

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (28576, 28577)) AND (`source_type` = 0) AND (`id` IN (5, 9));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28576, 0, 5, 0, 1, 0, 30, 0, 5000, 20000, 5000, 20000, 0, 0, 11, 51761, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - Out of Combat - Cast \'Rain of Darkness\''),
(28576, 0, 9, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - On Aggro - Set Reactstate Aggressive'),
(28577, 0, 5, 0, 1, 0, 30, 0, 5000, 20000, 5000, 20000, 0, 0, 11, 51761, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - Out of Combat - Cast \'Rain of Darkness\''),
(28577, 0, 9, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - On Aggro - Set Reactstate Aggressive');

-- Remove old condition (it wasn't used in any case).
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 9) AND (`SourceEntry` = 28576) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 14) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 12678) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);

-- Add Conditions to trigger Citizen of Havenshire Smart Events.
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 3) AND (`SourceEntry` IN (28576, 28577)) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 47) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 12678) AND (`ConditionValue2` = 10) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 3, 28576, 0, 0, 47, 0, 12678, 10, 0, 0, 0, 0, '', 'Smart Event only occurs if player has quest 12678 in progress or completed.'),
(22, 3, 28577, 0, 0, 47, 0, 12678, 10, 0, 0, 0, 0, '', 'Smart Event only occurs if player has quest 12678 in progress or completed.');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 10) AND (`SourceEntry` IN (28576, 28577)) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 10, 28576, 0, 1, 32, 0, 16, 0, 0, 0, 0, 0, '', 'Smart Event starts it Invoker is a Player.'),
(22, 10, 28576, 0, 1, 47, 0, 12678, 65, 0, 0, 0, 0, '', 'Smart Event starts if Player doesn\'t have quest 12678 in its quest log.'),
(22, 10, 28577, 0, 1, 32, 0, 16, 0, 0, 0, 0, 0, '', 'Smart Event starts it Invoker is a Player.'),
(22, 10, 28577, 0, 1, 47, 0, 12678, 65, 0, 0, 0, 0, '', 'Smart Event starts if Player doesn\'t have quest 12678 in its quest log.'),
(22, 10, 28576, 0, 2, 32, 0, 16, 0, 0, 1, 0, 0, '', 'Smart Event starts if Invoker is NOT a Player.'),
(22, 10, 28577, 0, 2, 32, 0, 16, 0, 0, 1, 0, 0, '', 'Smart Event starts if Invoker is NOT a Player.');
