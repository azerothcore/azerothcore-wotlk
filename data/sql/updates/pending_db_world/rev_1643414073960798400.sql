INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643414073960798400');

UPDATE `quest_template_addon` SET `PrevQuestID` = 0, `ExclusiveGroup` = 12932 WHERE `ID` = 12932;
DELETE FROM `quest_template_addon` WHERE `ID` = 12954;
INSERT INTO `quest_template_addon` (`ID`, `PrevQuestID`, `ExclusiveGroup`, `SpecialFlags`) VALUES
(12954, 9977, 12932, 2);
