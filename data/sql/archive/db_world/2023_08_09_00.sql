-- DB update 2023_08_08_00 -> 2023_08_09_00
--
UPDATE `quest_template_addon` SET `RequiredMaxRepFaction` = 0, `RequiredMaxRepValue` = 0 WHERE `ID` IN (10106, 10110);
UPDATE `quest_template_addon` SET `PrevQuestID` = 10143 WHERE (`ID` = 13408);
UPDATE `quest_template_addon` SET `PrevQuestID` = 10124 WHERE (`ID` = 13409);
