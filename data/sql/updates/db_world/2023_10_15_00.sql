-- DB update 2023_10_12_04 -> 2023_10_15_00
-- Paelarin
DELETE FROM `gossip_menu` WHERE (`MenuID` = 7311) AND (`TextID` IN (8679));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(7311, 8679);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 7311) AND (`SourceEntry` = 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 7311) AND (`SourceEntry` = 8679);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 7311, 0, 0, 0, 16, 0, 128, 0, 0, 1, 0, 0, '', 'Show gossip menu 7311 option 0 only if player is not a troll.'),
(14, 7311, 8679, 0, 0, 16, 0, 128, 0, 0, 0, 0, 0, '', 'Show gossip menu 7311, npc text 8679 only if player race is a troll.');
