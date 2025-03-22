-- DB update 2025_02_09_00 -> 2025_02_09_01
--
SET
@sunwellnone         = 116,
@sunwellfirst        = 117,
@sunwellsecond       = 118,
@sunwellall          = 119;

-- Vindicator Moorba
-- move menuID entries and conditions from 51004 to 9293 `creature_template.gossip_menu_id`
UPDATE `gossip_menu` SET `MenuID` = 9293 WHERE `MenuID` = 51004 AND `TextID` IN (12602, 12603, 12605);
UPDATE `conditions` SET `SourceGroup` = 9293 WHERE `SourceGroup` = 51004 AND `SourceEntry` IN (12602, 12603, 12605) AND `ConditionTypeOrReference` = 12 AND `ConditionValue1` IN (@sunwellnone, @sunwellfirst, @sunwellsecond);

DELETE FROM `conditions` WHERE `ConditionTypeOrReference` = 12 AND `ConditionValue1` IN (@sunwellall) AND `SourceGroup` IN (9307, 9293) AND `SourceEntry` IN (12623, 12604);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Exarch Nasuun (Shattrath)
(14, 9307, 12623, 0, 0, 12, 0, @sunwellall,       0, 0, 0, 0, 0, '', 'Show gossip text if the event ''SWP - All Gates Open'' is active'),
-- Vindicator Moorba (SWP)
(14, 9293, 12604, 0, 0, 12, 0, @sunwellall,       0, 0, 0, 0, 0, '', 'Show gossip text if the event ''SWP - All Gates Open'' is active');
