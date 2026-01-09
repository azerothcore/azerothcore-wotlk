-- DB update 2024_06_20_05 -> 2024_06_20_06
--
DELETE FROM `creature_text` WHERE `CreatureID` = 15076 AND `ID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15076, 0, 0, 'The Blood God, the Soulflayer, has been defeated!  We are imperiled no longer!', 14, 0, 100, 5, 0, 0, 10612, 1, 'Zandalarian Emissary');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15076;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 15076;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15076, 0, 0, 1, 38, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Zandalarian Emissary - On Data Set 0 0 - Say Line 0'),
(15076, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 0, 50000, 50000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Zandalarian Emissary - On Data Set 0 0 - Create Timed Event'),
(15076, 0, 2, 0, 59, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 24425, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zandalarian Emissary - On Timed Event 0 Triggered - Cast \'Spirit of Zandalar\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 4) AND (`SourceEntry` = 24425);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 4, 24425, 0, 0, 27, 0, 63, 4, 0, 0, 0, 0, '', 'Spirit of Zandalar - Player must be level 63 or lower');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14875) AND (`source_type` = 0) AND (`id` IN (1, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14875, 0, 1, 4, 20, 0, 100, 512, 8183, 0, 0, 0, 0, 0, 53, 0, 14875, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Molthor - On Quest \'The Heart of Hakkar\' Finished - Start Waypoint'),
(14875, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 0, 0, 0, 0, 0, 10, 436, 15076, 0, 0, 0, 0, 0, 0, 'Molthor - On Quest \'The Heart of Hakkar\' Finished - Set Data 0 0');
