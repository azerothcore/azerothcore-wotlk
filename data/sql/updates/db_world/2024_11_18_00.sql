-- DB update 2024_11_17_02 -> 2024_11_18_00
--
-- Issue: 20606 (Vital Supplies)
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 1395);

-- Issue: 20607 (Report to Mountaineer Rockgar)
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 455);
