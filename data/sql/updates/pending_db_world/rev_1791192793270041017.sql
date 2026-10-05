--
DELETE FROM `creature_text` WHERE `CreatureID` = 20723 AND `GroupID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20723, 0, 0, 'Ohh, look! Bloodmaul Brew! Mmmm...', 12, 0, 100, 0, 0, 0, 18170, 0, 'Korgaah - Lured by Bloodmaul Brutebane Stout'),
(20723, 0, 1, 'Mmm. Me thirsty!', 12, 0, 100, 0, 0, 0, 18172, 0, 'Korgaah - Lured by Bloodmaul Brutebane Stout'),
(20723, 0, 2, 'Bloodmaul Brew? Me favorite!', 12, 0, 100, 0, 0, 0, 18171, 0, 'Korgaah - Lured by Bloodmaul Brutebane Stout');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 21241 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21241, 0, 0, 1, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Brutebane Stout Trigger - On Just Summoned - Store Targetlist'),
(21241, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 19995, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Brutebane Stout Trigger - On Just Summoned - Send Target List to Bladespire Brute'),
(21241, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 19995, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Brutebane Stout Trigger - On Just Summoned - Set Data to Bladespire Brute'),
(21241, 0, 3, 4, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Brutebane Stout Trigger - On Just Summoned - Store Targetlist'),
(21241, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 20723, 30, 0, 0, 0, 0, 0, 0, 'Bloodmaul Brutebane Stout Trigger - On Just Summoned - Send Target List to Korgaah'),
(21241, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 20723, 30, 0, 0, 0, 0, 0, 0, 'Bloodmaul Brutebane Stout Trigger - On Just Summoned - Set Data to Korgaah');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` IN (1, 4) AND `SourceEntry` = 21241 AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 21241, 0, 0, 29, 1, 20723, 30, 0, 1, 0, 0, '', 'Bloodmaul Brutebane Stout Trigger - Lure a Bladespire Brute only if no living Korgaah is within 30 yards'),
(22, 4, 21241, 0, 0, 29, 1, 20723, 30, 0, 0, 0, 0, '', 'Bloodmaul Brutebane Stout Trigger - Lure Korgaah only if he is alive within 30 yards');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 4 AND `SourceEntry` = 20723 AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 4, 20723, 0, 0, 106, 1, 0, 0, 0, 1, 0, 0, '', 'Korgaah - React to a Bloodmaul Brutebane Stout only out of combat');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 20723 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20723, 0, 0, 0, 105, 0, 25, 0, 3500, 4000, 10500, 12000, 0, 5, 11, 11978, 32, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - In Combat - Cast \'11978\''),
(20723, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 0, 0, 11, 23600, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Between 20-80% Health - Cast \'23600\' (No Repeat)'),
(20723, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 0, 0, 11, 8599, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Between 10-30% Health - Cast \'8599\' (No Repeat)'),
(20723, 0, 3, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 0, 80, 2072301, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - On Data Set 1 1 - Run Script'),
(20723, 0, 4, 5, 75, 1, 100, 512, 0, 21241, 5, 5000, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - On Creature Range - Set Phase 2'),
(20723, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2072300, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - On Creature Range - Run Script'),
(20723, 0, 6, 0, 4, 3, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2072302, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - On Aggro - Run Script (Phase 1 or 2)');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2072300, 2072301, 2072302) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2072300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 21241, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Despawn Trigger'),
(2072300, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 36421, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Cast \'Bloodmaul Brutebane Brew Kill Credit\''),
(2072300, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Play Emote OneShotKneel (16)'),
(2072300, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 70, 300, 0, 0, 0, 0, 0, 20, 184315, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Despawn GO'),
(2072300, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Play Emote OneShotEatNoSheathe'),
(2072300, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Play Emote OneShotEatNoSheathe'),
(2072300, 9, 6, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Play Emote OneShotEatNoSheathe'),
(2072300, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Play Emote OneShotEatNoSheathe'),
(2072300, 9, 8, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Play Emote OneShotEatNoSheathe'),
(2072300, 9, 9, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Play Emote OneShotEatNoSheathe'),
(2072300, 9, 10, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Play Emote OneShotEatNoSheathe'),
(2072300, 9, 11, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Play Emote OneShotEatNoSheathe'),
(2072300, 9, 12, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Play Emote OneShotEatNoSheathe'),
(2072300, 9, 13, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Play Emote OneShotEatNoSheathe'),
(2072300, 9, 14, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 35240, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Cast \'Bloodmaul Intoxication\''),
(2072300, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 93, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Set Emote State 93'),
(2072300, 9, 16, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Set Emote State 0'),
(2072300, 9, 17, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Set Reactstate Aggressive'),
(2072300, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Evade'),
(2072301, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Set Reactstate Defensive'),
(2072301, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Set Phase 1'),
(2072301, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Say Line 0'),
(2072301, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 19, 21241, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Move to Bloodmaul Brutebane Stout Trigger'),
(2072302, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Set Emote State 0'),
(2072302, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Set Phase 0'),
(2072302, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korgaah - Actionlist - Set Reactstate Aggressive');
