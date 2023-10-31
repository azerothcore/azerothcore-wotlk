-- DB update 2023_10_10_09 -> 2023_10_10_10
-- Mrs. Dalson's Diary
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 1) AND (`SourceGroup` = 10816) AND (`SourceEntry` = 12738);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 3001) AND (`SourceEntry` = 3694);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 10816, 12738, 0, 0, 8, 0, 5058, 0, 0, 0, 0, 0, '', 'Drop Dalson Outhouse Key from Wandering Skeletons only if quest Mrs. Dalson\'s Diary has been rewarded.'),
(14, 3001, 3694, 0, 0, 8, 0, 5058, 0, 0, 0, 0, 0, '', 'Show Mrs. Dalson\'s Diary\'s gossip menu only if quest Mrs. Dalson\'s Diary has been rewarded.');
-- Repeatable flag (also messes with condition quest_rewarded for some reason)
UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags`&~1 WHERE (`ID` = 5058);
