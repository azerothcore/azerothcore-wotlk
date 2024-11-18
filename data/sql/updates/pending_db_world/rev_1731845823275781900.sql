--
-- Issue: 20606 (Vital Supplies)
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 1395);

-- Issue: 20607 (Report to Mountaineer Rockgar)
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 455);
