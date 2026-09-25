-- DB update 2025_11_16_01 -> 2025_11_16_02
--
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 12827);
