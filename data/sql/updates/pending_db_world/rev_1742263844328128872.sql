-- fixes prerequisite for quest Loyal Companions
-- closes #21552
UPDATE `quest_template_addon` SET `PrevQuestID` = 12863 WHERE (`ID` = 12865);
