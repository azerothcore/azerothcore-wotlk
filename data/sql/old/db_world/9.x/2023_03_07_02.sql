-- DB update 2023_03_07_01 -> 2023_03_07_02
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` IN (10641, 10668, 10669);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 10641, 0, 1, 47, 0, 10640, 64, 0, 0, 0, 0, '', 'Against the Legion - Require Quest 10640 OR 10689'),
(19, 0, 10669, 0, 1, 47, 0, 10640, 64, 0, 0, 0, 0, '', 'Against All Odds - Require Quest 10640 OR 10689'),
(19, 0, 10668, 0, 1, 47, 0, 10640, 64, 0, 0, 0, 0, '', 'Against the Illidari - Require Quest 10640 OR 10689'),
(19, 0, 10641, 0, 2, 47, 0, 10689, 64, 0, 0, 0, 0, '', 'Against the Legion - Require Quest 10640 OR 10689'),
(19, 0, 10668, 0, 2, 47, 0, 10689, 64, 0, 0, 0, 0, '', 'Against the Illidari - Require Quest 10640 OR 10689'),
(19, 0, 10669, 0, 2, 47, 0, 10689, 64, 0, 0, 0, 0, '', 'Against All Odds - Require Quest 10640 OR 10689');

UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` IN (10641, 10668, 10669);
UPDATE `quest_template_addon` SET `NextQuestID` = 0 WHERE `NextQuestID` IN (10641, 10668, 10669);
