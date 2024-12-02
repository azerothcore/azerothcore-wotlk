-- DB update 2024_12_02_00 -> 2024_12_02_01
--
-- The Crown of Will (1/5) requirement removed from The Crown of Will (2/5)
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 518);
