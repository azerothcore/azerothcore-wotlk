--
DELETE FROM `areatrigger_scripts` WHERE `entry` = 4963;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (4963, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE (`source_type` = 2 AND `entryorguid` = 4963);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4963, 2, 0, 0, 46, 0, 100, 0, 4963, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 107121, 25465, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Kel\'Thuzad Say Line');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25465) AND (`source_type` = 0) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25465, 0, 3, 0, 38, 0, 100, 0, 1, 1, 60000, 60000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - On Data Set from AreaTrigger 4963 - Say Line');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 4963) AND (`SourceId` = 2) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 47) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 11652) AND (`ConditionValue2` = 10) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 4963, 2, 0, 47, 0, 11652, 10, 0, 0, 0, 0, '', 'Kel\'Thuzad in Plains of Nasam only talks if the player is on the quest');

DELETE FROM `creature_text` WHERE (`CreatureID` = 27106);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27106, 0, 0, 'I will protect you, friend!', 12, 1, 100, 0, 0, 0, 26173, 0, 'Injured Warsong Warrior - Picked Up');

DELETE FROM `creature_text` WHERE (`CreatureID` = 27107);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27107, 0, 0, 'Thank you, friend. Now these beasts shall feel the fury of the Sunwell!', 12, 1, 100, 0, 0, 0, 26174, 0, 'Injured Warsong Mage - Picked Up');

DELETE FROM `creature_text` WHERE (`CreatureID` = 27110);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27110, 0, 0, 'Thanks, buddy! Let\'s see if I can\'t get this hunk o\' junk movin\' faster!', 12, 1, 100, 0, 0, 0, 26172, 0, 'Injured Warsong Engineer - Picked Up');

-- Shaman has NO text it seems