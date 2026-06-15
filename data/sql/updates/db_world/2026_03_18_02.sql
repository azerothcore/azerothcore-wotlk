-- DB update 2026_03_18_01 -> 2026_03_18_02
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` = 49838;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13, 1, 49838, 0, 1, 31, 0, 3, 28236, 0, 0, 0, '', 'Stop Time can hit Azure Ring Captain'),
(13, 1, 49838, 0, 2, 31, 0, 3, 27638, 0, 0, 0, '', 'Stop Time can hit Azure Ring Guardian'),
(13, 1, 49838, 0, 3, 31, 0, 3, 28276, 0, 0, 0, '', 'Stop Time can hit Greater Lay Whelp'),
(13, 1, 49838, 0, 4, 31, 0, 3, 27656, 0, 0, 0, '', 'Stop Time can hit Eregos');
