-- DB update 2024_11_13_03 -> 2024_11_13_04
-- Field Marshal Rohamus smart ai
SET @ENTRY := 19316;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 1, 1, 0, 100, 0, 0, 0, 81000, 85000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Field Marshal Rohamus - Out of Combat - Say Line 0'),
(@ENTRY, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Field Marshal Rohamus - Out of Combat - Create Timed Event'),
(@ENTRY, 0, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 5, 275, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Field Marshal Rohamus - On Timed Event 1 Triggered - Play Emote ONESHOT_TRAIN(DNR) (275)');

DELETE FROM `creature_text` WHERE `CreatureID` = 19316;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(19316, 0, 0, 'Tear it down, soldiers! We\'re shippin\' this thing back to Stormwind!', 12, 7, 100, 22, 0, 0, 16576, 0, 'Field Marshal Rohamus'),
(19316, 0, 1, 'We\'re gonna melt this hunk of junk down and make weapons with the ingots! Let\'s see how the Legion likes a taste of fel reaver served up Alliance style!', 12, 7, 100, 22, 0, 0, 16577, 0, 'Field Marshal Rohamus'),
(19316, 0, 2, 'Well done, soldiers! We weren\'t about to let the filthy animals of the Horde show us up!', 12, 7, 100, 22, 0, 0, 16578, 0, 'Field Marshal Rohamus'),
(19316, 0, 3, 'Let them throw another one of these overgrown tin cans at us! We\'ll show them what the Alliance is made of!', 12, 7, 100, 22, 0, 0, 16579, 0, 'Field Marshal Rohamus');
