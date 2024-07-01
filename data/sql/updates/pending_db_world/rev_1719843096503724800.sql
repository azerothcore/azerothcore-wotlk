--
DELETE FROM `creature_text` WHERE (`CreatureID` = 21894);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(21894, 0, 0, 'Who disturbs my slumber?  That spear... I still carry the scar!', 14, 0, 100, 0, 0, 0, 19599, 0, 'Xeleth - Yell on summon');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21894;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21894);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21894, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Xeleth - On Just Summoned - Say Line 0'),
(21894, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Xeleth - On Just Summoned - Start Attacking'),
(21894, 0, 2, 0, 0, 0, 100, 0, 0, 0, 14000, 16000, 0, 0, 11, 36414, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Xeleth - In Combat - Cast \'Focused Bursts\''),
(21894, 0, 3, 0, 0, 0, 75, 0, 8000, 14000, 8000, 14000, 0, 0, 11, 36398, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Xeleth - In Combat - Cast \'Tongue Lash\' (75%)');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 37904);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 37904, 0, 0, 29, 0, 21894, 80, 0, 1, 0, 0, '', 'Allow using \'Imbued Silver Spear\' if no alive \'Xeleth\' is within 80y.');
