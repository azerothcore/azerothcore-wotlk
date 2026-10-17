-- DB update 2025_09_12_03 -> 2025_09_12_04
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 23301 AND `ConditionTypeOrReference` IN (30, 104);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 23301, 0, 0, 104, 1, 1, 1, 0, 1, 0, 0, '', 'Require Ebon Blade Banner NOT used on body (set in AI data)'),
(17, 0, 23301, 0, 1, 104, 1, 1, 1, 0, 1, 0, 0, '', 'Require Ebon Blade Banner NOT used on body (set in AI data)'),
(17, 0, 23301, 0, 2, 104, 1, 1, 1, 0, 1, 0, 0, '', 'Require Ebon Blade Banner NOT used on body (set in AI data)'),
(17, 0, 23301, 0, 3, 104, 1, 1, 1, 0, 1, 0, 0, '', 'Require Ebon Blade Banner NOT used on body (set in AI data)');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29880) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29880, 0, 0, 0, 0, 0, 100, 512, 0, 0, 30000, 30000, 0, 0, 11, 23262, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Jotunheim Warrior - In Combat - Cast \'Demoralize\''),
(29880, 0, 1, 0, 0, 0, 100, 512, 2000, 3000, 5000, 7000, 0, 0, 11, 43410, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Jotunheim Warrior - In Combat - Cast \'Chop\''),
(29880, 0, 2, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 33, 30644, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Jotunheim Warrior - On Just Died - Quest Credit \'null\''),
(29880, 0, 3, 0, 4, 0, 66, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jotunheim Warrior - On Aggro - Say Line 0'),
(29880, 0, 4, 5, 8, 0, 100, 512, 23301, 0, 0, 0, 0, 0, 33, 30220, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Jotunheim Warrior - On Spellhit \'Ebon Blade Banner\' - Quest Credit \'null\''),
(29880, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jotunheim Warrior - On Spellhit \'Ebon Blade Banner\' - Set Data 1 1');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30037) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30037, 0, 0, 3, 8, 0, 100, 512, 23301, 0, 0, 0, 0, 0, 33, 30220, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spellhit \'Ebon Blade Banner\' - Quest Credit \'null\''),
(30037, 0, 1, 0, 1, 1, 100, 0, 0, 1000, 1500, 2500, 0, 0, 10, 35, 36, 39, 43, 0, 0, 11, 30037, 5, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - Out of Combat - Play Random Emote (35, 36, 39, 43) (Phase 1)'),
(30037, 0, 2, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Reset - Set Event Phase 1'),
(30037, 0, 10, 11, 8, 1, 100, 512, 21855, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 11, 30037, 5, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spellhit \'Challenge Flag\' - Set Data 1 0 (Phase 1)'),
(30037, 0, 11, 12, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 30037, 5, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spellhit \'Challenge Flag\' - Despawn Instant (Phase 1)'),
(30037, 0, 12, 13, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spellhit \'Challenge Flag\' - Set Emote State 0 (Phase 1)'),
(30037, 0, 13, 14, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spellhit \'Challenge Flag\' - Set Orientation Invoker (Phase 1)'),
(30037, 0, 14, 15, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 52682, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spellhit \'Challenge Flag\' - Cast \'Honor Challenge: Summon Challenge Flag Object\' (Phase 1)'),
(30037, 0, 15, 16, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spellhit \'Challenge Flag\' - Set Event Phase 2 (Phase 1)'),
(30037, 0, 16, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 67, 1, 1000, 1000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spellhit \'Challenge Flag\' - Create Timed Event (Phase 1)'),
(30037, 0, 17, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Timed Event 1 Triggered - Say Line 0'),
(30037, 0, 18, 0, 38, 0, 100, 512, 1, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Data Set 1 0 - Set Event Phase 2'),
(30037, 0, 20, 0, 6, 2, 100, 512, 0, 0, 0, 0, 0, 0, 33, 30038, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Just Died - Quest Credit \'null\' (Phase 2)'),
(30037, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spellhit \'Ebon Blade Banner\' - Set Data 1 1');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30243) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30243, 0, 0, 0, 0, 0, 100, 512, 2000, 3000, 3000, 4000, 0, 0, 11, 38029, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Njorndar Spear-Sister - In Combat - Cast \'Stab\''),
(30243, 0, 1, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 33, 30644, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Njorndar Spear-Sister - On Just Died - Quest Credit \'null\''),
(30243, 0, 2, 0, 4, 0, 66, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Njorndar Spear-Sister - On Aggro - Say Line 0'),
(30243, 0, 3, 4, 8, 0, 100, 512, 23301, 0, 0, 0, 0, 0, 33, 30220, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Njorndar Spear-Sister - On Spellhit \'Ebon Blade Banner\' - Quest Credit \'null\''),
(30243, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Njorndar Spear-Sister - On Spellhit \'Ebon Blade Banner\' - Set Data 1 1');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30632) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30632, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 7855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Water Magus - On Reset - Cast \'Summon Water Terror\''),
(30632, 0, 1, 0, 0, 0, 100, 0, 0, 0, 3000, 4000, 0, 0, 11, 9672, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Water Magus - In Combat - Cast \'Frostbolt\''),
(30632, 0, 2, 0, 106, 0, 100, 0, 3000, 3000, 7000, 9000, 0, 10, 11, 15532, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Water Magus - On Hostile in Range - Cast \'Frost Nova\''),
(30632, 0, 3, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 33, 30644, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Water Magus - On Just Died - Quest Credit \'null\''),
(30632, 0, 4, 0, 4, 0, 66, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Water Magus - On Aggro - Say Line 0'),
(30632, 0, 5, 6, 8, 0, 100, 512, 23301, 0, 0, 0, 0, 0, 33, 30220, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Water Magus - On Spellhit \'Ebon Blade Banner\' - Quest Credit \'null\''),
(30632, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Water Magus - On Spellhit \'Ebon Blade Banner\' - Set Data 1 1');
