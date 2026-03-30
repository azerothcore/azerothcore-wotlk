-- DB update 2025_11_29_01 -> 2025_11_29_02
--
UPDATE `quest_template` SET `RewardNextQuest` = 0 WHERE (`ID` = 11287);
UPDATE `quest_template_addon` SET `NextQuestID` = 0 WHERE (`ID` = 11287);
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 11287 WHERE `ID` IN (11287, 11286);
