-- DB update 2026_08_19_02 -> 2026_08_19_03
--
UPDATE `quest_template_addon` SET `NextQuestID` = 0 WHERE (`ID` = 12223);
UPDATE `quest_template_addon` SET `NextQuestID` = 0 WHERE (`ID` = 12222);
