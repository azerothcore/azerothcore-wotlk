SET
@sunwellnone         = 116,
@sunwellfirst        = 117,
@sunwellsecond       = 118,
@sunwellall          = 119;

-- Vindicator Moorba
-- move menuID entries and conditions from 51004 to 9293 `creature_template.gossip_menu_id`
UPDATE `gossip_menu` SET `MenuID` = 9293 WHERE `MenuID` = 51004 AND `TextID` IN (12602, 12603, 12605);
UPDATE `conditions` SET `SourceGroup` = 9293 WHERE SourceGroup = 51004 AND SourceEntry IN (12602, 12603, 12605) AND `ConditionTypeOrReference` = 12 AND `ConditionValue1` IN (@sunwellnone, @sunwellfirst, @sunwellsecond);

DELETE FROM `conditions` WHERE `ConditionTypeOrReference` = 12 AND `ConditionValue1` IN (@sunwellall) AND `SourceGroup` IN (9307, 9293) AND `SourceEntry` IN (12623, 12604);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Exarch Nasuun (Shattrath)
(14, 9307, 12623, 0, 0, 12, 0, @sunwellall,       0, 0, 0, 0, 0, '', 'Show gossip text if the event ''SWP - All Gates Open'' is active'),
-- Vindicator Moorba (SWP)
(14, 9293, 12604, 0, 0, 12, 0, @sunwellall,       0, 0, 0, 0, 0, '', 'Show gossip text if the event ''SWP - All Gates Open'' is active');

SET @ENTRY := 20780;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryOrGuid` IN (@ENTRY * 100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 1, 0, 100, 0, 0, 0, 74000, 105000, 0, 0, 80, @ENTRY * 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan - Out of Combat - Run Script'),
(@ENTRY * 100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan - Actionlist - Say Line 0'),
(@ENTRY * 100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 35746, 0, 0, 0, 0, 0, 19, 20922, 10, 0, 0, 0, 0, 0, 'Kaylaan - Actionlist - Cast \'Resurrection\''),
(@ENTRY * 100, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan - Actionlist - Say Line 1');
